<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.11.custom.min.js"></script>

		<style type="text/css">
			.ui-dialog {
				font-size: 12.0px;
			}
			.ui-datepicker {
				font-size: 11.4px;
			}
		</style>
</head>
<script type="text/javascript">

function gotoAddReservation(){
	location.href = "addReservation.htm";	
}

$(function() {
	$( "#datepicker1" ).datepicker({ 
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
<authz:authorize ifNotGranted="ROLE_CUSTOMER">
<form method="POST" action="confirmRegistration.htm">
<h1><spring:message code="registrationTitle" /></h1>
<spring:message code="registrationText" />
<table>
<tr><td>&nbsp;</td>
</tr>
<tr>
	<td>
		<spring:message code="field.firstName" />*</td><td><input type="text" name="firstname"><br>
	</td>
	<td></td>
</tr>
<tr>
	<td>
		<spring:message code="field.lastName" />*</td><td><input type="text" name="lastname"><br>
	</td>
	<td></td>
</tr>
<tr>
	<td>
		<spring:message code="field.email" />*</td><td><input type="text" name="email"><br>
	</td>
	<td>Die e-mail muss angegeben werden, weil z.B. Reservierungsbestätigungen per email verschickt werden.</td>
</tr>
<tr>
	<td>
		<spring:message code="field.loginUsername" />*</td><td><input type="text" name="username"><br>
	</td>
	<td>Mit diesem Benutzernamen (und dem Passwort) können Sie sich nach der Registrierung anmelden.</td>
</tr>
<tr>
	<td><spring:message code="field.loginPassword" />*</td><td><input type="password" name="password" /><br>
		
	</td>
</tr>
<tr>
	<td><spring:message code="field.loginPasswordRepeat" />*</td><td><input type="password" name="passwordrepeat" /><br>
		
	</td>
</tr>
<tr><td>&nbsp;</td>
</tr>
<tr>
	<td>
		TCK Mitglied
	</td>
	<td>
		<input type="checkbox" name="isMember" value="0"/><br>
	</td>
</tr>
<tr>
					<td>
						Strasse und Hausnummer
					</td>
					<td>
						<input type="text" name="street" value="${rd.customer.street}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						PLZ und Ort
					</td>
					<td>
						<input type="text" name="plz" value="${rd.customer.plz}"/><br>
					</td>
					<td>
						<input type="text" name="city" value="${rd.customer.city}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						Geburtsdatum
					</td>
					<td>
						<div><input type="text" name="birthday" id="datepicker1" value="${rd.customer.birthday}"></div><br>
					</td>
				</tr>
				<tr>
					<td>
						Land
					</td>
					<td>
						<input type="text" name="country" value="${rd.customer.country}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						Telefonnummer
					</td>
					<td>
						<input type="text" name="telefon" value="${rd.customer.telefon}"/><br>
					</td>
				</tr>
				<tr>
					<td>
						Handy
					</td>
					<td>
						<input type="text" name="handy" value="${rd.customer.handy}"/><br>
					</td>
				</tr>
<tr>
	<td colspan="3"><input type="submit" value="Registrieren"/><input type="reset" value="Abbrechen" onClick="javascript: gotoAddReservation()"/></form>
	</td>
</tr>
</table>
</authz:authorize>