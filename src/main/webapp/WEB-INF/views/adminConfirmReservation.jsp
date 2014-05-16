<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>



<script type="text/javascript">
function finishReservation() {
		this.document.form.action="reservationDone.htm";
		this.document.form.submit();
		return true;
}

function continueBooking() {
	   this.document.form.action="addReservation.htm";
	   this.document.form.submit();
	   return true;
}

function cancelBooking() {
	   this.document.form.action="cancelBooking.htm";
	   this.document.form.submit();
	   return true;
}
   
$(function() {
    $( "#radio" ).buttonset();
});
</script>
<input type="hidden" id="limitError" value="${rd.error}" />
<c:if test="${rd.error == '1'}">		
	<br>	
	<div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'>
		<table>
			<tr>
				<td valign="top">
					<span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span>
				</td>	
				<td>Die Reservierung konnte nicht durchgeführt werden, weil die gewählte Stunde (eine der gewählten Stunden) außerhalb des erlaubten Reservierungsbereiches liegt (${rd.limitDate})<br>
				</td>
			</tr>
		</table>
	</div>
</c:if>
<c:if test="${rd.error == '0'}">
<br>Sie machen folgende Reservierung(en):
<br>
<br>
<form:form method="POST" name="form" >
<input type="hidden" name="startdate" value="${rd.startdate}" />
<table>
<tr align=left><th>Datum</th><th>Uhrzeit</th><th>Platz</th><th>Anzeigename<span title="In das Feld Anzeigename können Sie eine Bezeichnung eintragen, die dann in der Reservierungsübersicht auf der von Ihnen reservierten Stunde aufscheint"; class="ui-icon ui-icon-info" style="float:right;"></span></th><th>Preis</th></tr>
	<c:set var="sum" value="0" />
	<c:set var="counter" value="0" />
	<c:forEach items="${rd.reservations}" var="reservation">
		<tr>
			<td>
				<input type="hidden" name="date" value="${reservation.value.reservationStartDate}" />
				<c:out value="${reservation.value.reservationStartDate}" />
			</td>
			<td align=center>
				<input type="hidden" name="time" value="${reservation.value.reservationStartTime}" />
				<c:out value="${reservation.value.reservationStartTime}" />
			</td>												
			<td align=center>
				<input type="hidden" name="court" value="${reservation.value.courtName}" />
				<c:out value="${reservation.value.courtName}" />
			</td>
			<td>
				<input type="text" name="resName_<c:out value="${counter}" />" id="resName_<c:out value="${counter}" />" size="8" maxlength="10" />
			</td>
			<td>
				<input type="hidden" name="price" value="${reservation.value.price}" />
				<c:out value="${reservation.value.price}" />
				<c:set var="sum" value="${sum+reservation.value.price}" />
			</td>
			<td>
			</td>
		</tr>
		<c:set var="counter" value="${counter+1}" />
	</c:forEach>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td></td><td></td><td></td><td align=right>Gesamtpreis:</td>
			<td>
				<b><c:out value="${sum}" /> Euro</b>
			</td>
		</tr>
		<tr>
			<td>
				<c:set var="preliminaryReservations" value="${rd.reservations}" />
			</td>
		</tr>
	</table>
	<authz:authorize ifAnyGranted="ROLE_ADMIN">	
		<table>
			<tr>
				<td><br>Sie können die Reservierungen auf einen anderen Kunden umbuchen:
				</td>
			</tr>
			<tr>
				
				<td >
					<select name ="changedCustomer" id="changedCustomer" Size="1">
						<option value="0" SELECTED>
							Wählen Sie hier den Kunden aus...
						</option>
						<c:forEach var="customer" items="${rd.customers}">	
        					<option value="${customer.customerId}">
           						<c:out value="${customer.firstName} ${customer.lastName} (${customer.username})" />
           					</option>
       				</c:forEach>
    				</select>
				</td>
			</tr>
			<tr>
				<td><br>Sie können hier die Art der Reservierung angeben:
				</td>
			</tr>
			<tr>
				<td>
					
					<div id="reservationTypeSection">
				        <input type="radio" id="radio1" name="reservationType" value="normal" checked="checked"/><label for="radio1">Normal</label>
				        <input type="radio" id="radio2" name="reservationType" value="preparation" /><label for="radio2">Instandsetzung</label>
				    </div>		
				</td>
			</tr>
			<tr>
				<td><br>Sie können einen Kommentar zu dieser Reservierung eingeben:
				</td>
			</tr>
			<tr>
				<td>
					<textarea name="comment" id = "comment" cols="60" rows="2"></textarea>
				</td>
			</tr>
		</table>
	</authz:authorize>
	
<!--	<input type="submit" value="Bestellung abschliessen" onClick="javascript: finishReservation();"/><input type="submit" value="weitere Reservierungen vornehmen" onClick="javascript: continueBooking();"/><input type="reset" value="Reservierung abbrechen" onClick="javascript: cancelBooking();"/>-->
</form:form>
</c:if>