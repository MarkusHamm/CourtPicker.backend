package com.courtpicker.controller;

import java.io.Serializable;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.NotImplementedException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.courtpicker.courtpicker.PriceCalculator;
import com.courtpicker.courtpicker.UserAccountManager;
import com.courtpicker.courtpicker.UtilizationCalculator;
import com.courtpicker.dao.AuthorityDAO;
import com.courtpicker.dao.CPInstanceDAO;
import com.courtpicker.dao.CourtCategoryDAO;
import com.courtpicker.dao.CourtDAO;
import com.courtpicker.dao.CustomerDAO;
import com.courtpicker.dao.CustomerUserGroupDAO;
import com.courtpicker.dao.SingleRateDAO;
import com.courtpicker.dao.SingleReservationDAO;
import com.courtpicker.dao.SubscriptionDAO;
import com.courtpicker.dao.SubscriptionRateDAO;
import com.courtpicker.dao.SubscriptionReservationDAO;
import com.courtpicker.exception.UserAlreadyExistsException;
import com.courtpicker.exception.UserNotAuthorizedException;
import com.courtpicker.model.Authority;
import com.courtpicker.model.CPInstance;
import com.courtpicker.model.Court;
import com.courtpicker.model.CourtCategory;
import com.courtpicker.model.Customer;
import com.courtpicker.model.CustomerExtract;
import com.courtpicker.model.Rate;
import com.courtpicker.model.SingleReservation;
import com.courtpicker.model.Subscription;
import com.courtpicker.model.SubscriptionReservation;
import com.courtpicker.security.AuthorizationChecker;
import com.courtpicker.security.UserInfo;
import com.courtpicker.tools.CPMailSender;
import com.courtpicker.tools.DateHelper;
import com.courtpicker.tools.MailEngine;
import com.courtpicker.uimodel.AuthStatus;
import com.courtpicker.uimodel.SingleReservationInfo;
import com.courtpicker.uimodel.SubscriptionAvailability;
import com.courtpicker.uimodel.SubscriptionAvailabilityDetail;
import com.courtpicker.uimodel.SubscriptionReservationInfo;
import com.courtpicker.uimodel.TimeSlot;
import com.courtpicker.uimodel.Utilization;

@Controller
@Scope("singleton")
public class CourtpickerController implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Inject
    private UserInfo userInfo;
    @Inject
    private AuthorizationChecker authorizationChecker;
    @Inject
    private CourtCategoryDAO courtCategoryDAO;
    @Inject
    private CustomerDAO customerDAO;
    @Inject
    private AuthorityDAO authorityDAO;
    @Inject
    private CourtDAO courtDAO;
    @Inject
    private CPInstanceDAO cpInstanceDAO;
    @Inject
    private SingleReservationDAO singleReservationDAO;
    @Inject
    SubscriptionReservationDAO subscriptionReservationDAO;
    @Inject
    private SingleRateDAO singleRateDAO;
    @Inject
    private CustomerUserGroupDAO customerUserGroupDAO;
    @Inject
    private SubscriptionDAO subscriptionDAO;
    @Inject
    private SubscriptionRateDAO subscriptionRateDAO;
    @Inject
    private UtilizationCalculator utilizationCalculator;
    @Inject
    private PriceCalculator priceCalculator;   
    @Inject
    private DateHelper dateHelper;
    @Inject
    private CPMailSender cpMailSender;
    @Inject
    private UserAccountManager userAccountManager;

    @RequestMapping(value="/api/registerUser", method=RequestMethod.POST)
    public @ResponseBody Customer registerUser(@RequestParam String userName, @RequestParam String password, 
            @RequestParam String email, @RequestParam String firstName, @RequestParam String lastName, @RequestParam String registerInstanceShortName) throws Exception {
        try {
            Customer customer = userAccountManager.registerUser(userName, password, email, firstName, lastName, registerInstanceShortName);
            return customer;
        }
        catch (UserAlreadyExistsException e) {
            return null;
        }
    }
    
    @RequestMapping(value="/api/registerUserExtended", method=RequestMethod.POST)
    public @ResponseBody Customer registerUserExtended(@RequestParam String userName, @RequestParam String password, 
            @RequestParam String email, @RequestParam String firstName, @RequestParam String lastName, 
            @RequestParam(required=false) String phoneNumber, @RequestParam(required=false) String street, @RequestParam(required=false) String zipCode, 
            @RequestParam(required=false) String city, @RequestParam(required=false) String country, @RequestParam String registerInstanceShortName) throws Exception {
        try {
            Customer customer = userAccountManager.registerUserExtended(userName, password, email, firstName, lastName, phoneNumber, street, zipCode, city, country, registerInstanceShortName);
            return customer;
        }
        catch (UserAlreadyExistsException e) {
            return null;
        }
    }    
    
    @RequestMapping(value="/api/activateUser", method=RequestMethod.POST)
    public @ResponseBody Boolean activateUser(@RequestParam Integer userId, @RequestParam String activationCode) {
        return userAccountManager.activateUser(userId, activationCode);
    }
    
    @RequestMapping(value="/api/updateUser", method=RequestMethod.POST)
    public @ResponseBody Customer updateUser(@RequestBody Customer user) throws UserNotAuthorizedException {
    	authorizationChecker.checkUserIsLoggedInUser(user.getId());
        return customerDAO.persist(user);
    }
    
    @RequestMapping(value="/api/login", method=RequestMethod.POST)
    public @ResponseBody Customer login(@RequestParam String username, @RequestParam String password) throws Exception {
        Customer user = customerDAO.getByUserCredentials(username, DigestUtils.md5Hex(password));
        
        if (user == null) {
            userInfo.setLoggedIn(false);
            userInfo.setLoggedInUser(null);
            userInfo.setUserAuthorities(null);
            userInfo.setUserGroupIds(null);
            return null;
        }
        
        userInfo.setLoggedIn(true);
        userInfo.setLoggedInUser(user);
        Map<Integer, List<String>> userAuthorities = authorityDAO.getAllAuthorities(user.getId());
        userInfo.setUserAuthorities(userAuthorities);
        Map<Integer, List<Integer>> userGroupIds = customerUserGroupDAO.getAllUserGroupsPerInstance(user.getId());
        userInfo.setUserGroupIds(userGroupIds);
        
        return user;
    }
    
    @RequestMapping(value="/api/logout", method=RequestMethod.POST)
    public @ResponseBody Customer logout() throws Exception {
        userInfo.setLoggedIn(false);
        userInfo.setLoggedInUser(null);
        userInfo.setUserAuthorities(null);
        userInfo.setUserGroupIds(null);
        return null;
    }
    
    @RequestMapping(value="/api/getAuthStatus", method=RequestMethod.GET)
    public @ResponseBody AuthStatus getAuthStatus(@RequestParam Integer cpInstanceId) throws Exception {
        AuthStatus authStatus = new AuthStatus();
        authStatus.setLoggedIn(userInfo.isLoggedIn());
        authStatus.setLoggedInUser(userInfo.getLoggedInUser());
        if (userInfo.isLoggedIn() && userInfo.getUserAuthorities().containsKey(cpInstanceId)) {
            authStatus.setAuthorities(userInfo.getUserAuthorities().get(cpInstanceId));
        }
        if (userInfo.isLoggedIn() && userInfo.getUserGroupIds().containsKey(cpInstanceId)) {
            authStatus.setUserGroupIds(userInfo.getUserGroupIds().get(cpInstanceId));
        }
        return authStatus;
    }    
    
    @RequestMapping(value="/api/changeUserPassword", method=RequestMethod.POST)
    public @ResponseBody String changeUserPassword(@RequestParam Integer userId, @RequestParam String oldPassword, @RequestParam String newPassword) throws UserNotAuthorizedException {
        authorizationChecker.checkUserIsLoggedInUser(userId);
    	return userAccountManager.changeUserPassword(userId, oldPassword, newPassword);
    }
    
    @RequestMapping(value="/api/getAuthorities", method=RequestMethod.GET)
    public @ResponseBody List<String> getAuthorities(@RequestParam Integer userId, @RequestParam Integer cpInstanceId) throws Exception {
    	authorizationChecker.checkUserIsLoggedInUser(userId);
        return authorityDAO.getAuthorities(userId, cpInstanceId);
    }
    
    @RequestMapping(value="/api/getUserGroupIds", method=RequestMethod.GET)
    public @ResponseBody List<Integer> getUserGroupIds(@RequestParam Integer userId, @RequestParam Integer cpInstanceId) throws Exception {
        authorizationChecker.checkUserIsLoggedInUser(userId);
        return customerUserGroupDAO.getUserGroupsPerInstance(userId, cpInstanceId);
    }
    
    /*
    @RequestMapping(value="/api/getAllAuthorities", method=RequestMethod.GET)
    public @ResponseBody Map<Integer, List<String>> getAllAuthorities(@RequestParam Integer userId) throws Exception {
        return authorityDAO.getAllAuthorities(userId);
    }
    */
    
    @RequestMapping(value="/api/associateUserWithCpInstance", method=RequestMethod.POST)
    public @ResponseBody void associateUserWithCpInstance(@RequestParam Integer cpInstanceId, @RequestParam Integer userId) {
        boolean authoritiesContainAdmin = false;
        List<Authority> authorities = authorityDAO.getCpInstanceAuthorities(cpInstanceId);
        CPInstance cpInstance = cpInstanceDAO.get(cpInstanceId);
        
        for (Authority authority : authorities) {
            if (authority.getAuthority().toUpperCase().equals("ADMIN")) {
                authoritiesContainAdmin = true;
            }
        }
        
        if (!authoritiesContainAdmin) {
            authorityDAO.authorizeUser(cpInstanceId, userId, "ADMIN");
            cpInstance.setLicence("trial");
            cpInstance.setLicenceStartDate(new Date());
            cpInstanceDAO.persist(cpInstance);
        }
    }
    
    @RequestMapping(value="/api/authorizeUser", method=RequestMethod.POST)
    public @ResponseBody void authorizeUser(@RequestParam Integer cpInstanceId, @RequestParam Integer userId, @RequestParam String authority) throws UserNotAuthorizedException {
        authorizationChecker.checkLoggedInUserAuthorizedToModifyCpInstance(cpInstanceId);
    	authorityDAO.authorizeUser(cpInstanceId, userId, authority);
    }
    
    @RequestMapping(value="/api/deAuthorizeUser", method=RequestMethod.POST)
    public @ResponseBody void deAuthorizeUser(@RequestParam Integer cpInstanceId, @RequestParam Integer userId, @RequestParam String authority) throws UserNotAuthorizedException {
        authorizationChecker.checkLoggedInUserAuthorizedToModifyCpInstance(cpInstanceId);
    	authorityDAO.deAuthorizeUser(cpInstanceId, userId, authority);
    }
    
    @RequestMapping(value="/api/forgotPasswordRequest", method=RequestMethod.GET)
    public @ResponseBody Boolean forgotPasswordRequest(@RequestParam String email, @RequestParam String firstName, @RequestParam String lastName) {
        return userAccountManager.processForgotPasswordRequest(email, firstName, lastName);
    }

    @RequestMapping(value="/api/getReservableTimeSlots", method=RequestMethod.GET)
    public @ResponseBody List<TimeSlot> getReservableTimeSlots(@RequestParam Integer courtCategoryId) throws ParseException {
        CourtCategory courtCategory = courtCategoryDAO.get(courtCategoryId);
        return utilizationCalculator.calculateReservableTimeSlots(courtCategory.getBookableFromTime(), 
                courtCategory.getBookableToTime(), courtCategory.getBookingUnit(), new ArrayList<Integer>());
    }
    
    @RequestMapping(value="/api/getWeekUtilization", method=RequestMethod.GET)
    public @ResponseBody List<Utilization> getWeekUtilization(@RequestParam Integer courtCategoryId, @RequestParam String date) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        Date realDate = dateFormat.parse(date);
        Date fromDate = dateHelper.getEarliestDateOfWeek(realDate);
        Date toDate = dateHelper.getLatestDateOfWeek(realDate);
        Date currentDate = new Date();
        
        CourtCategory courtCategory = courtCategoryDAO.get(courtCategoryId);
        List<Court> courts = courtDAO.getAllCourts(courtCategoryId);
        List<SingleReservation> singleReservations = singleReservationDAO.getReservationsForCourtCategory(courtCategoryId, fromDate, toDate);
        List<SubscriptionReservation> subscrReservations = subscriptionReservationDAO.getReservationsForCourtCategory(courtCategoryId, fromDate, toDate);
        
        return utilizationCalculator.calculateDayUtilization(courtCategory, courts, fromDate, toDate, currentDate, singleReservations, subscrReservations);
    }
    
    @RequestMapping(value="/api/getWeekUtilizationForCourt", method=RequestMethod.GET)
    public @ResponseBody List<Utilization> getWeekUtilizationForCourt(@RequestParam Integer courtId, @RequestParam String date) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        Date realDate = dateFormat.parse(date);
        Date fromDate = dateHelper.getEarliestDateOfWeek(realDate);
        Date toDate = dateHelper.getLatestDateOfWeek(realDate);
        Date currentDate = new Date();
        
        Court court = courtDAO.get(courtId);
        CourtCategory courtCategory = courtCategoryDAO.get(court.getCourtCategoryId());
        List<Court> courts = new ArrayList<Court>();
        courts.add(court);
        List<SingleReservation> singleReservations = singleReservationDAO.getReservationsForCourt(courtId, fromDate, toDate);
        List<SubscriptionReservation> subscrReservations = subscriptionReservationDAO.getReservationsForCourt(courtId, fromDate, toDate);
        
        return utilizationCalculator.calculateDayUtilization(courtCategory, courts, fromDate, toDate, currentDate, singleReservations, subscrReservations);
    }
    
    @RequestMapping(value="/api/getCourtUtilization", method=RequestMethod.GET)
    public @ResponseBody List<Utilization> getCourtUtilization(@RequestParam String courtIdsCsv, @RequestParam String date) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        Date realDate = dateFormat.parse(date);
        Date earliestDateOfDay = dateHelper.getEarliestDateOfDay(realDate);
        Date latestDateOfDay = dateHelper.getLatestDateOfDay(realDate);
        Date currentDate = new Date();
        
        List<Utilization> result = new ArrayList<Utilization>();
        
        if (courtIdsCsv.length() > 0) {
            for (String courtIdStr : courtIdsCsv.split(",")) {
                Integer courtId = new Integer(courtIdStr);
                Court court = courtDAO.get(courtId);
                CourtCategory courtCategory = courtCategoryDAO.get(court.getCourtCategoryId());
                List<SingleReservation> singleReservations = singleReservationDAO.getReservationsForCourt(courtId, earliestDateOfDay, latestDateOfDay);
                List<SubscriptionReservation> subscrReservations = subscriptionReservationDAO.getReservationsForCourt(courtId, earliestDateOfDay, latestDateOfDay);
                result.add(utilizationCalculator.calculateCourtUtilization(court, realDate, courtCategory, currentDate, singleReservations, subscrReservations));            
            }
        }
        
        return result;
    }
    
    @RequestMapping(value="/api/getSubscriptionAvailability", method=RequestMethod.GET)
    public @ResponseBody List<SubscriptionAvailability> getSubscriptionAvailability(@RequestParam Integer subscriptionId, @RequestParam Integer bookingUnits) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        
        Subscription subscription = subscriptionDAO.get(subscriptionId);
        CourtCategory courtCategory = courtCategoryDAO.get(subscription.getCourtCategoryId());
        List<Court> courts = courtDAO.getAllCourts(courtCategory.getId());        
        Date fromDate = dateHelper.getEarliestDateOfDay(dateFormat.parse(subscription.getPeriodStart()));
        Date toDate = dateHelper.getLatestDateOfDay(dateFormat.parse(subscription.getPeriodEnd()));
        
        List<SingleReservation> singleReservations = singleReservationDAO.getReservationsForCourtCategory(courtCategory.getId(), fromDate, toDate);
        List<SubscriptionReservation> subscriptionReservations = subscriptionReservationDAO.getReservationsForCourtCategory(courtCategory.getId(), fromDate, toDate);

        return utilizationCalculator.calculateSubscriptionAvailabilityUtilization(courtCategory, courts, singleReservations, subscriptionReservations, bookingUnits);
    }    
    
    @RequestMapping(value="/api/getSingleReservationPrice", method=RequestMethod.GET)
    public @ResponseBody BigDecimal getSingleReservationPrice(@RequestParam Integer customerId, @RequestParam Integer courtId, 
            @RequestParam String fromDateTime, @RequestParam String toDateTime) throws ParseException {
        return calculateSingleReservationPrice(customerId, courtId, fromDateTime, toDateTime);
    }
    
    @RequestMapping(value="/api/getSubscriptionReservationPrice", method=RequestMethod.GET)
    public @ResponseBody BigDecimal getSubscriptionReservationPrice(@RequestParam Integer customerId, @RequestParam Integer subscriptionId, 
            @RequestParam String fromTime, @RequestParam Integer bookingUnits, @RequestParam String weekDay) throws ParseException {
        
        // FIXME: It is ugly to fetch the courtcategory here and again in the sub-routines
        int calendarWeekDay = getCalendarWeekDayForString(weekDay);
        Subscription subscription = subscriptionDAO.get(subscriptionId);
        CourtCategory courtCategory = courtCategoryDAO.get(subscription.getCourtCategoryId());
        String toTime = calculateSubscriptionReservationEndTime(fromTime, bookingUnits, courtCategory);
        
        return calculateSubscriptionReservationPrice(customerId, subscriptionId, fromTime, toTime, calendarWeekDay);
    }
    
    @RequestMapping(value="/api/getCurrentSubscriptions", method=RequestMethod.GET)
    public @ResponseBody List<Subscription> getCurrentSubscriptions(@RequestParam Integer courtCategoryId) throws ParseException {
        List<Subscription> subscriptions = subscriptionDAO.getAll(courtCategoryId);
        List<Subscription> currentSubscriptions = new ArrayList<Subscription>();
        
        Date currentDate = new Date();
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        
        for (Subscription subscription : subscriptions) {
            Date bookableFrom = dateTimeFormat.parse(subscription.getBookableFrom() + " 00:00");
            Date bookableTo = dateTimeFormat.parse(subscription.getBookableTo() + " 23:59");
            if (currentDate.after(bookableFrom) && currentDate.before(bookableTo)) {
                currentSubscriptions.add(subscription);
            }
        }
        
        return currentSubscriptions;
    }   

    @RequestMapping(value="/api/singleReservation", method=RequestMethod.POST)
    public @ResponseBody Boolean singleReservation(@RequestParam Integer customerId, @RequestParam Integer courtId, 
            @RequestParam String fromDateTime, @RequestParam String toDateTime, @RequestParam String comment) throws ParseException, UserNotAuthorizedException {
    	authorizationChecker.checkUserIsLoggedInUser(customerId);
    	
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        Date fromDate = dateTimeFormat.parse(fromDateTime);
        Date toDate = dateTimeFormat.parse(toDateTime);
        Date reservationDate = new Date();
        BigDecimal price = calculateSingleReservationPrice(customerId, courtId, fromDateTime, toDateTime);

        if (!isSingleReservationBookable(courtId, fromDate, toDate)) {
            return false;
        }
        
        SingleReservation res = new SingleReservation();
        res.setCustomerId(customerId);
        res.setCustomerName(null);
        res.setCourtId(courtId);
        res.setFromDate(fromDate);
        res.setToDate(toDate);
        res.setReservationDate(reservationDate);
        res.setReservingCustomerId(customerId);
        res.setDisplayName(getDisplayNameForCustomer(customerId));
        res.setPaid(false);
        res.setDeleted(false);
        res.setCalculatedPrice(price);
        res.setPrice(price);
        res.setComment(comment);
        
        singleReservationDAO.persist(res);
        cpMailSender.sendSingleReservationDoneMail(res);
        
        return true;
    }
    
    @RequestMapping(value="/api/singleReservationAdmin", method=RequestMethod.POST)
    public @ResponseBody Boolean singleReservationAdmin(@RequestParam String customerInputType, @RequestParam(required=false) Integer customerId, @RequestParam String customerName, 
            @RequestParam Boolean createUserAccount, @RequestParam String createUserAccountEmail, @RequestParam Integer reservingCustomerId, @RequestParam Integer courtId, 
            @RequestParam String fromDateTime, @RequestParam String toDateTime, @RequestParam Boolean overridePrice, @RequestParam BigDecimal customPrice, @RequestParam String comment) throws ParseException, UserNotAuthorizedException {
        authorizationChecker.checkLoggedInUserAllowedToModifyCourt(courtId, null);
    	
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        Date fromDate = dateTimeFormat.parse(fromDateTime);
        Date toDate = dateTimeFormat.parse(toDateTime);
        Date reservationDate = new Date();

        if (!isSingleReservationBookable(courtId, fromDate, toDate)) {
            return false;
        }
        
        Integer dbCustomerId = null;
        String dbCustomerName = null;
        if (customerInputType.toUpperCase().equals("NAME") && !createUserAccount) {
            dbCustomerName = customerName;
        }
        else if (customerInputType.toUpperCase().equals("NAME") && createUserAccount) {
            Court court = courtDAO.get(courtId);
            CourtCategory courtCategory = courtCategoryDAO.get(court.getCourtCategoryId());
            CPInstance cpInstance = cpInstanceDAO.get(courtCategory.getCpInstanceId());
            dbCustomerId = userAccountManager.createOrGetMinimalUser(createUserAccountEmail, customerName, cpInstance.getShortName()).getId();
        }
        else {
            dbCustomerId = customerId;
        }
        
        String displayName = "";
        if (dbCustomerId != null) {
            displayName = getDisplayNameForCustomer(dbCustomerId);
        }
        else {
            displayName = dbCustomerName;
        }
        
        BigDecimal calculatedPrice = calculateSingleReservationPrice(customerId, courtId, fromDateTime, toDateTime);
        BigDecimal price = calculatedPrice;
        if (overridePrice) {
            price = customPrice;
        }
        
        SingleReservation res = new SingleReservation();
        res.setCustomerId(dbCustomerId);
        res.setCustomerName(dbCustomerName);
        res.setCourtId(courtId);
        res.setFromDate(fromDate);
        res.setToDate(toDate);
        res.setReservationDate(reservationDate);
        res.setReservingCustomerId(reservingCustomerId);
        res.setDisplayName(displayName);
        res.setPaid(false);
        res.setDeleted(false);
        res.setCalculatedPrice(calculatedPrice);
        res.setPrice(price);
        res.setComment(comment);
        
        singleReservationDAO.persist(res);
        cpMailSender.sendSingleReservationDoneMail(res);
        
        return true;
    }

    @RequestMapping(value="/api/subscriptionReservation", method=RequestMethod.POST)
    public @ResponseBody Boolean subscriptionReservation(@RequestParam Integer subscriptionId, @RequestParam Integer customerId, 
            @RequestParam Integer courtId, @RequestParam String weekDay, @RequestParam String startTime, 
            @RequestParam Integer bookingUnits, @RequestParam String comment) throws ParseException, UserNotAuthorizedException {  
        authorizationChecker.checkUserIsLoggedInUser(customerId);
    	
        Subscription subscription = subscriptionDAO.get(subscriptionId);
        CourtCategory courtCategory = courtCategoryDAO.get(subscription.getCourtCategoryId());
        int calendarWeekDay = getCalendarWeekDayForString(weekDay);
        
        String reservationPeriodStart = calculateSuscriptionReservationStartDate(subscription.getPeriodStart(), calendarWeekDay);
        String reservationPeriodEnd = calculateSuscriptionReservationEndDate(subscription.getPeriodEnd(), calendarWeekDay);
        String reservationStartTime = startTime;
        String reservationEndTime = calculateSubscriptionReservationEndTime(startTime, bookingUnits, courtCategory);
        
        BigDecimal calcReservationPrice = calculateSubscriptionReservationPrice(customerId, subscriptionId, reservationStartTime, reservationEndTime, calendarWeekDay);

        if (!isSubscriptionReservationBookable(subscriptionId, courtId, startTime, bookingUnits, calendarWeekDay)) {
            return false;
        }
        
        SubscriptionReservation res = new SubscriptionReservation();
        res.setSubscriptionId(subscriptionId);
        res.setCustomerId(customerId);
        res.setCourtId(courtId);
        res.setPeriodStart(reservationPeriodStart);
        res.setPeriodEnd(reservationPeriodEnd);
        res.setFromTime(reservationStartTime);
        res.setToTime(reservationEndTime);
        res.setReservationDate(new Date());
        res.setReservingCustomerId(customerId);
        res.setDisplayName(getDisplayNameForCustomer(customerId));
        res.setPaid(false);
        res.setDeleted(false);
        res.setPrice(calcReservationPrice);
        res.setComment(comment);
        res.setCustomerName(null);
        res.setCalculatedPrice(calcReservationPrice);
        res.setPaymentDate(null);
        res.setPaymentOptionId(null);
        
        subscriptionReservationDAO.persist(res);
        cpMailSender.sendSubscriptionReservationDoneMail(res);
        
        return true;
    }
    
    @RequestMapping(value="/api/subscriptionReservationAdmin", method=RequestMethod.POST)
    public @ResponseBody Boolean subscriptionReservationAdmin(@RequestParam String customerInputType, @RequestParam(required=false) Integer customerId, @RequestParam String customerName, 
            @RequestParam Boolean createUserAccount, @RequestParam String createUserAccountEmail, @RequestParam Integer subscriptionId, @RequestParam Integer reservingCustomerId, 
            @RequestParam Integer courtId, @RequestParam String weekDay, @RequestParam String startTime, @RequestParam Integer bookingUnits, @RequestParam Boolean overridePrice, 
            @RequestParam BigDecimal customPrice, @RequestParam String comment) throws ParseException, UserNotAuthorizedException {
        authorizationChecker.checkLoggedInUserAllowedToModifyCourt(courtId, null);
    	
        Subscription subscription = subscriptionDAO.get(subscriptionId);
        CourtCategory courtCategory = courtCategoryDAO.get(subscription.getCourtCategoryId());
        int calendarWeekDay = getCalendarWeekDayForString(weekDay);
        
        String reservationPeriodStart = calculateSuscriptionReservationStartDate(subscription.getPeriodStart(), calendarWeekDay);
        String reservationPeriodEnd = calculateSuscriptionReservationEndDate(subscription.getPeriodEnd(), calendarWeekDay);
        String reservationStartTime = startTime;
        String reservationEndTime = calculateSubscriptionReservationEndTime(startTime, bookingUnits, courtCategory);
        
        Integer dbCustomerId = null;
        String dbCustomerName = null;
        if (customerInputType.toUpperCase().equals("NAME") && !createUserAccount) {
            dbCustomerName = customerName;
        }
        else if (customerInputType.toUpperCase().equals("NAME") && createUserAccount) {
            CPInstance cpInstance = cpInstanceDAO.get(courtCategory.getCpInstanceId());
            dbCustomerId = userAccountManager.createOrGetMinimalUser(createUserAccountEmail, customerName, cpInstance.getShortName()).getId();
        }
        else {
            dbCustomerId = customerId;
        }
        
        String displayName = "";
        if (dbCustomerId != null) {
            displayName = getDisplayNameForCustomer(dbCustomerId);
        }
        else {
            displayName = dbCustomerName;
        }

        BigDecimal calcReservationPrice = calculateSubscriptionReservationPrice(customerId, subscriptionId, reservationStartTime, reservationEndTime, calendarWeekDay);
        BigDecimal price = calcReservationPrice;
        if (overridePrice) {
            price = customPrice;
        }        
        
        if (!isSubscriptionReservationBookable(subscriptionId, courtId, startTime, bookingUnits, calendarWeekDay)) {
            return false;
        }

        SubscriptionReservation res = new SubscriptionReservation();
        res.setSubscriptionId(subscriptionId);
        res.setCustomerId(dbCustomerId);
        res.setCourtId(courtId);
        res.setPeriodStart(reservationPeriodStart);
        res.setPeriodEnd(reservationPeriodEnd);
        res.setFromTime(reservationStartTime);
        res.setToTime(reservationEndTime);
        res.setReservationDate(new Date());
        res.setReservingCustomerId(reservingCustomerId);
        res.setDisplayName(displayName);
        res.setPaid(false);
        res.setDeleted(false);
        res.setPrice(price);
        res.setComment(comment);
        res.setCustomerName(dbCustomerName);
        res.setCalculatedPrice(calcReservationPrice);
        res.setPaymentDate(null);
        res.setPaymentOptionId(null);
        
        subscriptionReservationDAO.persist(res);
        cpMailSender.sendSubscriptionReservationDoneMail(res);
        
        return true;
    }

        
    @RequestMapping(value="/api/getAllUserExtract", method=RequestMethod.GET)
    public @ResponseBody List<CustomerExtract> getAllUserExtract() {
        return customerDAO.getAllExctract();
    }
    
    @RequestMapping(value="/api/getAdminUserExtract", method=RequestMethod.GET)
    public @ResponseBody List<CustomerExtract> getAdminUserExtract(@RequestParam Integer cpInstanceId) throws UserNotAuthorizedException {
    	authorizationChecker.checkLoggedInUserAuthorizedToModifyCpInstance(cpInstanceId);
        return customerDAO.getAdminUserExctract(cpInstanceId);
    }    
    
    @RequestMapping(value="/api/getSingleReservationInfosForCustomer", method=RequestMethod.GET)
    public @ResponseBody List<SingleReservationInfo> getSingleReservationInfosForCustomer(@RequestParam Integer customerId) throws UserNotAuthorizedException {
    	authorizationChecker.checkUserIsLoggedInUser(customerId);
        return singleReservationDAO.getSingleReservationInfosForCustomer(customerId);
    }
    
    @RequestMapping(value="/api/getSingleReservationInfosForCpInstance", method=RequestMethod.GET)
    public @ResponseBody List<SingleReservationInfo> getSingleReservationInfosForCpInstance(@RequestParam Integer cpInstanceId) throws UserNotAuthorizedException {
    	authorizationChecker.checkLoggedInUserAuthorizedToModifyCpInstance(cpInstanceId);
        return singleReservationDAO.getSingleReservationInfosForCpInstance(cpInstanceId);
    }
        
    @RequestMapping(value="/api/cancelSingleReservation", method=RequestMethod.POST)
    public @ResponseBody void cancelSingleReservation(@RequestParam Integer reservationId) throws UserNotAuthorizedException {
    	authorizationChecker.checkLoggedInUserAuthorizedToCancelSingleReservation(reservationId);    	
        SingleReservation singleReservation = singleReservationDAO.get(reservationId);
    	singleReservationDAO.cancelReservation(reservationId);
    	cpMailSender.sendSingleReservationCancelMail(singleReservation);
    }
    
    @RequestMapping(value="/api/paySingleReservation", method=RequestMethod.POST)
    public @ResponseBody void paySingleReservation(@RequestParam Integer reservationId, @RequestParam Integer paymentOptionId,
            @RequestParam Boolean overridePrice, @RequestParam BigDecimal customPrice) throws UserNotAuthorizedException {
    	authorizationChecker.checkLoggedInUserIsAdminBySingleReservation(reservationId);
    	
        SingleReservation reservation = singleReservationDAO.get(reservationId);
        reservation.setPaid(true);
        reservation.setPaymentDate(new Date());
        reservation.setPaymentOptionId(paymentOptionId);
        if (overridePrice) {
            reservation.setPrice(customPrice);
        }
        
        singleReservationDAO.persist(reservation);
    }
    
    @RequestMapping(value="/api/undoPaymentSingleReservation", method=RequestMethod.POST)
    public @ResponseBody SingleReservation undoPaymentSingleReservation(@RequestParam Integer reservationId) throws UserNotAuthorizedException {
    	authorizationChecker.checkLoggedInUserIsAdminBySingleReservation(reservationId);
    	
        SingleReservation reservation = singleReservationDAO.get(reservationId);
        reservation.setPaid(false);
        reservation.setPaymentDate(null);
        reservation.setPaymentOptionId(null);
        reservation.setPrice(reservation.getCalculatedPrice());        
        singleReservationDAO.persist(reservation);
        
        return reservation;
    }
    
    @RequestMapping(value="/api/getSubscriptionReservationInfosForCustomer", method=RequestMethod.GET)
    public @ResponseBody List<SubscriptionReservationInfo> getSubscriptionReservationInfosForCustomer(@RequestParam Integer customerId) throws UserNotAuthorizedException {
    	authorizationChecker.checkUserIsLoggedInUser(customerId);
        return subscriptionReservationDAO.getSubscriptionReservationInfosForCustomer(customerId);
    }
    
    @RequestMapping(value="/api/getSubscriptionReservationInfosForCpInstance", method=RequestMethod.GET)
    public @ResponseBody List<SubscriptionReservationInfo> getSubscriptionReservationInfosForCpInstance(@RequestParam Integer cpInstanceId) throws UserNotAuthorizedException {
    	authorizationChecker.checkLoggedInUserAuthorizedToModifyCpInstance(cpInstanceId);
        return subscriptionReservationDAO.getSubscriptionReservationInfosForCpInstance(cpInstanceId);
    }
    
    @RequestMapping(value="/api/cancelSubscriptionReservation", method=RequestMethod.POST)
    public @ResponseBody void cancelSubscriptionReservation(@RequestParam Integer reservationId) throws UserNotAuthorizedException, ParseException {
    	authorizationChecker.checkLoggedInUserAuthorizedToCancelSubscriptionReservation(reservationId);
        SubscriptionReservation subscriptionReservation = subscriptionReservationDAO.get(reservationId);
    	subscriptionReservationDAO.cancelReservation(reservationId);
    	cpMailSender.sendSubscriptionReservationCancelMail(subscriptionReservation);
    }
    
    @RequestMapping(value="/api/paySubscriptionReservation", method=RequestMethod.POST)
    public @ResponseBody void paySubscriptionReservation(@RequestParam Integer reservationId, @RequestParam Integer paymentOptionId,
            @RequestParam Boolean overridePrice, @RequestParam BigDecimal customPrice) throws UserNotAuthorizedException {
    	authorizationChecker.checkLoggedInUserIsAdminBySubscriptionReservation(reservationId);
    	
        SubscriptionReservation reservation = subscriptionReservationDAO.get(reservationId);
        reservation.setPaid(true);
        reservation.setPaymentDate(new Date());
        reservation.setPaymentOptionId(paymentOptionId);
        if (overridePrice) {
            reservation.setPrice(customPrice);
        }
        
        subscriptionReservationDAO.persist(reservation);
    }
    
    @RequestMapping(value="/api/undoPaymentSubscriptionReservation", method=RequestMethod.POST)
    public @ResponseBody SubscriptionReservation undoPaymentSubscriptionReservation(@RequestParam Integer reservationId) throws UserNotAuthorizedException {
    	authorizationChecker.checkLoggedInUserIsAdminBySubscriptionReservation(reservationId);
    	
        SubscriptionReservation reservation = subscriptionReservationDAO.get(reservationId);
        reservation.setPaid(false);
        reservation.setPaymentDate(null);
        reservation.setPaymentOptionId(null);
        reservation.setPrice(reservation.getCalculatedPrice());
        subscriptionReservationDAO.persist(reservation);
        
        return reservation;
    }
    
    private String getDisplayNameForCustomer(Integer customerId) {
        Customer customer = customerDAO.get(customerId);
        String displayName = customer.getFirstName() + " " + customer.getLastName();
        return displayName;
    }
    
    private BigDecimal calculateSingleReservationPrice(Integer customerId, Integer courtId, String fromDateTime, String toDateTime) throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        
        Court court = courtDAO.get(courtId);
        CourtCategory courtCategory = courtCategoryDAO.get(court.getCourtCategoryId());
        List<Integer> userGroupIds = customerUserGroupDAO.getUserGroupIds(customerId);
        List<Rate> courtCategoryRates = new ArrayList<Rate>();
        for (Rate singleRate : singleRateDAO.getRates(courtCategory.getId())) {
            courtCategoryRates.add(singleRate);
        }
        Date fromDate = dateTimeFormat.parse(fromDateTime);
        Date toDate = dateTimeFormat.parse(toDateTime);
        
        BigDecimal price = priceCalculator.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, courtCategory.getBookingUnit(), courtCategoryRates);
        return price;
    }
    
    private BigDecimal calculateSubscriptionReservationPrice(Integer customerId, Integer subscriptionId, String fromTime, String toTime, int calendarWeekDay) throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        
        // the specific date is irrelevant for subscription price calculation - only weekday and time are of interest
        // thus, I am able to specifiy any Monday or Sunday, etc. and add the dynamic time
        String dateString = dateFormat.format(dateHelper.getNextWeekDay(new Date(), calendarWeekDay));
                
        Date fromDate = dateTimeFormat.parse(dateString + " " + fromTime);
        Date toDate = dateTimeFormat.parse(dateString + " " + toTime);

        Subscription subscription = subscriptionDAO.get(subscriptionId);
        CourtCategory courtCategory = courtCategoryDAO.get(subscription.getCourtCategoryId());
        List<Integer> userGroupIds = customerUserGroupDAO.getUserGroupIds(customerId);
        List<Rate> subscriptionRates = new ArrayList<Rate>();
        for (Rate subscriptionRate : subscriptionRateDAO.getAll(subscriptionId)) {
            subscriptionRates.add(subscriptionRate);
        }
        
        BigDecimal price = priceCalculator.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, courtCategory.getBookingUnit(), subscriptionRates);
        return price;
    }
    
    private String calculateSubscriptionReservationEndTime(String startTime, Integer bookingUnits, CourtCategory courtCategory) throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        
        Integer bookingMinutes = courtCategory.getBookingUnit() * bookingUnits;
        Date startDate = dateTimeFormat.parse("01.01.2014 " + startTime);
        Date endDate = dateHelper.addMinutes(startDate, bookingMinutes);
                
        return timeFormat.format(endDate);
    }

    private String calculateSuscriptionReservationEndDate(String subscriptionEnd, int calendarWeekDay) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        Date subscriptionEndDate = dateFormat.parse(subscriptionEnd);
        Date reservationEndDate = dateHelper.getPreviousWeekDay(subscriptionEndDate, calendarWeekDay);
        return dateFormat.format(reservationEndDate);
    }

    private String calculateSuscriptionReservationStartDate(String subscriptionStart, int calendarWeekDay) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        Date subscriptionStartDate = dateFormat.parse(subscriptionStart);
        Date reservationStartDate = dateHelper.getNextWeekDay(subscriptionStartDate, calendarWeekDay);
        return dateFormat.format(reservationStartDate);
    }
    
    private int getCalendarWeekDayForString(String weekDayString) {
        if (weekDayString.toUpperCase().equals("MON")) {
            return Calendar.MONDAY;
        }
        else if (weekDayString.toUpperCase().equals("TUE")) {
            return Calendar.TUESDAY;
        }
        else if (weekDayString.toUpperCase().equals("WED")) {
            return Calendar.WEDNESDAY;
        }
        else if (weekDayString.toUpperCase().equals("THU")) {
            return Calendar.THURSDAY;
        }
        else if (weekDayString.toUpperCase().equals("FRI")) {
            return Calendar.FRIDAY;
        }
        else if (weekDayString.toUpperCase().equals("SAT")) {
            return Calendar.SATURDAY;
        }
        return Calendar.SUNDAY;
    }
    
    private boolean isSingleReservationBookable(Integer courtId, Date fromDate, Date toDate) throws ParseException {
        SimpleDateFormat dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        
        // check single reservation overlaps
        List<SingleReservation> singleReservations = singleReservationDAO.getReservationsForCourt(courtId, fromDate, toDate);
        if (singleReservations.size() != 0) {
            return false;
        }

        // check subscription overlaps
        List<SubscriptionReservation> subscriptionReservations = subscriptionReservationDAO.getReservationsForCourt(courtId, fromDate, toDate);
        int reservationWeekDay = dateHelper.getDayOfWeek(fromDate);
        for (SubscriptionReservation subscriptionReservation : subscriptionReservations) {
            Date subscriptionStartDate = dateFormat.parse(subscriptionReservation.getPeriodStart());
            
            if (reservationWeekDay == dateHelper.getDayOfWeek(subscriptionStartDate)) {
                Date subscriptionStartTime = dateTimeFormat.parse("01.01.2014 " + subscriptionReservation.getFromTime());
                Date subscriptionEndTime = dateTimeFormat.parse("01.01.2014 " + subscriptionReservation.getToTime());
                Date fromDateHelper = dateTimeFormat.parse("01.01.2014 " + timeFormat.format(fromDate));
                Date toDateHelper = dateTimeFormat.parse("01.01.2014 " + timeFormat.format(toDate));
                
                if (subscriptionEndTime.after(fromDateHelper) && subscriptionStartTime.before(toDateHelper)) {
                    return false;
                }
            }
        }
        
        return true;
    }
    
    private boolean isSubscriptionReservationBookable(Integer subscriptionId, Integer courtId, String startTime, Integer bookingUnits, Integer calenderWeekDay) throws ParseException {
        // re-check availabilty right before booking
        List<SubscriptionAvailability> subscriptionAvailabilities = getSubscriptionAvailability(subscriptionId, bookingUnits);
        SubscriptionAvailability subscriptionAvailability = null;
        SubscriptionAvailabilityDetail subscriptionAvailabilityDetail = null;
        
        switch (calenderWeekDay) {
            case Calendar.MONDAY: subscriptionAvailability = subscriptionAvailabilities.get(0); break;
            case Calendar.TUESDAY: subscriptionAvailability = subscriptionAvailabilities.get(1); break;
            case Calendar.WEDNESDAY: subscriptionAvailability = subscriptionAvailabilities.get(2); break;
            case Calendar.THURSDAY: subscriptionAvailability = subscriptionAvailabilities.get(3); break;
            case Calendar.FRIDAY: subscriptionAvailability = subscriptionAvailabilities.get(4); break;
            case Calendar.SATURDAY: subscriptionAvailability = subscriptionAvailabilities.get(5); break;
            case Calendar.SUNDAY: subscriptionAvailability = subscriptionAvailabilities.get(6); break;
            default: subscriptionAvailability = null;
        }
        if (subscriptionAvailability == null) {
            return false;
        }
        
        for (SubscriptionAvailabilityDetail detail : subscriptionAvailability.getDetail()) {
            if (detail.getStartTime().equals(startTime)) {
                subscriptionAvailabilityDetail = detail;
            }
        }
        
        if (subscriptionAvailabilityDetail != null && subscriptionAvailabilityDetail.getFreeCourtIds().contains(courtId)) {
            return true;
        }
        
        return false;
    }
}
