package com.courtpicker.courtpicker;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Court;
import com.courtpicker.model.CourtCategory;
import com.courtpicker.model.SingleReservation;
import com.courtpicker.model.SubscriptionReservationPeriod;
import com.courtpicker.uimodel.TimeSlot;
import com.courtpicker.uimodel.Utilization;
import com.sun.net.httpserver.Authenticator.Success;

@Component("utilizationCalculator")
@Scope("prototype")
public class UtilizationCalculator {
    
    public List<TimeSlot> calculateReservableTimeSlots(String bookingFromTime, String bookingToTime, int bookingUnit,
            List<Integer> freeCourtIds) throws ParseException {
        List<TimeSlot> timeSlots = new ArrayList<TimeSlot>();
        
        SimpleDateFormat inputFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        SimpleDateFormat outputFormat = new SimpleDateFormat("HH:mm");
        Calendar calendar = new GregorianCalendar();
        
        Date fromTime = inputFormat.parse("01.01.2014 " + bookingFromTime);
        Date toTime = inputFormat.parse("01.01.2014 " + bookingToTime);
        
        if (bookingFromTime.equals(bookingToTime)) {
            calendar.setTime(toTime);
            calendar.add(Calendar.DAY_OF_MONTH, 1);
            toTime = calendar.getTime();
        }
        
        Date startTime = (Date) fromTime.clone();
        Date endTime = (Date) startTime.clone();
        
        while (!endTime.after(toTime)) {
            calendar.setTime(startTime);
            calendar.add(Calendar.MINUTE, bookingUnit);
            endTime = calendar.getTime();
            if (!endTime.after(toTime)) {
                TimeSlot timeSlot = new TimeSlot(outputFormat.format(startTime), outputFormat.format(endTime));
                timeSlot.setFreeCourtIds(new ArrayList<Integer>(freeCourtIds));                
                timeSlots.add(timeSlot);
            }
            startTime = (Date) endTime.clone();
        }
        
        return timeSlots;
    }
    
    public List<Utilization> calculateDayUtilization(CourtCategory courtCategory, List<Court> courts, 
            Date startDate, Date endDate, Date currentDate,
            List<SingleReservation> singleReservations, List<SubscriptionReservationPeriod> subscrReservations) throws ParseException {        
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        Calendar cal = new GregorianCalendar();

    	List<Integer> courtIds = new ArrayList<Integer>();
        for (Court court : courts) {
            courtIds.add(court.getId());
        }
        
        List<Utilization> utilizations = new ArrayList<Utilization>();
        cal.setTime(startDate);
        
        while (startDate.before(endDate)) {
            Utilization util = createEmptyUtilization(startDate, dateFormat.format(startDate), courtCategory, courtIds);
            utilizations.add(util);
            cal.add(Calendar.DAY_OF_MONTH, 1);
            startDate = cal.getTime();
        }
        
        for (Utilization utilization : utilizations) {
            considerCurrentDate(utilization, currentDate);
        }
        
        for (SingleReservation reservation : singleReservations) {
            for (Utilization utilization : utilizations) {
            	if (utilization.getDate().equals(dateFormat.format(reservation.getFromDate()))) {
            		for (TimeSlot timeSlot : utilization.getTimeSlots()) {
            		    if (doesSingleReservationMatchTimeSlot(timeSlot, utilization.getDate(), reservation)) {
                            applySingleReservationToTimeSlot(timeSlot, reservation, courts.size());
            		    }            		    
            		}
            	}
            }
        }
        
        // TODO: abo-reservations
        
        for (Utilization utilization : utilizations) {
            calculateMaxSlots(utilization);
        }

        return utilizations;
    }
  
    public Utilization calculateCourtUtilization(Court court, Date date, CourtCategory courtCategory, Date currentDate,
        List<SingleReservation> singleReservations, List<SubscriptionReservationPeriod> subscrReservations) throws ParseException {
        
        List<Integer> courtIds = new ArrayList<Integer>();
        courtIds.add(court.getId());
        Utilization utilization = createEmptyUtilization(date, court.getName(), courtCategory, courtIds);
        considerCurrentDate(utilization, currentDate);
        
        for (SingleReservation reservation : singleReservations) {
            for (TimeSlot timeSlot : utilization.getTimeSlots()) {
                if (doesSingleReservationMatchTimeSlot(timeSlot, utilization.getDate(), reservation)) {
                    applySingleReservationToTimeSlot(timeSlot, reservation, 1);
                }
            }
        }
        
        calculateMaxSlots(utilization);

        return utilization;
    }
    
    private void calculateMaxSlots(Utilization utilization) {
        int resultTimeSlotIndex = 0;
        int compareTimeSlotIndex = 0;
        List<Integer> freeCourtIds = new ArrayList<Integer>();
        
        for (TimeSlot timeSlot : utilization.getTimeSlots()) {
            Integer maxSlots = 0;
            Map<Integer, Integer> maxSlotsPerCourt = new HashMap<Integer, Integer>();
            freeCourtIds = timeSlot.getFreeCourtIds();
                            
            while (freeCourtIds.size() > 0 && utilization.getTimeSlots().size() > compareTimeSlotIndex) {
                List<Integer> intersectFreeCourtIds = new ArrayList<Integer>();
                List<Integer> nextFreeCourtIds = utilization.getTimeSlots().get(compareTimeSlotIndex).getFreeCourtIds();
                for (Integer freeCourtId : freeCourtIds) {
                    if (nextFreeCourtIds.contains(freeCourtId)) {
                        intersectFreeCourtIds.add(freeCourtId);
                    }
                }
                freeCourtIds = intersectFreeCourtIds;

                if (freeCourtIds.size() > 0) {
                    maxSlots++;                    
                    
                    for (Integer freeCourtId : freeCourtIds) {
                        if (!maxSlotsPerCourt.containsKey(freeCourtId)) {
                            maxSlotsPerCourt.put(freeCourtId, 1);
                        }
                        else {
                            maxSlotsPerCourt.put(freeCourtId, maxSlotsPerCourt.get(freeCourtId) + 1);
                        }
                    }
                }
                
                compareTimeSlotIndex++;
            }
            
            timeSlot.setMaxSlots(maxSlots);
            timeSlot.setMaxSlotsPerCourt(maxSlotsPerCourt);
            
            resultTimeSlotIndex++;
            compareTimeSlotIndex = resultTimeSlotIndex;
        }
    }
    
    private Utilization createEmptyUtilization(Date date, String name, CourtCategory courtCategory, List<Integer> courtIds) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        
        Utilization util = new Utilization();
        util.setDate(dateFormat.format(date));
        util.setName(name);
        List<TimeSlot> emptyTimeSlots = calculateReservableTimeSlots(courtCategory.getBookableFromTime(), 
                courtCategory.getBookableToTime(), courtCategory.getBookingUnit(), courtIds);
        util.setTimeSlots(emptyTimeSlots);
        return util;
    }
        
    private void considerCurrentDate(Utilization utilization, Date currentDate) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        
        if (utilization.getDate().equals(dateFormat.format(currentDate))) {
            utilization.setIsCurrentDate(true);
        }
        for (TimeSlot timeSlot : utilization.getTimeSlots()) {
            Date timeSlotBeginDate = dateTimeFormat.parse(utilization.getDate() + " " + timeSlot.getFromTime());
            if (timeSlotBeginDate.before(currentDate)) {
                timeSlot.setIsPast(true);
            }
        }
    }
    
    private Boolean doesSingleReservationMatchTimeSlot(TimeSlot timeSlot, String timeSlotDateString, SingleReservation reservation) throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        
        Date timeSlotFromDate = dateTimeFormat.parse(timeSlotDateString + " " + timeSlot.getFromTime());
        Date timeSlotToDate = dateTimeFormat.parse(timeSlotDateString + " " + timeSlot.getToTime());
        
        if (reservation.getToDate().after(timeSlotFromDate) && reservation.getFromDate().before(timeSlotToDate)) {
            return true;
        }
        
        return false;
    }
    
    private void applySingleReservationToTimeSlot(TimeSlot timeSlot, SingleReservation reservation, Integer initialFreeCourts) {
        List<Integer> freeCourts = timeSlot.getFreeCourtIds();                          
        freeCourts.remove(reservation.getCourtId());
        Integer nrOfFreeCourts = freeCourts.size();
        
        if (nrOfFreeCourts == 0) {
            timeSlot.setOccupied(true);
            timeSlot.setOccupyType("SINGLE");
            if (initialFreeCourts == 1) {
                timeSlot.setCaption(reservation.getDisplayName());
            }
        }
        
        Double utilization = 1 - ((double) nrOfFreeCourts / (double) initialFreeCourts);
        timeSlot.setUtilization(utilization);
    }
}
