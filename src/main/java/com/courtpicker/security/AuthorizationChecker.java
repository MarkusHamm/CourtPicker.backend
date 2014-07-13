package com.courtpicker.security;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Component;

import com.courtpicker.dao.AuthorityDAO;
import com.courtpicker.dao.CPInstanceDAO;
import com.courtpicker.dao.CourtCategoryDAO;
import com.courtpicker.dao.CourtDAO;
import com.courtpicker.exception.UserNotAuthorizedException;
import com.courtpicker.model.CPInstance;
import com.courtpicker.model.Court;
import com.courtpicker.model.CourtCategory;

@Component("authorizationChecker")
public class AuthorizationChecker {
    @Inject
    private UserInfo userInfo;
    @Inject
    private CourtCategoryDAO courtCategoryDAO;
    @Inject
    private CourtDAO courtDAO;
    @Inject
    private CPInstanceDAO cpInstanceDAO;
    
    public void checkUserIsLoggedInUser(Integer userId) throws UserNotAuthorizedException {
        checkUserLoggedIn();
        checkParameterNotNull(userId);
        if (userId != userInfo.getLoggedInUser().getId()) {
            throw new UserNotAuthorizedException();
        }
    }
    
    public void checkLoggedInUserAuthorizedToModifyCpInstance(Integer cpInstanceId) throws UserNotAuthorizedException {
        // creation of cpInstance is not allowed - only update
        if (cpInstanceId == null) {
            throw new UserNotAuthorizedException("Manual create of CpInstance not allowed");
        }
        
        CPInstance cpInstance = cpInstanceDAO.get(cpInstanceId);
        // if licence is not 'created' any more only instance admins are allowed to modify the instance
        if (!cpInstance.getLicence().toUpperCase().equals("CREATED")) {
            checkUserLoggedIn();
            checkLoggedInUserAdminOfInstance(cpInstanceId);
        }
    }

    public void checkLoggedInUserAdminOfInstance(Integer cpInstanceId) throws UserNotAuthorizedException {
        checkParameterNotNull(cpInstanceId);
        List<String> instanceAuthorities = userInfo.getUserAuthorities().get(cpInstanceId);
        if (instanceAuthorities == null || !instanceAuthorities.contains("ADMIN")) {
            throw new UserNotAuthorizedException("User not authorized"); 
        }
    }
    
    private void checkUserLoggedIn() throws UserNotAuthorizedException {
        if (!userInfo.isLoggedIn() || userInfo.getLoggedInUser() == null) {
            throw new UserNotAuthorizedException("User not logged in");
        }
    }
    
    private void checkParameterNotNull(Object param) throws UserNotAuthorizedException {
        if (param == null) {
            throw new UserNotAuthorizedException("Parameter not set");
        }
    }
    
    /*

    // can use instance check directly
    public void checkLoggedInUserAuthorizedForInstanceByCourtCategory(Integer courtCategoryId, String authority) throws UserNotAuthorizedException {
        checkUserLoggedIn();
        checkParameterNotNull(courtCategoryId);
        CourtCategory courtCategory = courtCategoryDAO.get(courtCategoryId);
        checkParameterNotNull(courtCategory);
        checkLoggedInUserAuthorizedForInstance(courtCategory.getCpInstanceId(), authority);
    }
    
    public void checkLoggedInUserAuthorizedForInstanceByCourt(Integer courtId, String authority) {
        checkUserLoggedIn();
        checkParameterNotNull(courtId);
        Court court = courtDAO.get(courtId);
        checkParameterNotNull(courtId);
        checkLoggedInUserAuthorizedForInstanceByCourtCategory(court.getCourtCategoryId(), authority);
    }

    public void checkLoggedInUserAuthorizedForInstanceByReservation(Integer reservationId, String authority) {
        
    }

    public void checkLoggedInUserAuthorizedForInstanceBySingleRate(Integer singleRateId, String authority) {
        
    }

    public void checkLoggedInUserAuthorizedForInstanceBySubscription(Integer subscriptionId, String authority) {
        
    }

    public void checkLoggedInUserAuthorizedForInstanceBySubscriptionRate(Integer subscriptionRateId, String authority) {
        
    }
    
    public void checkLoggedInUserAuthorizedForInstanceByUserGroup(Integer userGroupId, String authority) {
        
    }

    public void checkLoggedInUserAuthorizedForInstanceByPaymentOption(Integer paymentOptionId, String authority) {
        
    }
    
    public void checkLoggedInUserAuthorizedForInstanceByWebdesign(Integer webdesignId, String authority) {
        
    }

    public void checkReservationBelongsToLoggedInUserOrLoggedInUserIsAdminUser(Integer reservationId) {
        
    }
       
    public void checkLoggedInUserAuthorizedForInstanceOrInstanceStillInConfiguration(Integer cpInstanceId, String authority) {
        
    }
    
    private void checkReservationBelongsToLoggedInUser(Integer reservationId) {
        
    }    
    */    
}
