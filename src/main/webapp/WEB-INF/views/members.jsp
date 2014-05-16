<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
		<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.10.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.4.4.min_tab.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.10.custom.min.js"></script>
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.9.custom.css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.9.custom.min.js"></script>

<script type="text/javascript"><!--
$(function(){
	
	// Tabs
	$('#tabs').tabs();
	
	//hover states on the static widgets
	$('#dialog_link, ul#icons li').hover(
		function() { $(this).addClass('ui-state-hover'); }, 
		function() { $(this).removeClass('ui-state-hover'); }
	);
	
});

function updateCourt() {
	this.document.formCourts.action="courtUpdated.htm";
	this.document.formCourts.submit();
	return true;
}

function updateTime() {
		this.document.formTimes.action="timeUpdated.htm";
		this.document.formTimes.submit();
		return true;
}

function updateSaison() {
	this.document.formSaisons.action="saisonUpdated.htm";
	this.document.formSaisons.submit();
	return true;
}

function deleteTime() {
	   this.document.formTimes.action="timeDeleted.htm";
	   this.document.formTimes.submit();
	   return true;
}
</script>
<script type="text/javascript">
$(function(){
	// Datepicker
	$('#datepicker3').datepicker({
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
	$('#datepicker4').datepicker({
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
						<style type="text/css"><!--

			#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
			#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
			ul#icons {margin: 0; padding: 0;}
			ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
			ul#icons span.ui-icon {float: left; margin: 0 4px;}
		</style>
</head>
<body>
	<authz:authorize ifAnyGranted="ROLE_VORSTAND">

				
				Ein neues Mitglied anlegen:
				
				<table>
				  <form:form method="POST" action="memberCreated.htm">
					<tr>
						<td>Mitglieds-Nr.
						</td>
						<td>Titel
						</td>
						<td>Vorname
						</td>
						<td>Nachname
						</td>
						<td>Email
						</td>
						<td>Benutzername
						</td>
						<authz:authorize ifAnyGranted="ROLE_ADMIN">
							<td>Password
							</td>
						</authz:authorize>
						<td>Account
						</td>
						<td>Mitglied
						</td>
						<td>Mitgliedsart
						</td>
						<td>Strasse
						</td>
						<td>PLZ
						</td>
						<td>Land
						</td>
						<td>Geburtstag
						</td>
						<td>Handynummer
						</td>
						<td>Telefonnummer
						</td>
						<td>Telefonnummer 2
						</td>
						<td>Eintrittsjahr
						</td>
						<td>Mitgliedsjahre
						</td>
						<td>Admin
						</td>
						<td>Vorstand
						</td>
						<td>Kunde
						</td>
						
					</tr>
					<tr>
						<td>
							<input type="text" name="memberId" value="${customer.customerId}" size=10/>
						</td>
						<td>
							<input type="text" name="title" value="${customer.title}" size=10/>
						</td>
						<td>
							<input type="text" name="firstName" value="${customer.firstName}" size=10/>
						</td>
						<td>
							<input type="text" name="lastName" value="${customer.lastName}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<authz:authorize ifAnyGranted="ROLE_ADMIN">
							<td>
								<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
							</td>
						</authz:authorize>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>
							<input type="text" name="courtName" value="${court.courtNumber}" size=10/>
						</td>
						<td>	
							<input type="submit" value="Anlegen"/>
						</td>
					</tr>
					
				  </form:form>
				</table>

<br>
<br>
Folgende Mitglieder sind bereits angelegt:
<br>
<br>
				<table>
					<tr>
						<td>
						</td>
						<td>Nummer
						</td>
						<td>Name
						</td>
						<td>Indoor Court
						</td>
						<td>Reservierbar
						</td>
						<td>Löschen
						</td>
					</tr>
					<form:form method="POST" name="formMembers">
					<c:set var="j" value="0" />
						<c:forEach items="${rd.members}" var="member">
						<tr>
							<td>
								<c:out value="${member.customerId}" />
							</td>
							<td>
								<input type="text" name="firstName" value="${member.firstName}" size=3/>
							</td>
							<td>
								<input type="text" name="lastName" value="${member.lastName}" size=10/>
							</td>
						</tr>
							<c:set var="j" value="${j+1}" />
						</c:forEach>
						<tr>
							<td colspan=4>
								<input type="hidden" name="count" value="${j}" />
								<input type="submit" value="Ändern" onClick="javascript: updateCourt();"/>
							</td>
						</tr>
					</form:form>				
				</table>
				
	</authz:authorize>

</body>
</html>