package com.courtpicker.uimodel;

import java.util.ArrayList;
import java.util.List;

import com.courtpicker.model.Customer;

public class AuthStatus {
    private boolean isLoggedIn;
    private Customer loggedInUser;
    private List<String> authorities;
    private String statusMessage;

    public AuthStatus() {
        isLoggedIn = false;
        loggedInUser = null;
        authorities = new ArrayList<String>();
        statusMessage = "";
    }
    
    public boolean isLoggedIn() {
        return isLoggedIn;
    }

    public void setLoggedIn(boolean isLoggedIn) {
        this.isLoggedIn = isLoggedIn;
    }

    public Customer getLoggedInUser() {
        return loggedInUser;
    }

    public void setLoggedInUser(Customer loggedInUser) {
        this.loggedInUser = loggedInUser;
    }

    public List<String> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(List<String> authorities) {
        this.authorities = authorities;
    }

    public String getStatusMessage() {
        return statusMessage;
    }

    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
    }
}
