package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Court;
import com.courtpicker.model.Customer;
import com.courtpicker.model.CustomerExtract;

@Component("customerDAO")
@Scope("prototype")
public class CustomerDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private CustomerRowMapper rowMapper;
    private CustomerExtractRowMapper extractRowMapper;

    public CustomerDAO() {
        rowMapper = new CustomerRowMapper();
        extractRowMapper = new CustomerExtractRowMapper();
    }

    public List<Customer> getAll() {
        String query = "select * from roger.customer where enabled=true order by lastname asc";
        List<Customer> matches = jdbcTemplate.query(query, new Object[] {}, rowMapper);
        return matches;
    }
    
    public List<CustomerExtract> getAllExctract() {
        String query = "select * from roger.customer where enabled=true order by lastname asc";
        List<CustomerExtract> matches = jdbcTemplate.query(query, new Object[] {}, extractRowMapper);
        return matches;
    }
    
    public List<CustomerExtract> getAdminUserExctract(Integer cpInstanceId) {
        String query = "select * from roger.customer where id in " +
        		"(select userid from roger.authority where cpinstanceid=? and authority='ADMIN')";
        List<CustomerExtract> matches = jdbcTemplate.query(query, new Object[] { cpInstanceId }, extractRowMapper);
        return matches;
    }    
    
    public Customer get(Integer id) {
        String query = "select * from roger.customer where id=?";
        List<Customer> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }
    
    public Customer getByUserCredentials(String userName, String md5EncodedPassword) {
        String query = "select * from roger.customer where lower(username)=? and password=? and enabled=?";
        List<Customer> matches = jdbcTemplate.query(query, new Object[] { userName.toLowerCase(), md5EncodedPassword, true }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);        
    }

    public Customer getByNameAndEmail(String email, String firstName, String lastName) {
        String query = "select * from roger.customer where lower(email)=? and lower(firstname)=? and lower(lastname)=?";
        List<Customer> matches = jdbcTemplate.query(query, new Object[] { email.toLowerCase(), firstName.toLowerCase(), lastName.toLowerCase() }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);        
    }
    
    public Customer getByEmail(String email) {
        String query = "select * from roger.customer where lower(email)=?";
        List<Customer> matches = jdbcTemplate.query(query, new Object[] { email.toLowerCase() }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);        
    }
    
    public Customer getByUserName(String userName) {
        String query = "select * from roger.customer where lower(username)=?";
        List<Customer> matches = jdbcTemplate.query(query, new Object[] { userName.toLowerCase() }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);        
    }
    
    public Customer persist(Customer customer) {
        String query = "";

        // do an insert if id is NOT set
        if (customer.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('roger.customer_id_seq')");
            customer.setId(newRecordId);
            query = "insert into roger.customer (username, password, enabled, firstname, lastname, " +
            		"email, activationcode, street, zipcode, city, country, birthday, handynumber, phonenumber, id) " +
            		"values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update roger.customer set username=?, password=?, enabled=?, firstname=?, lastname=?, email=?, " +
            		"activationcode=?, street=?, zipcode=?, city=?, country=?, birthday=?, handynumber=?, phonenumber=? " +
            		"where id=?";
        }

        jdbcTemplate.update(query, new Object[] { customer.getUserName(), customer.getPassword(), customer.getEnabled(),
                customer.getFirstName(), customer.getLastName(), customer.getEmail(), customer.getActivationCode(),
                customer.getStreet(), customer.getZipCode(), customer.getCity(), customer.getCountry(), customer.getBirthday(),
                customer.getHandyNumber(), customer.getPhoneNumber(), customer.getId()});

        return customer;
    }
   
    public void delete(Integer id) {
        String query = "delete from roger.customer where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
