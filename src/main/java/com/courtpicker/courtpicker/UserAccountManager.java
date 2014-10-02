package com.courtpicker.courtpicker;

import java.util.UUID;

import javax.inject.Inject;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.courtpicker.dao.CustomerDAO;
import com.courtpicker.exception.UserAlreadyExistsException;
import com.courtpicker.model.Customer;
import com.courtpicker.tools.CPMailSender;
import com.courtpicker.tools.MailEngine;

@Component("userAccountManager")
@Scope("prototype")
public class UserAccountManager {
    @Inject
    private CustomerDAO customerDAO;
    @Inject 
    private CPMailSender cpMailSender;

    public Customer registerUser(String userName, String password, String email, String firstName, String lastName) throws UserAlreadyExistsException {
        Customer customer = new Customer();
        customer.setUserName(userName);
        customer.setPassword(DigestUtils.md5Hex(password));
        customer.setEmail(email);
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setActivationCode(UUID.randomUUID().toString());
        
        Customer registeredCustomer = createUser(customer);
        cpMailSender.sendAccountCreatedMail(registeredCustomer);
        
        return registeredCustomer;
    }
    
    public Customer registerUserExtended(String userName, String password, String email, String firstName, String lastName,
            String phoneNumber, String street, String zipCode, String city, String country) throws UserAlreadyExistsException {
        Customer customer = new Customer();
        customer.setUserName(userName);
        customer.setPassword(DigestUtils.md5Hex(password));
        customer.setEmail(email);
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setPhoneNumber(phoneNumber);
        customer.setStreet(street);
        customer.setZipCode(zipCode);
        customer.setCity(city);
        customer.setCountry(country);
        customer.setActivationCode(UUID.randomUUID().toString());
        
        Customer registeredCustomer = createUser(customer);
        cpMailSender.sendAccountCreatedMail(registeredCustomer);
        
        return registeredCustomer;
    }    
    
    public Boolean activateUser(Integer userId, String activationCode) {
        Customer customer = customerDAO.get(userId);
        
        if (customer == null) {
            return false;
        }
        if (customer.getActivationCode() == null || !customer.getActivationCode().equals(activationCode)) {
            return false;
        }
        
        customer.setEnabled(true);
        customer.setActivationCode("");
        customerDAO.persist(customer);
        return true;
    }
    
    public Customer createOrGetMinimalUser(String email, String name) {
        Customer customer = new Customer();
        customer.setUserName(email);
        // password "temp"
        customer.setPassword("3d801aa532c1cec3ee82d87a99fdf63f");
        customer.setEnabled(true);
        customer.setFirstName(extractFirstName(name));
        customer.setLastName(extractLastName(name));
        customer.setEmail(email);
        
        try {
            customer = createUser(customer);
        } catch (UserAlreadyExistsException e) {
            return e.getExistingUser();
        }
        
        cpMailSender.sendMinimalAccountCreatedMail(customer);

        return customer;
    }
    
    public Boolean processForgotPasswordRequest(String email, String firstName, String lastName) {
        Customer customer = customerDAO.getByNameAndEmail(email, firstName, lastName);
        
        if (customer == null) {    
            return false;
        }
        
        String newPassword = generateRandomPassword();
        String newPasswordMd5Encoded = DigestUtils.md5Hex(newPassword);
        customer.setPassword(newPasswordMd5Encoded);
        
        customerDAO.persist(customer);        
        cpMailSender.sendPasswordForgottenMail(customer, newPassword);
        
        return true;        
    }
    
    public String changeUserPassword(Integer userId, String oldPassword, String newPassword) {
        Customer customer = customerDAO.get(userId);
        if (customer == null) {
            return ""; // no customer found with id
        }
        
        String oldPasswordMd5 = DigestUtils.md5Hex(oldPassword);
        if (!customer.getPassword().equals(oldPasswordMd5)) {
            return ""; // old password wrong
        }
        
        String newPasswordMd5 = DigestUtils.md5Hex(newPassword);
        customer.setPassword(newPasswordMd5);
        customerDAO.persist(customer);
        
        return newPasswordMd5;
    }
    
    private Customer createUser(Customer user) throws UserAlreadyExistsException {
        Customer customerWithSameEmail = customerDAO.getByEmail(user.getEmail());
        Customer customerWithSameUserName = customerDAO.getByUserName(user.getUserName());       
        
        if (customerWithSameEmail != null) {
            throw new UserAlreadyExistsException("User with same email already exists", customerWithSameEmail);
        }
        if (customerWithSameUserName != null) {
            throw new UserAlreadyExistsException("User with same username already exists", customerWithSameUserName);
        }
        
        return customerDAO.persist(user);
    }
    
    private String extractFirstName(String name) {
        String[] splittedName = name.split(" ", 2);
        if (splittedName.length > 1) {
            return splittedName[0];
        }
        return "";
    }
    
    private String extractLastName(String name) {
        String[] splittedName = name.split(" ", 2);
        if (splittedName.length > 1) {
            return splittedName[1];
        }
        return splittedName[0];
    }
    
    private String generateRandomPassword() {
    	String uuid = UUID.randomUUID().toString();
    	String uuidWithoutDash = uuid.replaceAll("-", "");
    	String uuidWithoutDashOfLength8 = uuidWithoutDash.substring(0, 8);
    	
    	return uuidWithoutDashOfLength8;
    }
}
