<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.11.custom.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">
function finishReservation() {
		this.document.form.action="aboReservationDone.htm";
		this.document.form.submit();
		return true;
}
function cancelBooking() {
	   this.document.form.action="cancelBooking.htm";
	   this.document.form.submit();
	   return true;
}
function back() {
	   this.document.form.action="aboReservation.htm";
	   this.document.form.submit();
	   return true;
}
   
</script>
		<style type="text/css">
			.ui-dialog {
				font-size: 12.0px;
			}
			.ui-datepicker {
				font-size: 11.4px;
			}
		</style>
</head>
<body>
<h2>Abostunden-Reservierung</h2>
<c:if test="${rd.Availability == '1'}">
	<div class="ui-state-success ui-corner-all" style="padding: 0 .7em;"> 
		<table>
			<tr>
				<td valign=top>
					<p><span class="ui-icon ui-icon-circle-check" style="float: left; margin-right: .3em; background-image: url(${contextPath}/resources/css/images/ui-icons_469bdd_256x240_green.png");"></span>
					</p>
				</td>
				<td>
					Die von Ihnen gewünschte Abostunden-Reservierung ist möglich!
				</td>
			</tr>
		</table>
</div>
</c:if>
<c:if test="${rd.Availability == '0'}">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;"> 
		<table>
			<tr>
				<td valign=top>
					<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
					</p>
				</td>
				<td>
					Die von Ihnen gewünschte Abo-Reservierung ist leider nicht möglich. Eine oder mehrere Stunden sind bereits reserviert. 
				</td>
			</tr>
		</table>
	</div>
</c:if>
<br>
Die Bestelldaten:
<form:form method="POST" name="form" >
<table>
	<tr>
		<td>Anzeigename:
		</td>
		<td>
			<input type=text name="displayName" value="leer" />
		</td>
	</tr>
	<tr>
		<td>Platz:
		</td>
		<td>
			<input type=hidden name="court" value="${rd.court}" />
			<c:out value="${rd.court}" />
		</td>
	</tr>
	<tr>
		<td>Abo:
		</td>
		<td>
			<input type=hidden name="saison" value="${rd.saison}" />
			<c:out value="${rd.saison}" />
		</td>
	</tr>
	<tr>
		<td>Wochentag:
		</td>
		<td>
			<input type=hidden name="day" value="${rd.weekday}" />
			jeden <c:out value="${rd.weekday}" /> von <c:out value="${rd.fromDate}" /> bis <c:out value="${rd.toDate}" />
		</td>
	</tr>
	<tr>
		<td>Uhrzeit:
		</td>
		<td>
			<input type=hidden name="from" value="${rd.from}" />
			<c:out value="${rd.from}" />
		</td>
	</tr><!--
	<tr>
		<td>Dauer:
		</td>
		<td>
			<input type=hidden name="duration" value="${rd.duration}" />
			<c:out value="${rd.duration}" />
		</td>
	</tr>
	<c:forEach items="${rd.price}" var="price">
	<tr>
		<td>Preis für Stunde <c:out value="${price.key+1}" />:
		</td>
		<td>
			<input type=hidden name="price" value="${price.value}" />
			<c:out value="${price.value}" /> Euro
		</td>
	</tr>
	</c:forEach>
	<tr>
	</tr>
	--><tr>
		<td>PREIS:
		</td>
		<td>
			<input type=hidden name="totalPrice" value="${rd.totalPrice}" />
			<c:out value="${rd.totalPrice}" /> Euro
		</td>
	</tr>
		<authz:authorize ifAnyGranted="ROLE_ADMIN">	
			<tr>
				<td colspan=2><br>Sie können die Reservierungen auf einen anderen Kunden umbuchen:
				</td>
			</tr>
			<tr>
				
				<td colspan=2>
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
			</authz:authorize>
</table>
<c:if test="${rd.Availability == '1'}">
	<br>
	<input type="submit" value="Bestellung abschliessen" onClick="javascript: finishReservation();"/><input type="reset" value="Abbrechen" onClick="javascript: back();"/><!--<input type="reset" value="Reservierung abbrechen" onClick="javascript: cancelBooking();"/>-->
</c:if>
<c:if test="${rd.Availability == '0'}">
	<br>
	<input type="reset" value="Zurück" onClick="javascript: back();"/>
</c:if>
</form:form>
</body>
</html>