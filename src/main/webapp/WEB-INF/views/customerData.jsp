<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>

<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />


<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.11.custom.min.js"></script>
		
<script type="text/javascript">

$(function(){
	
	$('#customerTabs').tabs();
	
	// Datepicker
	$('#birthday').datepicker({
		dateFormat: 'yy-mm-dd',
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		yearRange: '1910:2020',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember']				
	});	
});
</script>
<style type="text/css">
	.ui-tab {	
		font-size: 12px;
	}
	.ui-dialog {	
		font-size: 12.0px;
	}
	.ui-datepicker {
		font-size: 11.4px;
	}
</style>
<form method="POST" name="customerEdit">
<div class="demo">
<div id="customerTabs">
	<ul>
		<li><a href="#customerTabs-1">Kundendaten</a></li>
		<li><a href="#customerTabs-2">Aktivierung und Berechtigungen</a></li>
	</ul>
	<div id="customerTabs-1">
		<authz:authorize ifAnyGranted="ROLE_ADMIN">
			<input type="hidden" name="adminCustomerId" id="adminCustomerId" value="${rd.customer.customerId}">
			<table>
				<tr>
					<td>&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						<spring:message code="field.loginUsername" />
					</td>
					<td><input type="text" name="adminUsername" id="adminUsername" value="${rd.customer.username}" DISABLED><br>
					<!-- <input type="hidden" name="username" id="username" value="${rd.customer.username}" /> -->
					<input type="hidden" name="code" id="code" value="${rd.customer.code}" />
					</td>
				</tr>
				<tr>
					<td>
						<spring:message code="field.firstName" />
					</td>
					<td>
						<input type="text" name="firstname" id="adminFirstName" value="${rd.customer.firstName}"><br>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td>
						<spring:message code="field.lastName" />
					</td>
					<td>
						<input type="text" name="lastname" id="adminLastName" value="${rd.customer.lastName}"><br>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td>
						<spring:message code="field.email" />
					</td>
					<td>
						<input type="text" name="email" id="adminEmail" value="${rd.customer.email}"><br>
					</td>
				</tr>
				<tr>
					<td>
						<spring:message code="field.loginPassword" />
					</td>
					<td>
						<input type="password" name="password" id="adminPassword" value="${rd.customer.password}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						<spring:message code="field.loginPasswordRepeat" />
					</td>
					<td>
						<input type="password" name="passwordrepeat" id="adminPasswordrepeat" value="${rd.customer.password}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						TCK Mitglied
					</td>
					<td>			
						<input type="checkbox" name="isMember" id="adminIsMember" value="1" <c:if test="${rd.customer.isMember==true}">checked</c:if> /><br>
					</td>
				</tr>
				<tr>
					<td>
						Strasse und Hausnummer
					</td>
					<td>
						<input type="text" name="street" id="adminStreet" value="${rd.customer.street}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						PLZ und Ort
					</td>
					<td>
						<input type="text" name="plz" id="adminPlz" value="${rd.customer.plz}"/><br>
					</td>
					<td>
						<input type="text" name="city" id="adminCity" value="${rd.customer.city}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						Geburtsdatum
					</td>
					<td>
						<div><input type="text" name="birthday" id="adminBirthday" value="${rd.customer.birthday}"></div><br>
					</td>
				</tr>
				<tr>
					<td>
						Land
					</td>
					<td>
						<input type="text" name="country" id="adminCountry" value="${rd.customer.country}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						Telefonnummer
					</td>
					<td>
						<input type="text" name="telefon" id="adminTelefon" value="${rd.customer.telefon}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						Handy
					</td>
					<td>
						<input type="text" name="handy" id="adminHandy" value="${rd.customer.handy}"/><br>
					</td>
				</tr>
				<tr>
					<td>&nbsp;
					</td>
				</tr>
			</table>
		</authz:authorize>
	</div>
	<div id="customerTabs-2">
	<table>	
		<tr>
			<td>
				Account aktiviert?
			</td>
			<td>
				<input type="checkbox" name="Enabled" id="Enabled" value="1" <c:if test="${rd.customer.enabled==true}">checked</c:if> />
			</td>
		</tr>
		<tr>
			<td>Administrator
			</td>
			<td>
				<input type="checkbox" name="roleAdmin" id="roleAdmin" value="1" <c:if test="${rd.roleAdmin==true}">checked</c:if> />
			</td>
		</tr>
		<tr>
			<td>Kunde
			</td>
			<td>			
				<input type="checkbox" name="roleCustomer" id="roleCustomer" value="1" <c:if test="${rd.roleCustomer==true}">checked</c:if> disabled />
			</td>
		</tr>
	</table>
	</div>

</div>

</div>
</form>
