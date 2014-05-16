package com.courtpicker.exception;

import com.courtpicker.model.Customer;

public class UserAlreadyExistsException extends Exception {
    private static final long serialVersionUID = 1L;
    
    private Customer existingUser = null;
    
    public UserAlreadyExistsException() { }
    
    public UserAlreadyExistsException(String message) {
        super(message);
    }

    public UserAlreadyExistsException(String message, Customer existingUser) {
        super(message);
        this.existingUser = existingUser;
    }

    public Customer getExistingUser() {
        return existingUser;
    }

    public void setExistingUser(Customer existingUser) {
        this.existingUser = existingUser;
    }
}
