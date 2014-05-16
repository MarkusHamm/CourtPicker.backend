<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.11.custom.min.js"></script>
<table class="ui-state-success ui-corner-all" style="padding: 0 .7em;">
<tr>
	<td valign=top>
		<span class="ui-icon ui-icon-circle-check" style="float: left; margin-right: .3em;background-image: url(${contextPath}/resources/css/images/ui-icons_469bdd_256x240_green.png");"></span>
			</td>
			<td>
Sie haben die Registrierung erfolgreich abgeschlossen! <br><br>
Sie erhalten in Kürze ein e-mail mit einem Link, den Sie öffnen müssen, um die Registrierung zu bestätigen und Ihren Account tatsächlich aktiv zu schalten.<br>
Sobald Sie das erledigt haben, können Sie sich einloggen und Reservierungen vornehmen.
			</td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input type="reset" value="Schliessen" class="button" onClick="javascript: event.stopPropagation();loadRegistrationXMLDoc('registrationForm.htm', 'registrationmenu');$('#registrationmenu').stop(true,true).slideUp(200,'easeOutExpo');"/>
			</td>
		</tr>
	</table>