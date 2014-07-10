package com.courtpicker.security;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Customer;

public class UserInfo implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private boolean loggedIn;
    private Customer loggedInUser;
    private Map<Integer, List<String>> userAuthorities;
    
    public UserInfo() {
        loggedIn = false;
        loggedInUser = null;
        userAuthorities = null;
    }

    public boolean isLoggedIn() {
        return loggedIn;
    }


    public void setLoggedIn(boolean loggedIn) {
        this.loggedIn = loggedIn;
    }

    public Customer getLoggedInUser() {
        return loggedInUser;
    }

    public void setLoggedInUser(Customer loggedInUser) {
        this.loggedInUser = loggedInUser;
    }

    public Map<Integer, List<String>> getUserAuthorities() {
        return userAuthorities;
    }

    public void setUserAuthorities(Map<Integer, List<String>> userAuthorities) {
        this.userAuthorities = userAuthorities;
    }
}
