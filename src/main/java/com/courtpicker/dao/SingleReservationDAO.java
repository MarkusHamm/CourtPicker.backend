package com.courtpicker.dao;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.SingleReservation;
import com.courtpicker.uimodel.SingleReservationInfo;

@Component("singleReservationDAO")
@Scope("prototype")
public class SingleReservationDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private SingleReservationRowMapper rowMapper;
    private SingleReservationInfoRowMapper infoRowMapper;

    public SingleReservationDAO() {
        this.rowMapper = new SingleReservationRowMapper();
        this.infoRowMapper = new SingleReservationInfoRowMapper();
    }
    
    public SingleReservation get(Integer id) {
        String query = "select * from cp.singlereservation where id=?";
        List<SingleReservation> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }

    public List<SingleReservation> getReservationsForCourt(Integer courtId, Date fromDate, Date toDate) {
        String query = "select * from cp.singlereservation where courtid=? " +
                "and todate>? and fromdate<? " +
                "and deleted=false";
        List<SingleReservation> matches = jdbcTemplate.query(query, new Object[] { courtId, fromDate, toDate },
                rowMapper);
        return matches;
    }
    
    public List<SingleReservation> getReservationsForCourtCategory(Integer courtCategoryId, Date fromDate, Date toDate) {
        String query = "select * from cp.singlereservation r, cp.court c " +
        		"where r.courtid = c.id and c.courtcategoryid=? and r.todate>? and r.fromdate<? " +
        		"and r.deleted=false";
        List<SingleReservation> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId, fromDate, toDate },
                rowMapper);
        return matches;
    }
    
    public SingleReservation persist(SingleReservation reservation) {
        String query = "";

        // do an insert if id is NOT set
        if (reservation.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.singlereservation_id_seq')");
            reservation.setId(newRecordId);
            query = "insert into cp.singlereservation (customerid, customername, courtid, fromdate, todate, reservationdate, " +
            		"reservingcustomerid, displayname, paid, deleted, calculatedprice, price, comment, paymentdate, paymentoptionid, id) " +
                    "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.singlereservation set customerid=?, customername=?, courtid=?, fromdate=?, todate=?, reservationdate=?, " +
                    "reservingcustomerid=?, displayname=?, paid=?, deleted=?, calculatedprice=?, price=?, comment=?, paymentdate=?, " +
                    "paymentoptionid=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] {reservation.getCustomerId(), reservation.getCustomerName(), reservation.getCourtId(), reservation.getFromDate(),
                reservation.getToDate(), reservation.getReservationDate(), reservation.getReservingCustomerId(), 
                reservation.getDisplayName(), reservation.getPaid(), reservation.getDeleted(), reservation.getCalculatedPrice(), reservation.getPrice(),
                reservation.getComment(), reservation.getPaymentDate(), reservation.getPaymentOptionId(), reservation.getId()});

        return reservation;
    }
    
    public void cancelReservation(Integer id) {
        String query = "update cp.singlereservation set deleted=true where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }
    
    public List<SingleReservationInfo> getSingleReservationInfosForCustomer(Integer customerId) {
        String query = 
            "select " +
            "sr.id, ci.id as cpinstanceid, ci.name as cpinstancename, cc.id as courtcategoryid, cc.name as courtcategoryname, sr.courtid, co.name as courtname, " +
            "sr.fromdate, sr.todate, sr.reservationdate, sr.customerid, cu.firstname as customerfirstname, cu.lastname as customerlastname, " +
            "cu.username as customerusername, sr.customername as reservationcustomername, sr.price, sr.paid, sr.paymentdate, sr.paymentoptionid, po.name as paymentoptionname, sr.comment " +
            "from " +
            "cp.singlereservation sr " +
            "left outer join cp.court co on (sr.courtid=co.id) " +
            "left outer join cp.courtcategory cc on (co.courtcategoryid=cc.id) " +
            "left outer join cp.cpinstance ci on (cc.cpinstanceid=ci.id) " +
            "left outer join cp.customer cu on (sr.customerid=cu.id) " +
            "left outer join cp.paymentoption po on (sr.paymentoptionid=po.id) " +
            "where sr.customerid=? and sr.deleted=false " + 
            "order by fromdate desc";
                
        List<SingleReservationInfo> matches = jdbcTemplate.query(query, new Object[] { customerId }, infoRowMapper);
        return matches;
    }
    
    public List<SingleReservationInfo> getSingleReservationInfosForCpInstance(Integer cpInstanceId) {
        String query = 
            "select " +
            "sr.id, ci.id as cpinstanceid, ci.name as cpinstancename, cc.id as courtcategoryid, cc.name as courtcategoryname, sr.courtid, co.name as courtname, " +
            "sr.fromdate, sr.todate, sr.reservationdate, sr.customerid, cu.firstname as customerfirstname, cu.lastname as customerlastname, " +
            "cu.username as customerusername, sr.customername as reservationcustomername, sr.price, sr.paid, sr.paymentdate, sr.paymentoptionid, po.name as paymentoptionname, sr.comment " +
            "from " +
            "cp.singlereservation sr " +
            "left outer join cp.court co on (sr.courtid=co.id) " +
            "left outer join cp.courtcategory cc on (co.courtcategoryid=cc.id) " +
            "left outer join cp.cpinstance ci on (cc.cpinstanceid=ci.id) " +
            "left outer join cp.customer cu on (sr.customerid=cu.id) " +
            "left outer join cp.paymentoption po on (sr.paymentoptionid=po.id) " +
            "where ci.id=? and sr.deleted=false " +
            "order by fromdate desc";
                
        List<SingleReservationInfo> matches = jdbcTemplate.query(query, new Object[] { cpInstanceId }, infoRowMapper);
        return matches;
    }
    
    public Integer getNrOfFutureReservations(Integer customerId, Integer cpInstanceId) {
        String query = "select count(1) from cp.singlereservation where fromdate > current_timestamp and deleted=false and customerid=? " +
        		"and courtid in (select c.id from cp.court c, cp.courtcategory cc where c.courtcategoryid=cc.id and cc.cpinstanceid=?)";
        Integer result = jdbcTemplate.queryForObject(query, new Object[] { customerId, cpInstanceId }, Integer.class);
        return result;
    }
    
    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
