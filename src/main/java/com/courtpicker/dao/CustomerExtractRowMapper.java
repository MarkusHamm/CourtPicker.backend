package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.CustomerExtract;

public class CustomerExtractRowMapper implements RowMapper<CustomerExtract> {

    @Override
    public CustomerExtract mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerExtract customer = new CustomerExtract();
        customer.setId(rs.getInt("id"));
        customer.setUserName(rs.getString("username"));
        customer.setFirstName(rs.getString("firstname"));
        customer.setLastName(rs.getString("lastname"));
        customer.setEmail(rs.getString("email"));
        customer.setStreet(rs.getString("street"));
        customer.setZipCode(rs.getString("zipcode"));
        customer.setCity(rs.getString("city"));
        customer.setCountry(rs.getString("country"));
        
        return customer;
    }
    
}