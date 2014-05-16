<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>

<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

		
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
<form method="POST" name="reservationEdit">
	<div id="ReservationDetail">
		<authz:authorize ifAnyGranted="ROLE_ADMIN">
			<input type="hidden" name="adminReservationId" id="adminReservationId" value="${rd.reservation.reservationId}">
			<table>
				<tr>
					<td>&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						ID
					</td>
					<td>
						${rd.reservation.reservationId}
					</td>
				</tr>
				<tr>
					<td>
						Benutzername
					</td>
					<td>
						<select NAME="username" id="reservationDetailUserId" SIZE="1">
							<c:forEach var="reservationDetailUserId" items="${rd.customerList}">
						    	<option value="${reservationDetailUserId.customerId}" <c:if test="${rd.reservation.customerId == reservationDetailUserId.customerId}">SELECTED</c:if>>
				  					<c:out value="${reservationDetailUserId.username}"/>		        
				    			</option>    		
				    		</c:forEach>
						</select>
					<!--<input type="text" name="adminReservationUsername" id="adminReservationUsername" value="${rd.reservation.username}">
					--></td>
				</tr>
				<tr>
					<td>
						Preis
					</td>
					<td><input type="text" name="adminReservationPrice" id="adminReservationPrice" value="${rd.reservation.price}" size="3" maxlength="5" >
					</td>
				</tr>
				<tr>
					<td>
						AnzeigeName
					</td>
					<td><input type="text" name="adminReservationName" id="adminReservationName" value="${rd.reservation.reservationName}" size="8" maxlength="10" >
					</td>
				</tr>
				<tr>
					<td>
						Kommentar
					</td>
					<td>
						<textarea name="adminReservationComment" id = "adminReservationComment" cols="60" rows="2">${rd.reservation.comment}</textarea>
					</td>
				</tr>
				<tr>
					<td>
						Bezahlt
					</td>
					<td>
						<input type="checkbox" name="adminPaymentDone" id = "adminPaymentDone" <c:if test="${rd.reservation.paymentDone == 'true'}">CHECKED</c:if>>
					</td>
				</tr>
				<tr>
					<td>
						Datum
					</td>
					<td>${rd.reservation.reservationStartDate}
					</td>
				</tr>
				<tr>
					<td>
						Uhrzeit
					</td>
					<td>${rd.reservation.reservationStartTime}
					</td>
				</tr>
				<tr>
					<td>
						Platz
					</td>
					<td>${rd.reservation.courtName}
					</td>
				</tr>
				<tr>
					<td>
						Buchungszeitpunkt
					</td>
					<td>${rd.reservation.timeOfReservation}
					</td>
				</tr>
				<tr>
					<td>
						Rechnungsnummer
					</td>
					<td>${rd.reservation.invoiceNumber}
					</td>
				</tr>
				<tr>
					<td>
						Reservierungstyp
					</td>
					<td>
						<c:if test="${rd.reservation.abo == 'true'}">Abo
						</c:if>
						<c:if test="${rd.reservation.abo == 'false'}">Einzelstunde
						</c:if>
					</td>
				</tr>
				<c:if test="${rd.reservation.abo == 'true'}">
					<tr>
					<td>
						Abo-Name
					</td>
					<td>${rd.reservation.aboName}
					</td>
					<tr>
					<td>
						Gültig:
					</td>
					<td>jeden ${rd.reservation.aboWeekDay} von ${rd.reservation.aboFromDate} bis ${rd.reservation.aboToDate}
					</td>
				</tr>		
				</c:if>
			</table>
		</authz:authorize>
	</div>
</form>
