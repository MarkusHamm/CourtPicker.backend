package com.courtpicker.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import org.junit.Test;

import com.courtpicker.model.Webdesign;

public class WebdesignDAOTest extends BaseDAOTest {
    private WebdesignDAO dao;

    public WebdesignDAOTest() throws Exception {
        super();
        dao = new WebdesignDAO();
        dao.setJdbcTemplate(jdbcTemplate);
    }
    
    @Test
    public void getWebdesign_returnsCorrectEntryIfExists() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.webdesign where cpinstanceid=-1");
        jdbcTemplate.execute("INSERT INTO cp.webdesign (id, cpinstanceid, backgroundstyle, backgroundcolor, " +
                "headercolor, headerbackgroundcolor, controlscolor, contentcolor, contentbackgroundcolor, " +
                "ctselectcolor, ctselectbackgroundcolor, ctselectfocuscolor, linkcolor, reservablehourcolor, " +
                "nonreservablehourcolor, footercolor) values (-1, -1 , 'bgstyle', 'bgcolor', 'hdcolor', " +
                "'hdbgcolor', 'ctrcolor', 'ccolor', 'cbgcolor', 'ctselcolor', 'ctselbgcolor', 'ctfocus', " +
                "'linkcol', 'reshcol', 'nreshcol', 'ftcol')");

        // execute + assert
        Webdesign design = dao.getWebdesign(-1);

        assertEquals(design.getId(), new Integer(-1));
        assertEquals(design.getBackgroundColor(), "bgcolor");
        assertEquals(design.getBackgroundStyle(), "bgstyle");
        assertEquals(design.getControlsColor(), "ctrcolor");
        assertEquals(design.getCpInstanceId(), new Integer(-1));
        assertEquals(design.getHeaderBackgroundColor(), "hdbgcolor");
        assertEquals(design.getHeaderColor(), "hdcolor");
        assertEquals(design.getContentColor(), "ccolor");
        assertEquals(design.getContentBackgroundColor(), "cbgcolor");
        assertEquals(design.getCtSelectColor(), "ctselcolor");
        assertEquals(design.getCtSelectBackgroundColor(), "ctselbgcolor");
        assertEquals(design.getCtSelectFocusColor(), "ctfocus");
        assertEquals(design.getLinkColor(), "linkcol");
        assertEquals(design.getReservableHourColor(), "reshcol");
        assertEquals(design.getNonReservableHourColor(), "nreshcol");
        assertEquals(design.getFooterColor(), "ftcol");
        
        // tear-down
        jdbcTemplate.execute("DELETE FROM cp.webdesign where cpinstanceid=-1");
    }
    
    @Test
    public void getWebdesign_returnsNullIfNoEntryExists() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.webdesign where cpinstanceid=-99");

        // execute + assert
        Webdesign design = dao.getWebdesign(-99);

        assertNull(design);
    }
    
    @Test
    public void persist_webdesignWithoutIdIsInserted() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.webdesign where cpinstanceid=-1");

        // execute + assert
        Webdesign wd = new Webdesign();
        wd.setBackgroundColor("bgcolor");
        wd.setBackgroundStyle("bgstyle");
        wd.setControlsColor("ctlcolor");
        wd.setCpInstanceId(-1);
        wd.setHeaderBackgroundColor("hdbgcolor");
        wd.setHeaderColor("hdcolor");
        wd.setContentColor("ccolor");
        wd.setContentBackgroundColor("cbgcolor");
        wd.setCtSelectColor("ctselcolor");
        wd.setCtSelectBackgroundColor("stselbgcolor");
        wd.setCtSelectFocusColor("ctfoccol");
        wd.setLinkColor("linkcol");
        wd.setReservableHourColor("reshour");
        wd.setNonReservableHourColor("nonreshour");
        wd.setFooterColor("footercol");
        
        wd = dao.persist(wd);

        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from cp.webdesign where cpinstanceid=-1");
        Webdesign dbWd = jdbcTemplate.query("SELECT * from cp.webdesign where cpinstanceid=-1",
                new WebdesignRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(wd.getId(), dbWd.getId());
        assertEquals(wd.getBackgroundColor(), dbWd.getBackgroundColor());
        assertEquals(wd.getBackgroundStyle(), dbWd.getBackgroundStyle());
        assertEquals(wd.getControlsColor(), dbWd.getControlsColor());
        assertEquals(wd.getCpInstanceId(), dbWd.getCpInstanceId());
        assertEquals(wd.getHeaderBackgroundColor(), dbWd.getHeaderBackgroundColor());
        assertEquals(wd.getHeaderColor(), dbWd.getHeaderColor());
        assertEquals(wd.getContentColor(), dbWd.getContentColor());
        assertEquals(wd.getContentBackgroundColor(), dbWd.getContentBackgroundColor());
        assertEquals(wd.getCtSelectColor(), dbWd.getCtSelectColor());
        assertEquals(wd.getCtSelectBackgroundColor(), dbWd.getCtSelectBackgroundColor());
        assertEquals(wd.getCtSelectFocusColor(), dbWd.getCtSelectFocusColor());
        assertEquals(wd.getLinkColor(), dbWd.getLinkColor());
        assertEquals(wd.getReservableHourColor(), dbWd.getReservableHourColor());
        assertEquals(wd.getNonReservableHourColor(), dbWd.getNonReservableHourColor());
        assertEquals(wd.getFooterColor(), dbWd.getFooterColor());

        // tear-down
        jdbcTemplate.execute("DELETE FROM cp.webdesign where cpinstanceid=-1");
    }

    @Test
    public void persist_webdesignWithIdIsUpdated() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.webdesign where cpinstanceid=-1");
        jdbcTemplate.execute("INSERT INTO cp.webdesign (id, cpinstanceid, backgroundstyle, backgroundcolor, " +
                "headercolor, headerbackgroundcolor, controlscolor, contentcolor, contentbackgroundcolor, " +
                "ctselectcolor, ctselectbackgroundcolor, ctselectfocuscolor, linkcolor, reservablehourcolor, " +
                "nonreservablehourcolor, footercolor) values (-1, -1 , 'bgstyle', 'bgcolor', 'hdcolor', " +
                "'hdbgcolor', 'ctrcolor', 'ccolor', 'cbgcolor', 'ctselcolor', 'ctselbgcolor', 'ctfocus', " +
                "'linkcol', 'reshcol', 'nreshcol', 'ftcol')");
                
        // execute + assert
        Webdesign wd = new Webdesign();
        wd.setId(-1);
        wd.setBackgroundColor("bgcolorX");
        wd.setBackgroundStyle("bgstyleX");
        wd.setControlsColor("ctlcolorX");
        wd.setCpInstanceId(-1);
        wd.setHeaderBackgroundColor("hdbgcolorX");
        wd.setHeaderColor("hdcolorX");      
        wd.setContentColor("ccolorX");
        wd.setContentBackgroundColor("cbgcolorX");
        wd.setCtSelectColor("ctselcolorX");
        wd.setCtSelectBackgroundColor("stselbgcolorX");
        wd.setCtSelectFocusColor("focX");
        wd.setLinkColor("linkColX");
        wd.setReservableHourColor("reshX");
        wd.setNonReservableHourColor("nonResX");
        wd.setFooterColor("footerX");
        wd = dao.persist(wd);

        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from cp.webdesign where cpinstanceid=-1");
        Webdesign dbWd = jdbcTemplate.query("SELECT * from cp.webdesign where cpinstanceid=-1",
                new WebdesignRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(wd.getId(), dbWd.getId());
        assertEquals(wd.getBackgroundColor(), dbWd.getBackgroundColor());
        assertEquals(wd.getBackgroundStyle(), dbWd.getBackgroundStyle());
        assertEquals(wd.getControlsColor(), dbWd.getControlsColor());
        assertEquals(wd.getCpInstanceId(), dbWd.getCpInstanceId());
        assertEquals(wd.getHeaderBackgroundColor(), dbWd.getHeaderBackgroundColor());
        assertEquals(wd.getHeaderColor(), dbWd.getHeaderColor());
        assertEquals(wd.getContentColor(), dbWd.getContentColor());
        assertEquals(wd.getContentBackgroundColor(), dbWd.getContentBackgroundColor());
        assertEquals(wd.getCtSelectColor(), dbWd.getCtSelectColor());
        assertEquals(wd.getCtSelectBackgroundColor(), dbWd.getCtSelectBackgroundColor());
        assertEquals(wd.getCtSelectFocusColor(), dbWd.getCtSelectFocusColor());
        assertEquals(wd.getLinkColor(), dbWd.getLinkColor());
        assertEquals(wd.getReservableHourColor(), dbWd.getReservableHourColor());
        assertEquals(wd.getNonReservableHourColor(), dbWd.getNonReservableHourColor());
        assertEquals(wd.getFooterColor(), dbWd.getFooterColor());
        
        // tear-down
        jdbcTemplate.execute("DELETE FROM cp.webdesign where cpinstanceid=-1");
    }
}
