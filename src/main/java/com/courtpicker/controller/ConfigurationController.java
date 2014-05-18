package com.courtpicker.controller;

import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.courtpicker.configurator.CssDesign;
import com.courtpicker.configurator.CssDesignFactory;
import com.courtpicker.dao.CPInstanceDAO;
import com.courtpicker.dao.CourtCategoryDAO;
import com.courtpicker.dao.CourtDAO;
import com.courtpicker.dao.CssFileDAO;
import com.courtpicker.dao.CustomerDAO;
import com.courtpicker.dao.CustomerUserGroupDAO;
import com.courtpicker.dao.PaymentOptionDAO;
import com.courtpicker.dao.RateDAO;
import com.courtpicker.dao.SubscriptionRatePeriodDAO;
import com.courtpicker.dao.UserGroupDAO;
import com.courtpicker.dao.WebdesignDAO;
import com.courtpicker.dao.WebdesignFileDAO;
import com.courtpicker.model.CPInstance;
import com.courtpicker.model.Court;
import com.courtpicker.model.CourtCategory;
import com.courtpicker.model.Customer;
import com.courtpicker.model.CustomerExtract;
import com.courtpicker.model.PaymentOption;
import com.courtpicker.model.Rate;
import com.courtpicker.model.SubscriptionRatePeriod;
import com.courtpicker.model.UserGroup;
import com.courtpicker.model.Webdesign;
import com.courtpicker.model.WebdesignFile;
import com.courtpicker.tools.FileHandler;

@Controller
public class ConfigurationController {
    @Inject
    private CPInstanceDAO cpInstanceDAO;
    @Inject
    private CourtCategoryDAO courtCategoryDAO;
    @Inject
    private CourtDAO courtDAO;
    @Inject
    private WebdesignDAO webdesignDAO;
    @Inject
    private CssFileDAO cssFileDAO;
    @Inject
    private WebdesignFileDAO webdesignFileDAO;
    @Inject
    private CssDesignFactory cssDesignFactory;
    @Inject
    private FileHandler fileHandler;
    @Inject
    private RateDAO rateDAO;
    @Inject
    private UserGroupDAO userGroupDAO;
    @Inject
    private CustomerUserGroupDAO customerUserGroupDAO;
    @Inject
    private SubscriptionRatePeriodDAO subscriptionRatePeriodDAO;
    @Inject
    private PaymentOptionDAO paymentOptionDAO;
    @Inject
    private CustomerDAO customerDAO;

    @RequestMapping(value = "/api/createNewInstance", method = RequestMethod.GET)
    public @ResponseBody
    CPInstance createNewInstanceApi() throws IOException, InterruptedException {
        CPInstance cpInstance = new CPInstance();
        cpInstance.setName("");
        cpInstance.setLicence("config");
        cpInstance = cpInstanceDAO.persist(cpInstance);

        Webdesign webdesign = new Webdesign();
        webdesign.setCpInstanceId(cpInstance.getId());
        webdesign.setBackgroundStyle("TEXTURED");
        webdesign.setBackgroundColor("ffffff");
        webdesign.setHeaderBackgroundColor("fcfcfc");
        webdesign.setHeaderColor("287bbf");
        webdesign.setControlsColor("287bbf");
        webdesign.setControlsTextColor("ffffff");
        webdesign.setContentBackgroundColor("ffffff");
        webdesign.setContentColor("808080");
        webdesign.setCtSelectBackgroundColor("f2f2f2");
        webdesign.setCtSelectColor("555555");
        webdesign.setCtSelectFocusColor("287bbf");
        webdesign.setLinkColor("4bb0eb");
        webdesign.setReservableHourColor("d0e2f5");
        webdesign.setNonReservableHourColor("efefef");
        webdesign.setFooterColor("555555");
        webdesignDAO.persist(webdesign);

        /*
         * WebdesignFile webdesignFile = new WebdesignFile();
         * webdesignFile.setWebdesignId(webdesign.getId());
         * webdesignFile.setType("logo"); webdesignFile.setContent(null);
         * webdesignFileDAO.persist(webdesignFile);
         */

        return cpInstance;
    }

    @RequestMapping(value = "/api/saveCpInstance", method = RequestMethod.POST)
    public @ResponseBody
    CPInstance updateCpInstance(@RequestBody CPInstance cpInstance) {
        return cpInstanceDAO.persist(cpInstance);
    }

    @RequestMapping(value = "/api/getCpInstanceByShortName", method = RequestMethod.GET)
    public @ResponseBody
    CPInstance getCpInstanceByShortName(@RequestParam String shortName) {
        return cpInstanceDAO.getByShortName(shortName);
    }

    @RequestMapping("createNewInstance")
    public ModelAndView createNewInstance(HttpServletRequest request, HttpServletResponse response) throws IOException {
        CPInstance cpInstance = new CPInstance();
        cpInstance.setName("");
        cpInstance.setLicence("standard");
        cpInstance = cpInstanceDAO.persist(cpInstance);

        request.getSession().setAttribute("cpInstanceId", cpInstance.getId());

        Webdesign webdesign = new Webdesign();
        webdesign.setCpInstanceId(cpInstance.getId());
        webdesign.setBackgroundStyle("TEXTURED");
        webdesign.setBackgroundColor("FFFFFF");
        webdesign.setHeaderBackgroundColor("FCFCFC");
        webdesign.setHeaderColor("297CBF");
        webdesign.setControlsColor("297CBF");
        webdesign.setContentBackgroundColor("FFFFFF");
        webdesign.setContentColor("808080");
        webdesign.setCtSelectBackgroundColor("F2F2F2");
        webdesign.setCtSelectColor("555555");
        webdesign.setCtSelectFocusColor("297CBF");
        webdesign.setLinkColor("4cb1eb");
        webdesign.setReservableHourColor("D0E5F5");
        webdesign.setNonReservableHourColor("EFEFEF");
        webdesign.setFooterColor("555555");
        persistAndApplyWebdesign(webdesign, request);

        WebdesignFile webdesignFile = new WebdesignFile();
        webdesignFile.setWebdesignId(webdesign.getId());
        webdesignFile.setType("logo");
        webdesignFile.setContent(null);
        webdesignFileDAO.persist(webdesignFile);

        return new ModelAndView("redirect:configureCourts.htm");
    }

    @RequestMapping("configureCourts.htm")
    public ModelAndView configureCourts(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("configureCourts");
    }

    @RequestMapping("configureRates.htm")
    public ModelAndView configureRates(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("configureRates");
    }

    @RequestMapping("configureDesign.htm")
    public ModelAndView configureDesign(HttpServletRequest request, HttpServletResponse response) {
        return new ModelAndView("configureDesign");
    }

    @RequestMapping(value = "/api/getCourtCategories", method = RequestMethod.GET)
    public @ResponseBody
    List<CourtCategory> getCourtCategories(@RequestParam Integer cpInstanceId) {
        return courtCategoryDAO.getAllCourtCategories(cpInstanceId);
    }

    @RequestMapping(value = "/api/saveCourtCategory", method = RequestMethod.POST)
    public @ResponseBody
    CourtCategory saveCourtCategory(@RequestBody CourtCategory courtCategory) {
        return courtCategoryDAO.persist(courtCategory);
    }

    @RequestMapping(value = "/api/deleteCourtCategory", method = RequestMethod.POST)
    public @ResponseBody
    void deleteCourtCategory(@RequestParam Integer id) {
        courtCategoryDAO.delete(id);
    }

    @RequestMapping(value = "/api/getCourts", method = RequestMethod.GET)
    public @ResponseBody
    List<Court> getCourts(@RequestParam Integer courtCategoryId) {
        return courtDAO.getAllCourts(courtCategoryId);
    }

    @RequestMapping(value = "/api/saveCourt", method = RequestMethod.POST)
    public @ResponseBody
    Court saveCourt(@RequestBody Court court) {
        return courtDAO.persist(court);
    }

    @RequestMapping(value = "/api/deleteCourt", method = RequestMethod.POST)
    public @ResponseBody
    void deleteCourt(@RequestParam Integer id) {
        courtDAO.delete(id);
    }

    @RequestMapping(value = "/api/getWebdesign", method = RequestMethod.GET)
    public @ResponseBody
    Webdesign getWebdesign(@RequestParam Integer cpInstanceId) {
        return webdesignDAO.getWebdesign(cpInstanceId);
    }

    @RequestMapping(value = "/api/saveWebdesign", method = RequestMethod.POST)
    public @ResponseBody
    Webdesign saveWebdesign(HttpServletRequest request, HttpServletResponse response, @RequestBody Webdesign webdesign)
            throws IOException {
        return persistAndApplyWebdesign(webdesign, request);
    }

    @RequestMapping(value = "/api/createWebdesignCss", method = RequestMethod.POST)
    public @ResponseBody
    String createWebdesignCss(@RequestBody Webdesign webdesign) {
        CssDesign cssDesign = cssDesignFactory.create(webdesign);
        return cssDesign.getStringRepresentation();
    }

    @RequestMapping(value = "/api/getWebdesignCss", method = RequestMethod.GET)
    public @ResponseBody
    String getWebdesignCss(@RequestParam Integer cpInstanceId) {
        Webdesign webdesign = webdesignDAO.getWebdesign(cpInstanceId);
        CssDesign cssDesign = cssDesignFactory.create(webdesign);
        return cssDesign.getStringRepresentation();
    }

    @RequestMapping(value = "/api/getWebdesignFile", method = RequestMethod.GET)
    public @ResponseBody
    String getWebdesignFile(@RequestParam Integer webdesignId, @RequestParam String type) {
        WebdesignFile webdesignFile = webdesignFileDAO.getWebdesignFile(webdesignId, type);
        if (webdesignFile == null) {
            return "";
        }

        String base64EncodedFileContent = new String(Base64.encodeBase64(webdesignFile.getContent()));
        return base64EncodedFileContent;
    }

    // @RequestMapping(value = "/api/saveWebdesignFile",
    // method=RequestMethod.POST)
    // public @ResponseBody WebdesignFile saveWebdesignFile(@RequestBody
    // WebdesignFile webdesignFile) {
    // return webdesignFileDAO.persist(webdesignFile);
    // }

    @RequestMapping(value = "/api/getRates", method = RequestMethod.GET)
    public @ResponseBody
    List<Rate> getRates(@RequestParam Integer courtCategoryId) {
        return rateDAO.getRates(courtCategoryId);
    }

    @RequestMapping(value = "/api/saveRate", method = RequestMethod.POST)
    public @ResponseBody
    Rate saveRate(@RequestBody Rate rate) {
        return rateDAO.persist(rate);
    }

    @RequestMapping(value = "/api/deleteRate", method = RequestMethod.POST)
    public @ResponseBody
    void deleteRate(@RequestParam Integer id) {
        rateDAO.delete(id);
    }

    @RequestMapping(value = "/api/getSubscriptionPeriodRates", method = RequestMethod.GET)
    public @ResponseBody
    List<SubscriptionRatePeriod> getSubscriptionPeriodRates(@RequestParam Integer courtCategoryId) {
        return subscriptionRatePeriodDAO.getSubscriptionPeriodRates(courtCategoryId);
    }

    @RequestMapping(value = "/api/saveSubscriptionPeriodRate", method = RequestMethod.POST)
    public @ResponseBody
    SubscriptionRatePeriod saveSubscriptionPeriodRate(@RequestBody SubscriptionRatePeriod subscriptionPeriodRate) {
        return subscriptionRatePeriodDAO.persist(subscriptionPeriodRate);
    }

    @RequestMapping(value = "/api/deleteSubscriptionPeriodRate", method = RequestMethod.POST)
    public @ResponseBody
    void deleteSubscriptionPeriodRate(@RequestParam Integer id) {
        subscriptionRatePeriodDAO.delete(id);
    }

    @RequestMapping(value = "/api/getUserGroups", method = RequestMethod.GET)
    public @ResponseBody
    List<UserGroup> getUserGroups(@RequestParam Integer cpInstanceId) {
        return userGroupDAO.getUserGroups(cpInstanceId);
    }

    @RequestMapping(value = "/api/saveUserGroup", method = RequestMethod.POST)
    public @ResponseBody
    UserGroup saveUserGroup(@RequestBody UserGroup userGroup) {
        return userGroupDAO.persist(userGroup);
    }

    @RequestMapping(value = "/api/deleteUserGroup", method = RequestMethod.POST)
    public @ResponseBody
    void deleteUserGroup(@RequestParam Integer id) {
        // If I delete a userGroup I have to delete its customer mappings as
        // well
        userGroupDAO.delete(id);
        customerUserGroupDAO.deleteEntries(id);
    }

    @RequestMapping(value = "/api/getUserGroupUser", method = RequestMethod.GET)
    public @ResponseBody
    List<CustomerExtract> getUserGroupUser(@RequestParam Integer userGroupId) {
        return customerUserGroupDAO.getUserGroupCustomerExtract(userGroupId);
    }

    @RequestMapping(value = "/api/addUserToUserGroup", method = RequestMethod.POST)
    public @ResponseBody
    void addUserGroupUser(@RequestParam Integer userGroupId, @RequestParam Integer userId) {
        customerUserGroupDAO.addCustomerToUserGroup(userGroupId, userId);
    }

    @RequestMapping(value = "/api/removeUserFromUserGroup", method = RequestMethod.POST)
    public @ResponseBody
    void removeUserFromUserGroup(@RequestParam Integer userGroupId, @RequestParam Integer userId) {
        customerUserGroupDAO.removeCustomerFromUserGroup(userGroupId, userId);
    }

    @RequestMapping(value = "/api/getPaymentOptions", method = RequestMethod.GET)
    public @ResponseBody
    List<PaymentOption> getPaymentOptions(@RequestParam Integer cpInstanceId) {
        return paymentOptionDAO.getPaymentOptions(cpInstanceId);
    }

    @RequestMapping(value = "/api/savePaymentOption", method = RequestMethod.POST)
    public @ResponseBody
    PaymentOption savePaymentOption(@RequestBody PaymentOption paymentOption) {
        return paymentOptionDAO.persist(paymentOption);
    }

    @RequestMapping(value = "/api/deletePaymentOption", method = RequestMethod.POST)
    public @ResponseBody
    void deletePaymentOption(@RequestParam Integer id) {
        paymentOptionDAO.delete(id);
    }

    // ---------- validators --------------

    @RequestMapping(value = "/api/validateUniqueCpShortName", method = RequestMethod.GET)
    public @ResponseBody
    String validateUniqueCpShortName(@RequestParam String shortName, @RequestParam(required=false) Integer excludeCurrentCpInstanceId) {
        if (shortName.equals("")) {
            return "VALID";
        }

        CPInstance queryResult = cpInstanceDAO.getByShortName(shortName);
        if (queryResult == null) {
            return "VALID";
        }
        if (excludeCurrentCpInstanceId != null && queryResult.getId().equals(excludeCurrentCpInstanceId)) {
            return "VALID";
        }

        return "INVALID";
    }
    
    @RequestMapping(value = "/api/validateUniqueUserName", method = RequestMethod.GET)
    public @ResponseBody 
    String validateUniqueUserName(@RequestParam String userName, @RequestParam(required=false) Integer excludeCurrentUserId) {
        if (userName.equals("")) {
            return "VALID";
        }

        Customer queryResult = customerDAO.getByUserName(userName);
        if (queryResult == null) {
            return "VALID";
        }
        if (excludeCurrentUserId != null && queryResult.getId().equals(excludeCurrentUserId)) {
            return "VALID";
        }

        return "INVALID";
    }
    
    @RequestMapping(value = "/api/validateUniqueUserEmail", method = RequestMethod.GET)
    public @ResponseBody 
    String validateUniqueUserEmail(@RequestParam String userEmail, @RequestParam(required=false) Integer excludeCurrentUserId) {
        if (userEmail.equals("")) {
            return "VALID";
        }

        Customer queryResult = customerDAO.getByEmail(userEmail);
        if (queryResult == null) {
            return "VALID";
        }
        if (excludeCurrentUserId != null && queryResult.getId().equals(excludeCurrentUserId)) {
            return "VALID";
        }

        return "INVALID";
    }

    public CourtCategoryDAO getCourtCategoryDAO() {
        return courtCategoryDAO;
    }

    public void setCourtCategoryDAO(CourtCategoryDAO courtCategoryDAO) {
        this.courtCategoryDAO = courtCategoryDAO;
    }

    public CourtDAO getCourtDAO() {
        return courtDAO;
    }

    public void setCourtDAO(CourtDAO courtDAO) {
        this.courtDAO = courtDAO;
    }

    private String getServerPath(String servletPath, HttpServletRequest request) {
        HttpSession session = request.getSession();
        ServletContext sc = session.getServletContext();
        String realPath = sc.getRealPath(servletPath);

        return realPath;
    }

    private Webdesign persistAndApplyWebdesign(Webdesign webdesign, HttpServletRequest request) throws IOException {
        webdesign = webdesignDAO.persist(webdesign);

        // TODO: remove after check if really not necessary
        // CssDesign cssDesign = cssDesignFactory.create(webdesign);
        // cssFileDAO.persistContent(webdesign.getCpInstanceId(),
        // cssDesign.toString());
        // String serverPath =
        // getServerPath("/resources/css/instance/instancestyle-" +
        // webdesign.getCpInstanceId() + ".css", request);
        // System.out.println(serverPath);
        // fileHandler.writeStringToFile(serverPath,
        // cssDesign.getStringRepresentation());

        return webdesign;
    }

    public UserGroupDAO getUserGroupDAO() {
        return userGroupDAO;
    }

    public void setUserGroupDAO(UserGroupDAO userGroupDAO) {
        this.userGroupDAO = userGroupDAO;
    }
}
