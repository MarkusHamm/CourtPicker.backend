package com.courtpicker.exception;

public class UserNotAuthorizedException extends Exception {
    private static final long serialVersionUID = 1L;

    public UserNotAuthorizedException() {
        super();
    }
    
    public UserNotAuthorizedException(String message) { 
        super(message);
    }
    
    public UserNotAuthorizedException(String message, Throwable cause) {
        super(message, cause);
    }
    
    public UserNotAuthorizedException(Throwable cause) {
        super(cause); 
    }
}
