package com.courtpicker.courtpicker;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.courtpicker.model.SingleRate;
import com.courtpicker.tools.DateHelper;

@Component("priceCalculator")
@Scope("prototype")
public class PriceCalculator {
    @Inject
    private DateHelper dateHelper;

    private SimpleDateFormat dateFormat;
    private SimpleDateFormat dateWithoutYearFormat;
    private SimpleDateFormat timeFormat;
    private SimpleDateFormat dateTimeFormat;    
    
    public PriceCalculator() {
        dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        dateWithoutYearFormat = new SimpleDateFormat("dd.MM.");
        timeFormat = new SimpleDateFormat("HH:mm");
        dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
    }
    
    public BigDecimal calculateSingleReservationPrice(Date fromDate, Date toDate, Date reservationDate, 
            List<Integer> userGroupIds, Integer bookingUnit, List<SingleRate> rates) throws ParseException {
        BigDecimal price = new BigDecimal(0);
        Integer nrOfBookingSlots = getNrOfBookingSlots(fromDate, toDate, bookingUnit);
        
        for (int slotNr=1; slotNr <= nrOfBookingSlots; slotNr++) {
            Date slotFromTime = dateHelper.addMinutes(fromDate, bookingUnit * (slotNr - 1));
            Date slotToTime = dateHelper.addMinutes(fromDate, bookingUnit * slotNr);
            
            List<SingleRate> matchingRates = identifyMatchingRates(rates, slotFromTime, slotToTime, userGroupIds);
            SingleRate accurateRate = identifyAccurateRate(matchingRates);
            
            price = price.add(accurateRate.getPrice());
        }
        
        return price;
    }

    private Integer getNrOfBookingSlots(Date fromDate, Date toDate, Integer bookingUnit) {
        Integer result = 0;
        
        while (fromDate.before(toDate)) {
            result++;
            fromDate = dateHelper.addMinutes(fromDate, bookingUnit);
        }
        
        return result;
    }
    
    private List<SingleRate> identifyMatchingRates(List<SingleRate> rates, Date fromDate, Date toDate,
            List<Integer> userGroupIds) throws ParseException {
        List<SingleRate> result = new ArrayList<SingleRate>();
        
        for (SingleRate rate : rates) {
            if (doesRateMatchTimeConstraint(rate, fromDate, toDate) &&
                    doesRateMatchWeekDayConstraint(rate, fromDate, toDate) &&
                    doesRateMatchDateConstraint(rate, fromDate, toDate) &&
                    doesRateMatchUserGroupConstraint(rate, userGroupIds)) {
                result.add(rate);
            }
        }

        return result;
    }
    
    private boolean doesRateMatchTimeConstraint(SingleRate rate, Date fromDate, Date toDate) throws ParseException {
        if (!rate.getConstrainTime()) {
            return true;
        }
        
        Date rateFromDate = dateTimeFormat.parse(dateFormat.format(fromDate) + " " + rate.getcTimeFrom());
        Date rateToDate = dateTimeFormat.parse(dateFormat.format(fromDate) + " " + rate.getcTimeTo());

        if (rateToDate.after(fromDate) && rateFromDate.before(toDate)) {
            return true;
        }
        
        return false;
    }
    
    private boolean doesRateMatchWeekDayConstraint(SingleRate rate, Date fromDate, Date toDate) throws ParseException {
        if (!rate.getConstrainWeekDay()) {
            return true;
        }

        if (rate.getcMon() && dateHelper.getDayOfWeek(fromDate) == Calendar.MONDAY ||
                rate.getcTue() && dateHelper.getDayOfWeek(fromDate) == Calendar.TUESDAY ||
                rate.getcWed() && dateHelper.getDayOfWeek(fromDate) == Calendar.WEDNESDAY ||
                rate.getcThu() && dateHelper.getDayOfWeek(fromDate) == Calendar.THURSDAY ||
                rate.getcFri() && dateHelper.getDayOfWeek(fromDate) == Calendar.FRIDAY ||
                rate.getcSat() && dateHelper.getDayOfWeek(fromDate) == Calendar.SATURDAY ||
                rate.getcSun() && dateHelper.getDayOfWeek(fromDate) == Calendar.SUNDAY) {
            return true;
        }
        
        return false;
    }

    private boolean doesRateMatchDateConstraint(SingleRate rate, Date fromDate, Date toDate) throws ParseException {
        if (!rate.getConstrainDate()) {
            return true;
        }
                
        int reservationYear = dateHelper.getYear(fromDate);
        Date rateFromDate = dateTimeFormat.parse(rate.getcDateFrom() + reservationYear + " 00:00");
        Date rateToDate = dateTimeFormat.parse(rate.getcDateTo() + reservationYear + " 23:59");
        if (rateFromDate.after(rateToDate)) {
            if (rateToDate.before(fromDate)) {
                rateToDate = dateHelper.setYear(rateToDate, reservationYear + 1);
            }
            else {
                rateFromDate = dateHelper.setYear(rateFromDate, reservationYear - 1);
            }
        }
        
        if (rateToDate.after(fromDate) && rateFromDate.before(toDate)) {
            return true;
        }
        
        return false;
    }
    
    private boolean doesRateMatchUserGroupConstraint(SingleRate rate, List<Integer> userGroupIds) {
        if (!rate.getConstrainUserGroup()) {
            return true;
        }
        
        for (Integer rateUserGroup : rate.getcUserGroupIds()) {
            if (userGroupIds.contains(rateUserGroup)) {
                return true;
            }
        }
        
        return false;
    }
    
    private SingleRate identifyAccurateRate(List<SingleRate> matchingRates) {
        SingleRate result = null;
        Integer resultRating = -1;
        
        for (SingleRate rate : matchingRates) {
            Integer rateEvaluation = evaluateRate(rate);
            if (rateEvaluation > resultRating) {
                result = rate;
                resultRating = rateEvaluation;
            }
        }

        return result;
    }
    
    private Integer evaluateRate(SingleRate rate) {
        Integer result = 0;
        
        if (rate.getConstrainTime()) {
            result += 1;
        }
        if (rate.getConstrainWeekDay()) {
            result += 10;
        }
        if (rate.getConstrainDate()) {
            result += 100;
        }
        if (rate.getConstrainUserGroup()) {
            result += 1000;
        }
        
        return result;
    }

    // ---------- getter / setter ----------
    
    public DateHelper getDateHelper() {
        return dateHelper;
    }

    public void setDateHelper(DateHelper dateHelper) {
        this.dateHelper = dateHelper;
    }
}
