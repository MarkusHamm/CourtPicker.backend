package com.courtpicker.model;

import java.util.Date;

public class Customer {
    private Integer id;
    private String userName;
    private String password;
    private Boolean enabled;
    private String firstName;
    private String lastName;
    private String email;
    private String activationCode;
    private String street;
    private String zipCode;
    private String city;
    private String country;
    private Date birthday;
    private String handyNumber;
    private String phoneNumber;
    
    public Customer() {
        this.id = null;
        this.userName = "";
        this.password = "";
        this.enabled = false;
        this.firstName = "";
        this.lastName = "";
        this.email = "";
        this.activationCode = "";
        this.street = "";
        this.zipCode = "";
        this.city = "";
        this.country = "";
        this.birthday = null;
        this.handyNumber = "";
        this.phoneNumber = "";        
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getActivationCode() {
        return activationCode;
    }

    public void setActivationCode(String activationCode) {
        this.activationCode = activationCode;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getHandyNumber() {
        return handyNumber;
    }

    public void setHandyNumber(String handyNumber) {
        this.handyNumber = handyNumber;
    }
}
