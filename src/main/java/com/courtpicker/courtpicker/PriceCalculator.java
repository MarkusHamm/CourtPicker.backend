package com.courtpicker.courtpicker;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Rate;
import com.courtpicker.tools.DateHelper;

@Component("priceCalculator")
@Scope("prototype")
public class PriceCalculator {
    @Inject
    private DateHelper dateHelper;

    private SimpleDateFormat dateFormat;
    private SimpleDateFormat dateTimeFormat;    
    
    public PriceCalculator() {
        dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
    }
    
    public BigDecimal calculateReservationPrice(Date fromDate, Date toDate, Date reservationDate, 
            List<Integer> userGroupIds, Integer bookingUnit, List<Rate> rates) throws ParseException {
        BigDecimal price = new BigDecimal(0);
        Integer nrOfBookingSlots = getNrOfBookingSlots(fromDate, toDate, bookingUnit);
        
        for (int slotNr=1; slotNr <= nrOfBookingSlots; slotNr++) {
            Date slotFromTime = dateHelper.addMinutes(fromDate, bookingUnit * (slotNr - 1));
            Date slotToTime = dateHelper.addMinutes(fromDate, bookingUnit * slotNr);
            
            List<Rate> matchingRates = identifyMatchingRates(rates, slotFromTime, slotToTime, userGroupIds);
            Rate accurateRate = identifyAccurateRate(matchingRates);
            
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
    
    private List<Rate> identifyMatchingRates(List<Rate> rates, Date fromDate, Date toDate,
            List<Integer> userGroupIds) throws ParseException {
        List<Rate> result = new ArrayList<Rate>();
        
        for (Rate rate : rates) {
            if (doesRateMatchTimeConstraint(rate, fromDate, toDate) &&
                    doesRateMatchWeekDayConstraint(rate, fromDate, toDate) &&
                    doesRateMatchDateConstraint(rate, fromDate, toDate) &&
                    doesRateMatchUserGroupConstraint(rate, userGroupIds)) {
                result.add(rate);
            }
        }

        return result;
    }
    
    private boolean doesRateMatchTimeConstraint(Rate rate, Date fromDate, Date toDate) throws ParseException {
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
    
    private boolean doesRateMatchWeekDayConstraint(Rate rate, Date fromDate, Date toDate) throws ParseException {
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

    private boolean doesRateMatchDateConstraint(Rate rate, Date fromDate, Date toDate) throws ParseException {
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
    
    private boolean doesRateMatchUserGroupConstraint(Rate rate, List<Integer> userGroupIds) {
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
    
    private Rate identifyAccurateRate(List<Rate> matchingRates) {
        Rate result = null;
        Integer resultRating = -1;
        
        for (Rate rate : matchingRates) {
            Integer rateEvaluation = evaluateRate(rate);
            if (rateEvaluation > resultRating) {
                result = rate;
                resultRating = rateEvaluation;
            }
        }

        return result;
    }
    
    private Integer evaluateRate(Rate rate) {
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
