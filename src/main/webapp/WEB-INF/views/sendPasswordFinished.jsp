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

<c:if test="${rd.success == '1'}">
	<div class="ui-state-success ui-corner-all smallFont" style="padding: 5px; margin-bottom: 0;"> 
		<table>
			<tr>
				<td valign=top>
					<span class="ui-icon ui-icon-circle-check" style="float: left; margin-right: .3em;background-image: url(${contextPath}/resources/css/images/ui-icons_469bdd_256x240_green.png");"></span>
				</td>
				<td>
					Ein Email mit weiteren Instruktionen wurde an Sie verschickt!
				</td>
			</tr>
			<tr>
				<td></td>
			<td>
				<input type="reset" value="Schliessen" onClick="javascript: event.stopPropagation();loadRegistrationXMLDoc('passwordForm.htm', 'forgotpasswordmenu');$('#forgotpasswordmenu').stop(true,true).slideUp(600,'easeOutExpo');"/>
			</td>
		</tr>
		</table>
	</div>
</c:if>

<c:if test="${rd.success == '0'}">			
	<div class='ui-state-error ui-corner-all smallFont' style='padding: 5px; margin-bottom: 10px;'>
		<span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;rowspan:3;'></span>
		Es konnte kein Benutzer mit den von Ihnen angegebenen Daten gefunden werden. Bitte geben Sie Ihre Daten korrekt ein!
	</div>

    <jsp:include page="passwordForm.jsp" />
</c:if>

<!--                 <div class="ui-state-error ui-corner-all smallFont" style="padding: 5px; margin-bottom: 10px;">  -->
<!--                     <span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>  -->
