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
function loadXMLDoc(url,div)
{
	var xmlhttp;
	var data = "";
	
	if(url=="aboHours.htm")
	{
		var data ="saison="+$('#saison').val()+"&court="+$('#court').val();
		$("#time").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
	}
	if (window.XMLHttpRequest)
	{// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}
	else
	{// code for IE6, IE5
	  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
	   	{
			document.getElementById(div).innerHTML=xmlhttp.responseText;
			
	    }
	};
	xmlhttp.open("POST",url,true);
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-length", data.length);
	xmlhttp.setRequestHeader("Connection", "close");
	xmlhttp.send(data);
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
<h1>Abostunden-Reservierung</h1>
<authz:authorize ifNotGranted="ROLE_CUSTOMER">Sie müssen sich registrieren und einloggen, um Abostunden zu reservieren.
</authz:authorize>
<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
<c:if test="${(rd.settings.locked != '1') && (rd.settings.locked != '3')}">
<form:form method="POST" action="checkAboReservationAvailability.htm">

<table>
<tr>
	<td colspan=2>Bitte füllen Sie das folgende Formular aus, um ein Abo zu reservieren:
	</td>
</tr>
<tr>
	<td width=100>Platz
	</td>		
	<td>
		<select NAME="court" id="court" SIZE="1" >
			<c:forEach var="court" items="${rd.courts}">
				<option <c:if test="${court==rd.selectedCourt}">SELECTED</c:if>>
					<c:out value="${court}" />
				</option>
			</c:forEach>
		</select>
     </td>
</tr>
<tr>
    <td>Abo:
	</td>
	 <td>
		<select NAME="saison" id="saison" SIZE="1" onchange="javascript:loadXMLDoc('aboHours.htm','time')">
			<option selected>Bitte wählen Sie das gewünschte Abo</option>
			<c:forEach var="saison" items="${rd.saisons}">
		    	<option value="<c:out value="${saison.saisonName}" />">
  					<c:out value="${saison.saisonName}" /> (von <c:out value="${saison.saisonBegin}" /> bis <c:out value="${saison.saisonEnd}"/> für Stunden zwischen <c:out value="${saison.saisonTimeFrom}"/> und <c:out value="${saison.saisonTimeTo}"/>)		        
    			</option>    		
    		</c:forEach>
		</select>	
    </td>
</tr>
</table>
<div id="time">
</div>
<table>
<tr>		
	<td colspan=3>
		<input type="hidden" name="username" value="<authz:authentication operation="username" />" />				
		<authz:authorize ifAnyGranted="ROLE_CUSTOMER"><br><input type="submit" id="submitbutton" name="submitbutton" value="Verfügbarkeit überprüfen"/></authz:authorize>
	</td>
</tr>
</table>
</form:form>
</c:if>
</authz:authorize>
