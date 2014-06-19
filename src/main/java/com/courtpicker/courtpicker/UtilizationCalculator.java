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
import com.courtpicker.model.SubscriptionReservation;
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
            List<SingleReservation> singleReservations, List<SubscriptionReservation> subscriptionReservations) throws ParseException {        
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
        
        for (SubscriptionReservation reservation : subscriptionReservations) {
            for (Utilization utilization : utilizations) {
                if (doesSubscriptionReservationMatchDate(reservation, utilization.getDate())) {
                    for (TimeSlot timeSlot : utilization.getTimeSlots()) {
                        if (doesSubscriptionReservationMatchTimeSlot(timeSlot, utilization.getDate(), reservation)) {
                            applySubscriptionReservationToTimeSlot(timeSlot, reservation, courts.size());
                        }                       
                    }
                }
            }
        }        
        
        for (Utilization utilization : utilizations) {
            calculateMaxSlots(utilization);
        }

        return utilizations;
    }
  
    public Utilization calculateCourtUtilization(Court court, Date date, CourtCategory courtCategory, Date currentDate,
        List<SingleReservation> singleReservations, List<SubscriptionReservation> subscriptionReservations) throws ParseException {
        
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
        
        for (SubscriptionReservation reservation : subscriptionReservations) {
            if (doesSubscriptionReservationMatchDate(reservation, utilization.getDate())) {
                for (TimeSlot timeSlot : utilization.getTimeSlots()) {
                    if (doesSubscriptionReservationMatchTimeSlot(timeSlot, utilization.getDate(), reservation)) {
                        applySubscriptionReservationToTimeSlot(timeSlot, reservation, 1);
                    }                       
                }
            }
        }        
        
        calculateMaxSlots(utilization);

        return utilization;
    }
    
    public List<Utilization> calculateSubscriptionAvailabilityUtilization(CourtCategory courtCategory, List<Court> courts, 
            List<SingleReservation> singleReservations, List<SubscriptionReservation> subscrReservations) throws ParseException {
        /*
        List<Integer> courtIds = new ArrayList<Integer>();
        for (Court court : courts) {
            courtIds.add(court.getId());
        }
        Date irrelevantDate = new Date();
        
        HashMap<Integer, Utilization> utilizations = new HashMap<Integer, Utilization>();
        // utilizations Mon-Sun
        utilizations.put(2, createEmptyUtilization(irrelevantDate, "Mon", courtCategory, courtIds));
        utilizations.put(3, createEmptyUtilization(irrelevantDate, "Tue", courtCategory, courtIds));
        utilizations.put(4, createEmptyUtilization(irrelevantDate, "Wed", courtCategory, courtIds));
        utilizations.put(5, createEmptyUtilization(irrelevantDate, "Thu", courtCategory, courtIds));
        utilizations.put(6, createEmptyUtilization(irrelevantDate, "Fri", courtCategory, courtIds));
        utilizations.put(7, createEmptyUtilization(irrelevantDate, "Sat", courtCategory, courtIds));
        utilizations.put(1, createEmptyUtilization(irrelevantDate, "Sun", courtCategory, courtIds));
        
        // apply single reservations
        Calendar cal = new GregorianCalendar();
        for (SingleReservation reservation : singleReservations) {
            cal.setTime(reservation.getFromDate());
            Integer dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
            Utilization utilization = utilizations.get(dayOfWeek);
                    
            for (TimeSlot timeSlot : utilization.getTimeSlots()) {
                if (doesSingleReservationMatchTimeSlot(timeSlot, utilization.getDate(), reservation)) {
                    applySingleReservationToTimeSlot(timeSlot, reservation, courts.size());
                }                       
            }
        }
        
        // apply subscription reservations
        
        */
        throw new NotImplementedException();
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
    
    private boolean doesSubscriptionReservationMatchDate(SubscriptionReservation reservation, String date) throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        Calendar cal = new GregorianCalendar();
        
        Date subscriptionStartDate = dateTimeFormat.parse(reservation.getPeriodStart() + " 00:00");
        Date subscriptionEndDate = dateTimeFormat.parse(reservation.getPeriodEnd() + " 23:59");
        Date checkDate = dateTimeFormat.parse(date + " 12:00");
        
        cal.setTime(subscriptionStartDate);
        int subscriptionWeekDay = cal.get(Calendar.DAY_OF_WEEK);
        cal.setTime(checkDate);
        int checkDateWeekDay = cal.get(Calendar.DAY_OF_WEEK);
        
        if (subscriptionStartDate.before(checkDate) && subscriptionEndDate.after(checkDate) && subscriptionWeekDay == checkDateWeekDay) {
            return true;
        }
        
        return false;
    }
    
    private Boolean doesSubscriptionReservationMatchTimeSlot(TimeSlot timeSlot, String timeSlotDateString, SubscriptionReservation reservation) throws ParseException {
        if (!doesSubscriptionReservationMatchDate(reservation, timeSlotDateString)) {
            return false;
        }
        
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        
        Date timeSlotFromDate = dateTimeFormat.parse(timeSlotDateString + " " + timeSlot.getFromTime());
        Date timeSlotToDate = dateTimeFormat.parse(timeSlotDateString + " " + timeSlot.getToTime());
        Date reservationFromDate = dateTimeFormat.parse(timeSlotDateString + " " + reservation.getFromTime());
        Date reservationToDate = dateTimeFormat.parse(timeSlotDateString + " " + reservation.getToTime());
        
        if (reservationToDate.after(timeSlotFromDate) && reservationFromDate.before(timeSlotToDate)) {
            return true;
        }
        
        return false;
    }
    
    private void applySingleReservationToTimeSlot(TimeSlot timeSlot, SingleReservation reservation, Integer initialFreeCourts) {
        applyReservationToTimeSlot(timeSlot, initialFreeCourts, reservation.getCourtId(), reservation.getDisplayName(), "SINGLE");
    }
    
    private void applySubscriptionReservationToTimeSlot(TimeSlot timeSlot, SubscriptionReservation reservation, Integer initialFreeCourts) {
        applyReservationToTimeSlot(timeSlot, initialFreeCourts, reservation.getCourtId(), reservation.getDisplayName(), "SUBSCRIPTION");
    }
    
    private void applyReservationToTimeSlot(TimeSlot timeSlot, Integer initialFreeCourts, Integer resCourtId, String resName, String resOccupyType) {
        List<Integer> freeCourts = timeSlot.getFreeCourtIds();                          
        freeCourts.remove(resCourtId);
        Integer nrOfFreeCourts = freeCourts.size();
        
        if (nrOfFreeCourts == 0) {
            timeSlot.setOccupied(true);
            if (initialFreeCourts == 1) {
                timeSlot.setCaption(resName);
                timeSlot.setOccupyType(resOccupyType);
            }
        }
        
        Double utilization = 1 - ((double) nrOfFreeCourts / (double) initialFreeCourts);
        timeSlot.setUtilization(utilization);
    }
    
}
