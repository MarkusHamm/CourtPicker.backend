<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<script>
$(document).ready(function() {
	
	$('.submenu').hover(function() {
		$(this).toggleClass('submenu_hover');
	});
	
	$('#reservationMenuItem').mouseenter(function() {
		$('#startmenu').stop(true, true).slideDown(600,"easeOutExpo");
	});
		
	$('#reservationMenuItem').mouseleave(function() {
		$('#startmenu').stop(true, true).slideUp(600,"easeOutExpo");
	});
	
	$('#aboreservation').click(function(e) {
		window.location = 'aboReservation.htm';
	});
	
	$('#pricesMenuItem').mouseenter(function() {
		$('#pricesmenu').stop(true, true).slideDown(600,"easeOutExpo");
	});
	
	$('#pricesMenuItem').mouseleave(function() {
		$('#pricesmenu').stop(true, true).slideUp(600,"easeOutExpo");
	});
	
	$('#single').click(function(e) {
		window.location = 'prices.htm?tabnumber=0';
	});
	
	$('#abo').click(function(e) {
		window.location = 'prices.htm?tabnumber=1';
	});
	
	$('#userMenuItem').mouseenter(function() {
		$('#userdatamenu').stop(true, true).slideDown(600,"easeOutExpo");
	});
	
	$('#userMenuItem').mouseleave(function() {
		$('#userdatamenu').stop(true, true).slideUp(600,"easeOutExpo");
	});
	
	$('#customerdatasheet').click(function(e) {
		window.location = 'customer.htm?tabnumber=0';
	});
	
	$('#customerreservations').click(function(e) {
		window.location = 'customer.htm?tabnumber=1';
	});
		
	$('#adminMenuItem').mouseenter(function() {
		$('#adminmenu').stop(true,true).slideDown(600,"easeOutExpo");
	});
	
	$('#adminMenuItem').mouseleave(function() {
		$('#adminmenu').stop(true,true).slideUp(600, "easeOutExpo");
	});	
	
	$('#courtsmenu').click(function(e) {
		window.location = 'admin.htm?tabnumber=0';
	});
	
	$('#reservationmenu').click(function(e) {
		window.location = 'adminReservation.htm';
	});
	
	$('#costsmenu').click(function(e) {
		window.location = 'admin.htm?tabnumber=1';
	});
	
	$('#saisonsmenu').click(function(e) {
		window.location = 'admin.htm?tabnumber=2';
	});
	
	$('#settingsmenu').click(function(e) {
		window.location = 'admin.htm?tabnumber=3';
	});
	
	$('#reservationsmenu').click(function(e) {
		window.location = 'admin.htm?tabnumber=4';
	});
	
	$('#customersmenu').click(function(e) {
		window.location = 'admin.htm?tabnumber=5';
	});
	
	$('#statisticsmenu').click(function(e) {
		window.location = 'admin.htm?tabnumber=6';
	});
	
	$('#membersmenu').click(function(e) {
		window.location = 'admin.htm?tabnumber=7';
	});
	
	/* login drop-down menu */
	$('#loginbutton').click(function(e) {
		$('#loginmenu').stop(true,true).slideDown(200,"easeOutExpo");
	});
	
	$('#registrationMenuItem').click(function(e) {
		$('#registrationmenu').stop(true,true).slideDown(200,"easeOutExpo");
	});
	
	$('#forgotPasswordMenuItem').click(function(e) {
		$('#loginmenu').stop(true,true).slideUp(100,"easeOutExpo");
		$('#forgotpasswordmenu').stop(true,true).slideDown(200,"easeOutExpo");
	});	
	
	$(document).on("submit", "#registrationForm", function(event) {
		event.preventDefault(); 
		loadRegistrationXMLDoc('registrationDone.htm', 'registrationmenu');
	});
	
// 	$('#registrationForm').submit(function(event) {
// 		event.preventDefault(); 
// 		loadRegistrationXMLDoc('registrationDone.htm', 'registrationmenu');
// 	});

	$(document).on("click", "#registrationCancel", function(event){
		event.stopPropagation();
		loadRegistrationXMLDoc('registrationForm.htm', 'registrationmenu');
		$('#registrationmenu').stop(true,true).slideUp(200, "easeOutExpo");
	});
	
// 	$('#registrationCancel').click(function(event) {
// 		event.stopPropagation();
// 		loadRegistrationXMLDoc('registrationForm.htm', 'registrationmenu');
// 		$('#registrationmenu').stop(true,true).slideUp(200, "easeOutExpo");
// 	});

	$(document).on("submit", "#passwordForm", function(event){
		event.preventDefault(); 
		loadRegistrationXMLDoc('sendPasswordDone.htm', 'forgotpasswordmenu');
	});	

	/*
	$('#registrationFinishButton').click(function(event) {
		event.stopPropagation();
		//loadRegistrationXMLDoc('registrationForm.htm', 'registrationmenu');
		$('#registrationmenu').stop(true,true).slideUp(200, "easeOutExpo");
	});
	*/
	
	$(document).on("click", "#passwordCancelButton", function(event){ 
		event.stopPropagation();
		loadRegistrationXMLDoc('passwordForm.htm', 'forgotpasswordmenu');
		$('#forgotpasswordmenu').stop(true,true).slideUp(200, "easeOutExpo");
	});
	
	$(document).on("click", "#passwordFinishButton", function(event){ 
		event.stopPropagation();
		loadRegistrationXMLDoc('passwordForm.htm', 'forgotpasswordmenu');
		$('#forgotpasswordmenu').stop(true,true).slideUp(200, "easeOutExpo");
	});
	
	/* hide overlay elements if a click is done outside of their range */
	
	$(document).mouseup(function (e){
	    var container = $("#loginmenu");
	    if (container.has(e.target).length === 0)
	    {
	        container.hide();
	    }
	});

	$(document).mouseup(function (e){
	    var container = $("#registrationmenu");
	    if (container.has(e.target).length === 0)
	    {
	        container.hide();
	    }
	});
	
	$(document).mouseup(function (e){
	    var container = $("#forgotpasswordmenu");
	    if (container.has(e.target).length === 0)
	    {
	        container.hide();
	    }
	});
	
// 	$("#menuCourtTypeSelect").buttonset();
});
</script>


<div id="header">
    <div id="headerContent">
        <div id="headerLogo">
            <a href="addReservation.htm"><img src='${contextPath}/resources/css/images/tckLogoScaled.png' /></a>
        </div>
        
        <!-- authentication -->
        <div id="headerLogin">
            <!-- login -->
            <authz:authorize ifNotGranted="ROLE_CUSTOMER">
                <div id="loginbutton" class="button" style="width: 100px; margin: 4px auto; margin-bottom: 0;">Login</div>
                <div id="loginmenu" style="display:none;">
                    <form method="POST" action="j_acegi_security_check" name="login">
        				<table align="center">
        					<tr height="50px">
        						<td colspan=2>
                                    <h2>Login</h2>
        						</td>
        					</tr>
        					<tr>
        						<td>
        							<spring:message code="field.loginUsername" />
        						</td>
        						<td>
        							<input type="text" name="j_username" size="10" style="width:120px;" tabindex="1">
        						</td>
        					</tr>
                            <tr>
                                <td>
                                    <spring:message code="field.loginPassword" />
                                </td>
                                <td>
                                    <input type="password" name="j_password" size="10" style="width:120px;" tabindex="2"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="smallFont"><a href="#" id="forgotPasswordMenuItem">Passwort vergessen?</a></td>
                            </tr>
                            <tr height="40px" valign="top">
        						<td colspan="2">
                                    <input type="submit" value="Login" tabindex="3" class="button" style="width: 100%;"/>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </authz:authorize>
            
            <!-- password forgotten -->
        	<div id="forgotpasswordmenu" style="display:none">
        		<jsp:include page="passwordForm.jsp" />
        	</div>
            
            <!-- logout -->
            <authz:authorize ifAnyGranted="ROLE_CUSTOMER">
                <form method="POST" action="logout.htm">                    
                    <div style="width: 120px; padding: 0; margin: 4px auto; margin-bottom: 0;">
                        <input type="submit" value="Abmelden" class="button" style="width: 100%; height: 100%;"/>
                        <br/>
                        <span class="smallFont"><authz:authentication operation="username" /></span>
                    </div>
                </form>
            </authz:authorize>  
            
            <!-- user registration -->
            <authz:authorize ifNotGranted="ROLE_CUSTOMER">
            	   <a href="#" id="registrationMenuItem" style="margin-left: 22px;" class="smallFont">Neuer Benutzer?</a> 
            		<div id="registrationmenu" style="display:none">
                        <jsp:include page="registrationForm.jsp" />
            		</div>
            	
            </authz:authorize>
        </div>
                
        <div id="headerText">
            <h1 style="display: inline;">TC Kalksburg CourtPicker</h1>
        </div>
    </div>
</div>

<div id="customerLinks">
    <authz:authorize ifAnyGranted="ROLE_CUSTOMER">
        <a href="customer.htm">
            <div class="buttonThinRound mediumFont" style="margin-top: 3px;">
                Kundenbereich <b>&gt;</b>
            </div>
        </a>
    </authz:authorize>
    <authz:authorize ifAnyGranted="ROLE_ADMIN">
        <a href="admin.htm">
            <div class="buttonThinRound mediumFont" style="margin-top: 3px;">
                Adminbereich <b>&gt;</b>
            </div>
        </a>
    </authz:authorize>
</div>

<div style="clear: both;"></div>

<!-- <div id="menuContent"> -->
<!--     <div id="menuCourtTypeSelect"> -->
<!--         <input type="radio" id="courtType1" name="courtType" checked="checked" /><label for="courtType1" style="margin-right: 5px;">Tennis Indoor</label> -->
<!--         <input type="radio" id="courtType2" name="courtType" /><label for="courtType2" style="margin-right: 5px;">Tennis Outdoor</label> -->
<!--         <input type="radio" id="courtType3" name="courtType" /><label for="courtType3" style="margin-right: 5px;">Fuﬂball</label> -->
<!--     </div> -->
<!-- </div> -->
