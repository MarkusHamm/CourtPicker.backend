package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.Customer;

public class CustomerRowMapper implements RowMapper<Customer> {

    @Override
    public Customer mapRow(ResultSet rs, int rowNum) throws SQLException {
        Customer customer = new Customer();
        customer.setId(rs.getInt("id"));
        customer.setUserName(rs.getString("username"));
        customer.setPassword(rs.getString("password"));
        customer.setEnabled(rs.getBoolean("enabled"));
        customer.setFirstName(rs.getString("firstname"));
        customer.setLastName(rs.getString("lastname"));
        customer.setEmail(rs.getString("email"));
        customer.setActivationCode(rs.getString("activationcode"));
        customer.setStreet(rs.getString("street"));
        customer.setZipCode(rs.getString("zipcode"));
        customer.setCity(rs.getString("city"));
        customer.setCountry(rs.getString("country"));
        customer.setBirthday(rs.getDate("birthday"));
        customer.setHandyNumber(rs.getString("handynumber"));
        customer.setPhoneNumber(rs.getString("phonenumber"));
        
        return customer;
    }

}
