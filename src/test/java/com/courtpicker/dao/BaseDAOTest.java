package com.courtpicker.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

public abstract class BaseDAOTest {
    protected JdbcTemplate jdbcTemplate;
    
    public BaseDAOTest() throws Exception {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.postgresql.Driver");
        dataSource.setUrl("jdbc:postgresql://localhost:5432/courtpicker");
        dataSource.setUsername("cpuser");
        dataSource.setPassword("DidPfdcp-db");
        
        jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(dataSource);
    }
}
