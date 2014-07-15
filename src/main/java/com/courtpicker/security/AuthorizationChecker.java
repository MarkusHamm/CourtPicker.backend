package com.courtpicker.security;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Component;

import com.courtpicker.dao.AuthorityDAO;
import com.courtpicker.dao.CPInstanceDAO;
import com.courtpicker.dao.CourtCategoryDAO;
import com.courtpicker.dao.CourtDAO;
import com.courtpicker.dao.PaymentOptionDAO;
import com.courtpicker.dao.SingleRateDAO;
import com.courtpicker.dao.SingleReservationDAO;
import com.courtpicker.dao.SubscriptionDAO;
import com.courtpicker.dao.SubscriptionRateDAO;
import com.courtpicker.dao.SubscriptionReservationDAO;
import com.courtpicker.dao.UserGroupDAO;
import com.courtpicker.dao.WebdesignDAO;
import com.courtpicker.exception.UserNotAuthorizedException;
import com.courtpicker.model.CPInstance;
import com.courtpicker.model.Court;
import com.courtpicker.model.CourtCategory;
import com.courtpicker.model.PaymentOption;
import com.courtpicker.model.SingleRate;
import com.courtpicker.model.SingleReservation;
import com.courtpicker.model.Subscription;
import com.courtpicker.model.SubscriptionRate;
import com.courtpicker.model.SubscriptionReservation;
import com.courtpicker.model.UserGroup;
import com.courtpicker.model.Webdesign;

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
    @Inject
    private WebdesignDAO webdesignDAO;
    @Inject
    private SingleRateDAO singleRateDAO;
    @Inject
    private SubscriptionDAO subscriptionDAO;
    @Inject
    private SubscriptionRateDAO subscriptionRateDAO;
    @Inject
    private UserGroupDAO userGroupDAO;
    @Inject
    private PaymentOptionDAO paymentOptionDAO;
    @Inject
    private SingleReservationDAO singleReservationDAO;
    @Inject
    private SubscriptionReservationDAO subscriptionReservationDAO;
    
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
        checkCpInstanceAccess(cpInstanceId);
    }
    
    public void checkLoggedInUserAuthorizedToCancelSingleReservation(Integer reservationId) throws UserNotAuthorizedException {
    	boolean isReservingUser = true;
    	boolean isAdminOfInstance = true;
    	
    	SingleReservation singleReservation = singleReservationDAO.get(reservationId);
    	
    	try {
        	checkUserIsLoggedInUser(singleReservation.getCustomerId());
    	}
    	catch (UserNotAuthorizedException e) {
    		isReservingUser = false;
    	}
    	try {
    		checkCourtAccess(singleReservation.getCourtId());
    	}
    	catch (UserNotAuthorizedException e) {
    		isAdminOfInstance = false;
    	}
    	
    	if (!isReservingUser && !isAdminOfInstance) {
    		throw new UserNotAuthorizedException("User not authorized");
    	}
    }
    
    public void checkLoggedInUserAuthorizedToCancelSubscriptionReservation(Integer reservationId) throws UserNotAuthorizedException {
    	boolean isReservingUser = true;
    	boolean isAdminOfInstance = true;
    	
    	SubscriptionReservation subscrReservation = subscriptionReservationDAO.get(reservationId);
    	
    	try {
        	checkUserIsLoggedInUser(subscrReservation.getCustomerId());
    	}
    	catch (UserNotAuthorizedException e) {
    		isReservingUser = false;
    	}
    	try {
    		checkCourtAccess(subscrReservation.getCourtId());
    	}
    	catch (UserNotAuthorizedException e) {
    		isAdminOfInstance = false;
    	}
    	
    	if (!isReservingUser && !isAdminOfInstance) {
    		throw new UserNotAuthorizedException("User not authorized");
    	}
    }    
    
    public void checkLoggedInUserAllowedToModifyCourtCategory(Integer courtCategoryId, Integer refCPInstanceId) throws UserNotAuthorizedException {
    	checkCourtCategoryAccess(courtCategoryId);
    	checkCpInstanceAccess(refCPInstanceId);    	
    }
    
    public void checkLoggedInUserAllowedToModifyCourt(Integer courtId, Integer refCourtCategoryId) throws UserNotAuthorizedException {
    	checkCourtAccess(courtId);
    	checkCourtCategoryAccess(refCourtCategoryId);    	
    }
    
    public void checkLoggedInUserAllowedToModifyWebdesign(Integer webdesignId, Integer refCPInstanceId) throws UserNotAuthorizedException {
    	checkWebdesignAccess(webdesignId);
    	checkCpInstanceAccess(refCPInstanceId);    	
    }
    
    public void checkLoggedInUserAllowedToModifySingleRate(Integer singleRateId, Integer refCourtCategoryId) throws UserNotAuthorizedException {
    	checkSingleRateAccess(singleRateId);
    	checkCourtCategoryAccess(refCourtCategoryId);    	
    }    

    public void checkLoggedInUserAllowedToModifySubscription(Integer subscriptionId, Integer refCourtCategoryId) throws UserNotAuthorizedException {
    	checkSubscriptionAccess(subscriptionId);
    	checkCourtCategoryAccess(refCourtCategoryId);    	
    }       
    
    public void checkLoggedInUserAllowedToModifySubscriptionRate(Integer subscriptionRateId, Integer subscriptionId) throws UserNotAuthorizedException {
    	checkSubscriptionRateAccess(subscriptionRateId);
    	checkSubscriptionAccess(subscriptionId);    	
    }
    
    public void checkLoggedInUserAllowedToModifyUserGroup(Integer userGroupId, Integer refCpInstanceId) throws UserNotAuthorizedException {
    	checkUserGroupAccess(userGroupId);
    	checkCpInstanceAccess(refCpInstanceId);    	
    }   
    
    public void checkLoggedInUserAllowedToModifyPaymentOption(Integer paymentOptionId, Integer refCpInstanceId) throws UserNotAuthorizedException {
    	checkPaymentOptionAccess(paymentOptionId);
    	checkCpInstanceAccess(refCpInstanceId);    	
    }   
    
    public void checkLoggedInUserIsAdminBySingleReservation(Integer singleReservationId) throws UserNotAuthorizedException {
    	checkSingleReservationAccess(singleReservationId);
    }
    
    public void checkLoggedInUserIsAdminBySubscriptionReservation(Integer subscriptionReservationId) throws UserNotAuthorizedException {
    	checkSubscriptionReservationAccess(subscriptionReservationId);
    }
    
    private void checkSingleReservationAccess(Integer singleReservationId) throws UserNotAuthorizedException {
    	if (singleReservationId != null) {
    		SingleReservation singleReservation = singleReservationDAO.get(singleReservationId);
        	checkCourtAccess(singleReservation.getCourtId());    		
    	}
    }
    
    private void checkSubscriptionReservationAccess(Integer subscriptionReservationId) throws UserNotAuthorizedException {
    	if (subscriptionReservationId != null) {
    		SubscriptionReservation subscriptionReservation = subscriptionReservationDAO.get(subscriptionReservationId);
        	checkCourtAccess(subscriptionReservation.getCourtId());    		
    	}
    }
    
    private void checkPaymentOptionAccess(Integer paymentOptionId) throws UserNotAuthorizedException {
    	if (paymentOptionId != null) {
        	PaymentOption paymentOption = paymentOptionDAO.get(paymentOptionId);
        	checkCpInstanceAccess(paymentOption.getCpInstanceId());    		
    	}
    }

    private void checkUserGroupAccess(Integer userGroupId) throws UserNotAuthorizedException {
    	if (userGroupId != null) {
        	UserGroup userGroup = userGroupDAO.get(userGroupId);
        	checkCpInstanceAccess(userGroup.getCpInstanceId());    		
    	}
    }
    
    private void checkSingleRateAccess(Integer singleRateId) throws UserNotAuthorizedException {
    	if (singleRateId != null) {
        	SingleRate singleRate = singleRateDAO.get(singleRateId);
        	checkCourtCategoryAccess(singleRate.getCourtCategoryId());    		
    	}
    }
    
    private void checkSubscriptionRateAccess(Integer subscriptionRateId) throws UserNotAuthorizedException {
    	if (subscriptionRateId != null) {
        	SubscriptionRate subscriptionRate = subscriptionRateDAO.get(subscriptionRateId);
        	checkSubscriptionAccess(subscriptionRate.getSubscriptionId());    		
    	}
    }

    private void checkSubscriptionAccess(Integer subscriptionId) throws UserNotAuthorizedException {
    	if (subscriptionId != null) {
        	Subscription subscription = subscriptionDAO.get(subscriptionId);
        	checkCourtCategoryAccess(subscription.getCourtCategoryId());    		
    	}
    }
    
    private void checkWebdesignAccess(Integer webdesignId) throws UserNotAuthorizedException {
    	if (webdesignId != null) {
        	Webdesign webdesign = webdesignDAO.get(webdesignId);
        	checkCpInstanceAccess(webdesign.getCpInstanceId());    		
    	}
    }

    private void checkCourtAccess(Integer courtId) throws UserNotAuthorizedException {
    	if (courtId != null) {
        	Court court = courtDAO.get(courtId);
        	checkCourtCategoryAccess(court.getCourtCategoryId());    		
    	}
    }
    
    private void checkCourtCategoryAccess(Integer courtCategoryId) throws UserNotAuthorizedException {
    	if (courtCategoryId != null) {
        	CourtCategory courtCategory = courtCategoryDAO.get(courtCategoryId);
        	checkCpInstanceAccess(courtCategory.getCpInstanceId());    		
    	}
    }

    private void checkCpInstanceAccess(Integer cpInstanceId) throws UserNotAuthorizedException {
        if (cpInstanceId != null) {
            CPInstance cpInstance = cpInstanceDAO.get(cpInstanceId);
            
            // skip authorization checks for cpInstances in config state
            if (cpInstance == null || cpInstance.getLicence().toUpperCase().equals("CONFIG")) {
                return;
            }
            
            checkUserLoggedIn();
        	List<String> instanceAuthorities = userInfo.getUserAuthorities().get(cpInstanceId);
            if (instanceAuthorities == null || !instanceAuthorities.contains("ADMIN")) {
                throw new UserNotAuthorizedException("User not authorized"); 
            }        	
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
}
