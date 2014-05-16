<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.9.1.custom.css" rel="stylesheet" />
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.9.1.custom.min.css" rel="stylesheet" />
<link type="text/javascript" href="${contextPath}/resources/js/jquery-1.8.2.js" />
<link type="text/javascript" href="${contextPath}/resources/js/jquery-ui-1.9.1.custom.js" />
<link type="text/javascript" href="${contextPath}/resources/js/jquery-ui-1.9.1.custom.min.js" />
<c:if test="${rd.loginError == '0'}">
<div class="menu" id="menu">
	<div id="dateselector">
	</div>
	<div id="legend">
		<table>
			<tr>
				<td align="left">Legende:
				</td>
			</tr>
			<tr>
				<td class="notreserved-color" height="10" align="center" style="border-style:solid;border-width:1px;border-color:white;font-size:10px;">frei
				</td>
			</tr>
			<tr>
				<td class="reserved-color" height=10 align=center style="border-style:solid;border-width:1px;font-size:10px">Reservierung
				</td>
			</tr>
			<tr>
				<td class="abo-color" height=10 align=center style="border-style:solid;border-width:1px;font-size:10px">Abo
				</td>
			</tr>
			<tr>
				<td class="reserved-by-me-color" height=10 align=center style="border-style:solid;border-width:1px;font-size:10px">meine Reservierung
				</td>
			</tr>
			<tr>
				<td colspan='2' class="my-abo-color" height=10 align=center style="border-style:solid;border-width:1px;font-size:10px">mein Abo
				</td>
			</tr>
		</table>
	</div>		
</div>
<div id="base">
</div>
	<div id="reservationConfirmationDialog" title="Reservierungsdaten">
	</div>
	<div id="dialog" title="Reservierung Löschen?">
		<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Wollen Sie die ausgewählte Einzelstundenreservierung wirklich löschen?</p>
	</div>
</c:if>
<c:if test="${rd.loginError == '1'}">
	<div id="base">
		<div class="ui-widget" style = "height:400px;">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;height:400px;valign:center;"> 
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
				<strong>ACHTUNG: Ihr Login ist fehlgeschlagen!</strong><br>Sie haben entweder einen falschen Benutzernamen oder ein falsches Passwort eingegeben. Bitte wiederholen Sie das Login!<br>
				</p>
			</div>
		</div>
	</div>	
</c:if>