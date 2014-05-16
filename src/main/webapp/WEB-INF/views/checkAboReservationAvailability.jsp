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
   
</script>
		<style type="text/css">
			.ui-dialog {
				font-size: 12.0px;
			}
			.ui-datepicker {
				font-size: 11.4px;
			}
		</style>
Sie wollen folgendes Abo reservieren:

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
		<td>Saison:
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
			<c:out value="${rd.weekday}" /> 
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
	--><!--<c:forEach items="${rd.price}" var="price">
	<tr>
		<td>Preis für Stunde <c:out value="${price.key+1}" />:
		</td>
		<td>
			<input type=hidden name="price" value="${price.value}" />
			<c:out value="${price.value}" /> Euro
		</td>
	</tr>
	</c:forEach>
	--><tr>
	</tr>
	<tr>
		<td>PREIS:
		</td>
		<td>
			<input type=hidden name="totalPrice" value="${rd.totalPrice}" />
			<c:out value="${rd.totalPrice}" /> Euro
		</td>
	</tr>
</table>
	<input type="submit" value="Bestellung abschliessen" onClick="javascript: finishReservation();"/><input type="reset" value="Reservierung abbrechen" onClick="javascript: cancelBooking();"/>
</form:form>