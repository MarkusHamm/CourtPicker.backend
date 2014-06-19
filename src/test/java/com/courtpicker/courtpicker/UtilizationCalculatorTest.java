package com.courtpicker.courtpicker;

import static org.junit.Assert.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import com.courtpicker.model.Court;
import com.courtpicker.model.CourtCategory;
import com.courtpicker.model.SingleReservation;
import com.courtpicker.model.SubscriptionReservation;
import com.courtpicker.model.SubscriptionReservationPeriod;
import com.courtpicker.uimodel.TimeSlot;
import com.courtpicker.uimodel.Utilization;

public class UtilizationCalculatorTest {
    private UtilizationCalculator calculator;
    
    public UtilizationCalculatorTest() {
        this.calculator = new UtilizationCalculator();
    }
    
    @Test
    public void calculateReservableTimeSlots_60minUnitCalculatesCorrect() throws ParseException {
        List<Integer> freeCourtIds = new ArrayList<Integer>();
        freeCourtIds.add(1);
        List<TimeSlot> result = calculator.calculateReservableTimeSlots("08:00", "13:00", 60, freeCourtIds);
        
        List<TimeSlot> expectedResult = new ArrayList<TimeSlot>();
        expectedResult.add(new TimeSlot("08:00", "09:00"));
        expectedResult.add(new TimeSlot("09:00", "10:00"));
        expectedResult.add(new TimeSlot("10:00", "11:00"));
        expectedResult.add(new TimeSlot("11:00", "12:00"));
        expectedResult.add(new TimeSlot("12:00", "13:00"));
        
        for (TimeSlot item : expectedResult) {
            item.setFreeCourtIds(freeCourtIds);
        }
        
        assertEquals(expectedResult, result);
    }
    
    @Test
    public void calculateReservableTimeSlots_30minUnitCalculatesCorrect() throws ParseException {
        List<TimeSlot> result = calculator.calculateReservableTimeSlots("08:00", "10:00", 30, new ArrayList<Integer>());
        
        List<TimeSlot> expectedResult = new ArrayList<TimeSlot>();
        expectedResult.add(new TimeSlot("08:00", "08:30"));
        expectedResult.add(new TimeSlot("08:30", "09:00"));
        expectedResult.add(new TimeSlot("09:00", "09:30"));
        expectedResult.add(new TimeSlot("09:30", "10:00"));
        
        assertEquals(expectedResult, result);        
    }

    @Test
    public void calculateReservableTimeSlots_NotFittingEndDateCalculatesCorrect() throws ParseException {
        List<TimeSlot> result = calculator.calculateReservableTimeSlots("08:00", "11:30", 60, new ArrayList<Integer>());
        
        List<TimeSlot> expectedResult = new ArrayList<TimeSlot>();
        expectedResult.add(new TimeSlot("08:00", "09:00"));
        expectedResult.add(new TimeSlot("09:00", "10:00"));
        expectedResult.add(new TimeSlot("10:00", "11:00"));
        
        assertEquals(expectedResult, result);                
    }
    
    @Test
    public void calculateReservableTimeSlots_equalStartAndEndResultsIn24hourSlots() throws ParseException {
        List<TimeSlot> result = calculator.calculateReservableTimeSlots("00:00", "00:00", 120, new ArrayList<Integer>());
        
        List<TimeSlot> expectedResult = new ArrayList<TimeSlot>();
        expectedResult.add(new TimeSlot("00:00", "02:00"));
        expectedResult.add(new TimeSlot("02:00", "04:00"));
        expectedResult.add(new TimeSlot("04:00", "06:00"));
        expectedResult.add(new TimeSlot("06:00", "08:00"));
        expectedResult.add(new TimeSlot("08:00", "10:00"));
        expectedResult.add(new TimeSlot("10:00", "12:00"));
        expectedResult.add(new TimeSlot("12:00", "14:00"));
        expectedResult.add(new TimeSlot("14:00", "16:00"));
        expectedResult.add(new TimeSlot("16:00", "18:00"));
        expectedResult.add(new TimeSlot("18:00", "20:00"));
        expectedResult.add(new TimeSlot("20:00", "22:00"));
        expectedResult.add(new TimeSlot("22:00", "00:00"));
        
        assertEquals(expectedResult, result);        
    }
        
    @Test
    public void calculateReservableTimeSlots_freeCourtsArePassedByValue() throws ParseException {
    	List<Integer> freeCourtIds = new ArrayList<Integer>();
    	freeCourtIds.add(1);
    	freeCourtIds.add(2);
    	freeCourtIds.add(3);
    	
        List<TimeSlot> timeSlots = calculator.calculateReservableTimeSlots("08:00", "10:00", 60, freeCourtIds);
        TimeSlot slot8 = timeSlots.get(0);
        TimeSlot slot9 = timeSlots.get(1);

        assertEquals(Arrays.asList(1,2,3), slot8.getFreeCourtIds());
        assertEquals(Arrays.asList(1,2,3), slot9.getFreeCourtIds());
        
        slot8.getFreeCourtIds().remove(new Integer(2));

        assertEquals(Arrays.asList(1,3), slot8.getFreeCourtIds());
        assertEquals(Arrays.asList(1,2,3), slot9.getFreeCourtIds());        
    }
    
    
    @Test
    public void calculateDayUtilization_noReservationsReturnEmptyUtilizationObjects() throws ParseException {
        Court court1 = new Court();
        court1.setId(1);
        Court court2 = new Court();
        court2.setId(2);
        List<Court> courts = new ArrayList<Court>();
        courts.add(court1);
        courts.add(court2);
        
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setBookableFromTime("08:00");
        courtCategory.setBookableToTime("12:00");
        courtCategory.setBookingUnit(60);
        
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        
        List<Utilization> utilizations = calculator.calculateDayUtilization(courtCategory, courts, 
                dateTimeFormat.parse("01.01.2014 00:00"), dateTimeFormat.parse("03.01.2014 23:59"), new Date(),
                new ArrayList<SingleReservation>(), new ArrayList<SubscriptionReservation>());
        
        assertEquals(3, utilizations.size());
        
        Utilization uDay1 = utilizations.get(0);
        Utilization uDay2 = utilizations.get(1);
        Utilization uDay3 = utilizations.get(2);
        
        assertEquals("01.01.2014", uDay1.getDate());
        assertEquals("02.01.2014", uDay2.getDate());
        assertEquals("03.01.2014", uDay3.getDate());
        
        assertEquals("01.01.2014", uDay1.getName());
        assertEquals("02.01.2014", uDay2.getName());
        assertEquals("03.01.2014", uDay3.getName());
        
        assertEquals(4, uDay1.getTimeSlots().size());
        assertEquals(4, uDay2.getTimeSlots().size());
        assertEquals(4, uDay3.getTimeSlots().size());
        
        List<Integer> expectedCourtIds = new ArrayList<Integer>();
        expectedCourtIds.add(1);
        expectedCourtIds.add(2);
        assertEquals(false, uDay1.getTimeSlots().get(0).getOccupied());
        assertEquals("", uDay1.getTimeSlots().get(0).getCaption());
        assertEquals("", uDay1.getTimeSlots().get(0).getOccupyType());
        assertEquals(expectedCourtIds, uDay1.getTimeSlots().get(0).getFreeCourtIds());
        assertEquals(new Double(0), uDay1.getTimeSlots().get(0).getUtilization());
    }
    
    @Test
    public void calculateDayUtilization_isPastAndIsCurrentDateSetCorrectly() throws ParseException {
        Court court1 = new Court();
        court1.setId(1);
        Court court2 = new Court();
        court2.setId(2);
        List<Court> courts = new ArrayList<Court>();
        courts.add(court1);
        courts.add(court2);
        
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setBookableFromTime("08:00");
        courtCategory.setBookableToTime("12:00");
        courtCategory.setBookingUnit(60);
        
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        
        List<Utilization> utilizations = calculator.calculateDayUtilization(courtCategory, courts, 
                dateTimeFormat.parse("01.01.2014 00:00"), dateTimeFormat.parse("03.01.2014 23:59"), dateTimeFormat.parse("02.01.2014 10:21"), 
                new ArrayList<SingleReservation>(), new ArrayList<SubscriptionReservation>());
        
        Utilization uDay1 = utilizations.get(0);
        Utilization uDay2 = utilizations.get(1);
        Utilization uDay3 = utilizations.get(2);

        assertEquals(false, uDay1.getIsCurrentDate());
        assertEquals(true, uDay2.getIsCurrentDate());
        assertEquals(false, uDay3.getIsCurrentDate());
        
        assertEquals(true, uDay1.getTimeSlots().get(0).getIsPast());
        assertEquals(true, uDay1.getTimeSlots().get(1).getIsPast());
        assertEquals(true, uDay1.getTimeSlots().get(2).getIsPast());
        assertEquals(true, uDay1.getTimeSlots().get(3).getIsPast());
        assertEquals(true, uDay2.getTimeSlots().get(0).getIsPast());
        assertEquals(true, uDay2.getTimeSlots().get(1).getIsPast());
        assertEquals(true, uDay2.getTimeSlots().get(2).getIsPast());
        assertEquals(false, uDay2.getTimeSlots().get(3).getIsPast());
        assertEquals(false, uDay3.getTimeSlots().get(0).getIsPast());
        assertEquals(false, uDay3.getTimeSlots().get(1).getIsPast());
        assertEquals(false, uDay3.getTimeSlots().get(2).getIsPast());
        assertEquals(false, uDay3.getTimeSlots().get(3).getIsPast());
    } 
        
    @Test
    public void calculateDayUtilization_singleReservationsProcessedCorrectly() throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");

    	Court court1 = new Court();
        court1.setId(1);
        Court court2 = new Court();
        court2.setId(2);
        List<Court> courts = new ArrayList<Court>();
        courts.add(court1);
        courts.add(court2);
        
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setBookableFromTime("08:00");
        courtCategory.setBookableToTime("18:00");
        courtCategory.setBookingUnit(60);
        
        SingleReservation res1 = new SingleReservation();
        res1.setCourtId(1);
        res1.setFromDate(dateTimeFormat.parse("01.01.2014 08:00"));
        res1.setToDate(dateTimeFormat.parse("01.01.2014 09:00"));
        SingleReservation res2 = new SingleReservation();
        res2.setCourtId(1);
        res2.setFromDate(dateTimeFormat.parse("01.01.2014 10:00"));
        res2.setToDate(dateTimeFormat.parse("01.01.2014 12:00"));
        SingleReservation res3 = new SingleReservation();
        res3.setCourtId(2);
        res3.setFromDate(dateTimeFormat.parse("01.01.2014 10:00"));
        res3.setToDate(dateTimeFormat.parse("01.01.2014 12:00"));
        SingleReservation res4 = new SingleReservation();
        res4.setCourtId(1);
        res4.setFromDate(dateTimeFormat.parse("01.01.2014 13:30"));
        res4.setToDate(dateTimeFormat.parse("01.01.2014 14:30"));
        SingleReservation res5 = new SingleReservation();
        res5.setCourtId(2);
        res5.setFromDate(dateTimeFormat.parse("01.01.2014 16:30"));
        res5.setToDate(dateTimeFormat.parse("01.01.2014 17:00"));
        List<SingleReservation> singleReservations = new ArrayList<SingleReservation>();
        singleReservations.add(res1);
        singleReservations.add(res2);
        singleReservations.add(res3);
        singleReservations.add(res4);
        singleReservations.add(res5);
        
        List<Utilization> utilizations = calculator.calculateDayUtilization(courtCategory, courts, 
                dateTimeFormat.parse("01.01.2014 00:00"), dateTimeFormat.parse("01.01.2014 23:59"), new Date(),
                singleReservations, new ArrayList<SubscriptionReservation>());
        
        List<TimeSlot> timeSlots = utilizations.get(0).getTimeSlots();
        
        TimeSlot ts8to9 = timeSlots.get(0);
        assertEquals(false, ts8to9.getOccupied());
        assertEquals("", ts8to9.getCaption());
        assertEquals(Arrays.asList(2), ts8to9.getFreeCourtIds());
        assertEquals(new Integer(2), ts8to9.getMaxSlots());
        Map<Integer, Integer> maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(2, 2);
        assertEquals(maxSlotsPerCourt, ts8to9.getMaxSlotsPerCourt());
        assertEquals(new Double(0.5), ts8to9.getUtilization());
        
        TimeSlot ts9to10 = timeSlots.get(1);
        assertEquals(false, ts9to10.getOccupied());
        assertEquals("", ts9to10.getCaption());
        assertEquals(Arrays.asList(1,2), ts9to10.getFreeCourtIds());
        assertEquals(new Integer(1), ts9to10.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 1);
        maxSlotsPerCourt.put(2, 1);
        assertEquals(maxSlotsPerCourt, ts9to10.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts9to10.getUtilization());
        
        TimeSlot ts10to11 = timeSlots.get(2);
        assertEquals(true, ts10to11.getOccupied());
        assertEquals("", ts10to11.getCaption());
        assertEquals(Arrays.asList(), ts10to11.getFreeCourtIds());
        assertEquals(new Integer(0), ts10to11.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        assertEquals(maxSlotsPerCourt, ts10to11.getMaxSlotsPerCourt());
        assertEquals(new Double(1), ts10to11.getUtilization());
        
        TimeSlot ts11to12 = timeSlots.get(3);
        assertEquals(true, ts11to12.getOccupied());
        assertEquals("", ts11to12.getCaption());
        assertEquals(Arrays.asList(), ts11to12.getFreeCourtIds());
        assertEquals(new Integer(0), ts11to12.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        assertEquals(maxSlotsPerCourt, ts11to12.getMaxSlotsPerCourt());
        assertEquals(new Double(1), ts11to12.getUtilization());

        TimeSlot ts12to13 = timeSlots.get(4);
        assertEquals(false, ts12to13.getOccupied());
        assertEquals("", ts12to13.getCaption());
        assertEquals(Arrays.asList(1,2), ts12to13.getFreeCourtIds());
        assertEquals(new Integer(4), ts12to13.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 1);
        maxSlotsPerCourt.put(2, 4);
        assertEquals(maxSlotsPerCourt, ts12to13.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts12to13.getUtilization());
        
        TimeSlot ts13to14 = timeSlots.get(5);
        assertEquals(false, ts13to14.getOccupied());
        assertEquals("", ts13to14.getCaption());
        assertEquals(Arrays.asList(2), ts13to14.getFreeCourtIds());
        assertEquals(new Integer(3), ts13to14.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(2, 3);
        assertEquals(maxSlotsPerCourt, ts13to14.getMaxSlotsPerCourt());
        assertEquals(new Double(0.5), ts13to14.getUtilization());
        
        TimeSlot ts14to15 = timeSlots.get(6);
        assertEquals(false, ts14to15.getOccupied());
        assertEquals("", ts14to15.getCaption());
        assertEquals(Arrays.asList(2), ts14to15.getFreeCourtIds());
        assertEquals(new Integer(2), ts14to15.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(2, 2);
        assertEquals(maxSlotsPerCourt, ts14to15.getMaxSlotsPerCourt());
        assertEquals(new Double(0.5), ts14to15.getUtilization());
        
        TimeSlot ts15to16 = timeSlots.get(7);
        assertEquals(false, ts15to16.getOccupied());
        assertEquals("", ts15to16.getCaption());
        assertEquals(Arrays.asList(1,2), ts15to16.getFreeCourtIds());
        assertEquals(new Integer(3), ts15to16.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 3);
        maxSlotsPerCourt.put(2, 1);
        assertEquals(maxSlotsPerCourt, ts15to16.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts15to16.getUtilization());
        
        TimeSlot ts16to17 = timeSlots.get(8);
        assertEquals(false, ts16to17.getOccupied());
        assertEquals("", ts16to17.getCaption());
        assertEquals(Arrays.asList(1), ts16to17.getFreeCourtIds());
        assertEquals(new Integer(2), ts16to17.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 2);
        assertEquals(maxSlotsPerCourt, ts16to17.getMaxSlotsPerCourt());
        assertEquals(new Double(0.5), ts16to17.getUtilization());
        
        TimeSlot ts17to18 = timeSlots.get(9);
        assertEquals(false, ts17to18.getOccupied());
        assertEquals("", ts17to18.getCaption());
        assertEquals(Arrays.asList(1,2), ts17to18.getFreeCourtIds());
        assertEquals(new Integer(1), ts17to18.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 1);
        maxSlotsPerCourt.put(2, 1);
        assertEquals(maxSlotsPerCourt, ts17to18.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts17to18.getUtilization());
    }
    
    @Test
    public void calculateDayUtilization_subscriptionReservationsProcessedCorrectly() throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");

        Court court1 = new Court();
        court1.setId(1);
        Court court2 = new Court();
        court2.setId(2);
        List<Court> courts = new ArrayList<Court>();
        courts.add(court1);
        courts.add(court2);
        
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setBookableFromTime("08:00");
        courtCategory.setBookableToTime("18:00");
        courtCategory.setBookingUnit(60);
        
        SubscriptionReservation res1 = new SubscriptionReservation();
        res1.setCourtId(2);
        res1.setPeriodStart("06.02.2014");
        res1.setPeriodEnd("12.06.2014");
        res1.setFromTime("09:00");
        res1.setToTime("10:00");
        SubscriptionReservation res2 = new SubscriptionReservation();
        res2.setCourtId(1);
        res2.setPeriodStart("29.05.2014");
        res2.setPeriodEnd("19.06.2014");
        res2.setFromTime("09:00");
        res2.setToTime("11:00");
        SubscriptionReservation res3 = new SubscriptionReservation();
        res3.setCourtId(2);
        res3.setPeriodStart("19.06.2014");
        res3.setPeriodEnd("03.07.2014");
        res3.setFromTime("10:00");
        res3.setToTime("12:00");
        SubscriptionReservation res4 = new SubscriptionReservation();
        res4.setCourtId(1);
        res4.setPeriodStart("29.05.2014");
        res4.setPeriodEnd("03.07.2014");
        res4.setFromTime("11:00");
        res4.setToTime("13:00");

        List<SubscriptionReservation> subscriptionReservations = new ArrayList<SubscriptionReservation>();
        subscriptionReservations.add(res1);
        subscriptionReservations.add(res2);
        subscriptionReservations.add(res3);
        subscriptionReservations.add(res4);
        
        List<Utilization> utilizations = calculator.calculateDayUtilization(courtCategory, courts, 
                dateTimeFormat.parse("18.06.2014 00:00"), dateTimeFormat.parse("20.06.2014 23:59"), new Date(),
                new ArrayList<SingleReservation>(), subscriptionReservations);
        
        List<TimeSlot> timeSlots = utilizations.get(1).getTimeSlots();
        
        // Thursday has all bookings
        
        TimeSlot ts8to9 = timeSlots.get(0);
        assertEquals(false, ts8to9.getOccupied());
        assertEquals(Arrays.asList(1,2), ts8to9.getFreeCourtIds());
        assertEquals(new Integer(2), ts8to9.getMaxSlots());
        Map<Integer, Integer> maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 1);
        maxSlotsPerCourt.put(2, 2);
        assertEquals(maxSlotsPerCourt, ts8to9.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts8to9.getUtilization());
        
        TimeSlot ts9to10 = timeSlots.get(1);
        assertEquals(false, ts9to10.getOccupied());
        assertEquals(Arrays.asList(2), ts9to10.getFreeCourtIds());
        assertEquals(new Integer(1), ts9to10.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(2, 1);
        assertEquals(maxSlotsPerCourt, ts9to10.getMaxSlotsPerCourt());
        assertEquals(new Double(0.5), ts9to10.getUtilization());

        TimeSlot ts10to11 = timeSlots.get(2);
        assertEquals(true, ts10to11.getOccupied());
        assertEquals(Arrays.asList(), ts10to11.getFreeCourtIds());
        assertEquals(new Integer(0), ts10to11.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        assertEquals(maxSlotsPerCourt, ts10to11.getMaxSlotsPerCourt());
        assertEquals(new Double(1), ts10to11.getUtilization());

        TimeSlot ts11to12 = timeSlots.get(3);
        assertEquals(true, ts11to12.getOccupied());
        assertEquals(Arrays.asList(), ts11to12.getFreeCourtIds());
        assertEquals(new Integer(0), ts11to12.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        assertEquals(maxSlotsPerCourt, ts11to12.getMaxSlotsPerCourt());
        assertEquals(new Double(1), ts11to12.getUtilization());

        TimeSlot ts12to13 = timeSlots.get(4);
        assertEquals(false, ts12to13.getOccupied());
        assertEquals(Arrays.asList(2), ts12to13.getFreeCourtIds());
        assertEquals(new Integer(6), ts12to13.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(2, 6);
        assertEquals(maxSlotsPerCourt, ts12to13.getMaxSlotsPerCourt());
        assertEquals(new Double(0.5), ts12to13.getUtilization());
        
        TimeSlot ts13to14 = timeSlots.get(5);
        assertEquals(false, ts13to14.getOccupied());
        assertEquals(Arrays.asList(1,2), ts13to14.getFreeCourtIds());
        assertEquals(new Integer(5), ts13to14.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 5);
        maxSlotsPerCourt.put(2, 5);
        assertEquals(maxSlotsPerCourt, ts13to14.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts13to14.getUtilization());
        
        // Wednesday and Friday
        timeSlots = utilizations.get(0).getTimeSlots();
        TimeSlot wednesday8to9 = timeSlots.get(0);
        assertEquals(false, wednesday8to9.getOccupied());
        assertEquals(Arrays.asList(1,2), wednesday8to9.getFreeCourtIds());
        assertEquals(new Integer(10), wednesday8to9.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 10);
        maxSlotsPerCourt.put(2, 10);
        assertEquals(maxSlotsPerCourt, wednesday8to9.getMaxSlotsPerCourt());
        assertEquals(new Double(0), wednesday8to9.getUtilization());
        
        timeSlots = utilizations.get(2).getTimeSlots();
        TimeSlot friday8to9 = timeSlots.get(0);
        assertEquals(false, friday8to9.getOccupied());
        assertEquals(Arrays.asList(1,2), friday8to9.getFreeCourtIds());
        assertEquals(new Integer(10), friday8to9.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 10);
        maxSlotsPerCourt.put(2, 10);
        assertEquals(maxSlotsPerCourt, friday8to9.getMaxSlotsPerCourt());
        assertEquals(new Double(0), friday8to9.getUtilization());        
    }
    
    @Test
    public void calculateDayUtilization_TimeSlotCaptionAndOccupyTypeIsSetCorrectWhenCalculatedForOnlyOneCourt() throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");

        Court court1 = new Court();
        court1.setId(1);
        List<Court> courts = new ArrayList<Court>();
        courts.add(court1);
        
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setBookableFromTime("08:00");
        courtCategory.setBookableToTime("12:00");
        courtCategory.setBookingUnit(60);
        
        SingleReservation res1 = new SingleReservation();
        res1.setCourtId(1);
        res1.setFromDate(dateTimeFormat.parse("01.01.2014 08:00"));
        res1.setToDate(dateTimeFormat.parse("01.01.2014 09:00"));
        res1.setDisplayName("Single Caption");
        
        SubscriptionReservation subRes1 = new SubscriptionReservation();
        subRes1.setCourtId(1);
        subRes1.setPeriodStart("25.12.2013");
        subRes1.setPeriodEnd("08.01.2014");
        subRes1.setFromTime("10:00");
        subRes1.setToTime("11:00");
        subRes1.setDisplayName("Subscription Caption");

        List<SingleReservation> singleReservations = new ArrayList<SingleReservation>();
        singleReservations.add(res1);
        List<SubscriptionReservation> subscriptionReservations = new ArrayList<SubscriptionReservation>();
        subscriptionReservations.add(subRes1);
        
        List<Utilization> utilizations = calculator.calculateDayUtilization(courtCategory, courts, 
                dateTimeFormat.parse("01.01.2014 00:00"), dateTimeFormat.parse("01.01.2014 23:59"), new Date(),
                singleReservations, subscriptionReservations);
        
        List<TimeSlot> timeSlots = utilizations.get(0).getTimeSlots();
        
        TimeSlot ts8to9 = timeSlots.get(0);
        assertEquals("Single Caption", ts8to9.getCaption());
        assertEquals(ts8to9.getOccupyType(), "SINGLE");
        TimeSlot ts9to10 = timeSlots.get(1);
        assertEquals("", ts9to10.getCaption());
        assertEquals("", ts9to10.getOccupyType());
        TimeSlot ts10to11 = timeSlots.get(2);
        assertEquals("Subscription Caption", ts10to11.getCaption());
        assertEquals("SUBSCRIPTION", ts10to11.getOccupyType());
    }
    
    @Test
    public void calculateDayUtilization_TimeSlotCaptionAndOccupyTypeIsSetCorrectWhenCalculatedForMoreThanOneCourt() throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");

        Court court1 = new Court();
        court1.setId(1);
        Court court2 = new Court();
        court2.setId(2);
        List<Court> courts = new ArrayList<Court>();
        courts.add(court1);
        courts.add(court2);
        
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setBookableFromTime("08:00");
        courtCategory.setBookableToTime("12:00");
        courtCategory.setBookingUnit(60);
        
        SingleReservation res1 = new SingleReservation();
        res1.setCourtId(1);
        res1.setFromDate(dateTimeFormat.parse("01.01.2014 08:00"));
        res1.setToDate(dateTimeFormat.parse("01.01.2014 09:00"));
        res1.setDisplayName("My Caption 1");
        
        SingleReservation res2 = new SingleReservation();
        res2.setCourtId(2);
        res2.setFromDate(dateTimeFormat.parse("01.01.2014 08:00"));
        res2.setToDate(dateTimeFormat.parse("01.01.2014 09:00"));
        res2.setDisplayName("My Caption 2");

        List<SingleReservation> singleReservations = new ArrayList<SingleReservation>();
        singleReservations.add(res1);
        singleReservations.add(res2);
        
        List<Utilization> utilizations = calculator.calculateDayUtilization(courtCategory, courts, 
                dateTimeFormat.parse("01.01.2014 00:00"), dateTimeFormat.parse("01.01.2014 23:59"), new Date(),
                singleReservations, new ArrayList<SubscriptionReservation>());
        
        List<TimeSlot> timeSlots = utilizations.get(0).getTimeSlots();
        
        TimeSlot ts8to9 = timeSlots.get(0);
        assertEquals("", ts8to9.getCaption());
        assertEquals("", ts8to9.getOccupyType());
        TimeSlot ts9to10 = timeSlots.get(1);
        assertEquals("", ts9to10.getCaption());
        assertEquals("", ts9to10.getOccupyType());
    }
        
    @Test
    public void calculateCourtUtilization_noReservationReturnEmptyUtilizationObject() throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        
        Court court = new Court();
        court.setName("center court");
        
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setBookableFromTime("09:00");
        courtCategory.setBookableToTime("12:00");
        courtCategory.setBookingUnit(60);
        
        Utilization util = calculator.calculateCourtUtilization(court, new Date(), courtCategory, new Date(), 
                new ArrayList<SingleReservation>(), new ArrayList<SubscriptionReservation>());
        
        assertEquals(dateFormat.format(new Date()), util.getDate());
        assertEquals(court.getName(), util.getName());
        assertTrue(util.getIsCurrentDate());
        assertEquals(3, util.getTimeSlots().size());
    }

    @Test
    public void calculateCourtUtilization_singleReservationsProcessedCorrectly() throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        
        Court court = new Court();
        court.setName("center court");
        court.setId(1);
        
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setBookableFromTime("09:00");
        courtCategory.setBookableToTime("15:00");
        courtCategory.setBookingUnit(60);
        
        SingleReservation res1 = new SingleReservation();
        res1.setCourtId(1);
        res1.setDisplayName("Max Mustermann");
        res1.setFromDate(dateTimeFormat.parse("01.01.2014 10:30"));
        res1.setToDate(dateTimeFormat.parse("01.01.2014 11:30"));

        SingleReservation res2 = new SingleReservation();
        res2.setCourtId(1);
        res2.setDisplayName("Susi Musterfrau");
        res2.setFromDate(dateTimeFormat.parse("01.01.2014 13:00"));
        res2.setToDate(dateTimeFormat.parse("01.01.2014 14:00"));

        List<SingleReservation> singleReservations = new ArrayList<SingleReservation>();
        singleReservations.add(res1);
        singleReservations.add(res2);
        
        Utilization util = calculator.calculateCourtUtilization(court, dateFormat.parse("01.01.2014"), courtCategory, new Date(), 
                singleReservations, new ArrayList<SubscriptionReservation>());
        
        List<TimeSlot> timeSlots = util.getTimeSlots();
        HashMap<Integer, Integer> maxSlotsPerCourt;
        
        TimeSlot ts9to10 = timeSlots.get(0);
        assertEquals(false, ts9to10.getOccupied());
        assertEquals("", ts9to10.getCaption());
        assertEquals(Arrays.asList(1), ts9to10.getFreeCourtIds());
        assertEquals(new Integer(1), ts9to10.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 1);
        assertEquals(maxSlotsPerCourt, ts9to10.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts9to10.getUtilization());
        
        TimeSlot ts10to11 = timeSlots.get(1);
        assertEquals(true, ts10to11.getOccupied());
        assertEquals("Max Mustermann", ts10to11.getCaption());
        assertEquals(Arrays.asList(), ts10to11.getFreeCourtIds());
        assertEquals(new Integer(0), ts10to11.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        assertEquals(maxSlotsPerCourt, ts10to11.getMaxSlotsPerCourt());
        assertEquals(new Double(1), ts10to11.getUtilization());
        
        TimeSlot ts11to12 = timeSlots.get(2);
        assertEquals(true, ts11to12.getOccupied());
        assertEquals("Max Mustermann", ts11to12.getCaption());
        assertEquals(Arrays.asList(), ts11to12.getFreeCourtIds());
        assertEquals(new Integer(0), ts11to12.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        assertEquals(maxSlotsPerCourt, ts11to12.getMaxSlotsPerCourt());
        assertEquals(new Double(1), ts11to12.getUtilization());
        
        TimeSlot ts12to13 = timeSlots.get(3);
        assertEquals(false, ts12to13.getOccupied());
        assertEquals("", ts12to13.getCaption());
        assertEquals(Arrays.asList(1), ts12to13.getFreeCourtIds());
        assertEquals(new Integer(1), ts12to13.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 1);
        assertEquals(maxSlotsPerCourt, ts12to13.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts12to13.getUtilization());
        
        TimeSlot ts13to14 = timeSlots.get(4);
        assertEquals(true, ts13to14.getOccupied());
        assertEquals("Susi Musterfrau", ts13to14.getCaption());
        assertEquals(Arrays.asList(), ts13to14.getFreeCourtIds());
        assertEquals(new Integer(0), ts13to14.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        assertEquals(maxSlotsPerCourt, ts13to14.getMaxSlotsPerCourt());
        assertEquals(new Double(1), ts13to14.getUtilization());
        
        TimeSlot ts14to15 = timeSlots.get(5);
        assertEquals(false, ts14to15.getOccupied());
        assertEquals("", ts14to15.getCaption());
        assertEquals(Arrays.asList(1), ts14to15.getFreeCourtIds());
        assertEquals(new Integer(1), ts14to15.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 1);
        assertEquals(maxSlotsPerCourt, ts14to15.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts14to15.getUtilization());
    }

    @Test
    public void calculateCourtUtilization_subscriptionReservationsProcessedCorrectly() throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        
        Court court = new Court();
        court.setName("center court");
        court.setId(1);
        
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setBookableFromTime("09:00");
        courtCategory.setBookableToTime("15:00");
        courtCategory.setBookingUnit(60);
        
        SubscriptionReservation res1 = new SubscriptionReservation();
        res1.setCourtId(1);
        res1.setPeriodStart("29.05.2014");
        res1.setPeriodEnd("19.06.2014");
        res1.setFromTime("10:00");
        res1.setToTime("11:00");

        List<SubscriptionReservation> subscriptionReservations = new ArrayList<SubscriptionReservation>();
        subscriptionReservations.add(res1);
        
        Utilization util = calculator.calculateCourtUtilization(court, dateFormat.parse("12.06.2014"), courtCategory, new Date(), 
                new ArrayList<SingleReservation>(), subscriptionReservations);
        
        List<TimeSlot> timeSlots = util.getTimeSlots();
        HashMap<Integer, Integer> maxSlotsPerCourt;
        
        TimeSlot ts9to10 = timeSlots.get(0);
        assertEquals(false, ts9to10.getOccupied());
        assertEquals(Arrays.asList(1), ts9to10.getFreeCourtIds());
        assertEquals(new Integer(1), ts9to10.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 1);
        assertEquals(maxSlotsPerCourt, ts9to10.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts9to10.getUtilization());
        
        TimeSlot ts10to11 = timeSlots.get(1);
        assertEquals(true, ts10to11.getOccupied());
        assertEquals(Arrays.asList(), ts10to11.getFreeCourtIds());
        assertEquals(new Integer(0), ts10to11.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        assertEquals(maxSlotsPerCourt, ts10to11.getMaxSlotsPerCourt());
        assertEquals(new Double(1), ts10to11.getUtilization());
        
        TimeSlot ts11to12 = timeSlots.get(0);
        assertEquals(false, ts11to12.getOccupied());
        assertEquals(Arrays.asList(1), ts11to12.getFreeCourtIds());
        assertEquals(new Integer(1), ts11to12.getMaxSlots());
        maxSlotsPerCourt = new HashMap<Integer, Integer>();
        maxSlotsPerCourt.put(1, 1);
        assertEquals(maxSlotsPerCourt, ts11to12.getMaxSlotsPerCourt());
        assertEquals(new Double(0), ts11to12.getUtilization());
    }
}
