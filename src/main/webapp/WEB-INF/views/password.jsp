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
<script type="text/javascript">
$.fx.speeds._default = 100;
$(function() {
	
	$( "#dialog").dialog({
		autoOpen: false,
		show: "blind",
		modal: true,
		resizable: false,
		width: 400,
		buttons: {
			'OK': function() { 
				  $(this).dialog("close"); 
			}
		}
	});
	
	//Buttonevent für den Submitbutton
	$('#submitbutton').click(function(){
		var vorname = document.getElementById("vorname").value;
		var nachname = document.getElementById("nachname").value;
		var email = document.getElementById("email").value;
		if ((vorname.length) && (nachname.length) && (email.length)){
			loadXMLDoc("sendPassword.htm", "dialog");
			$('#dialog').dialog('open');
		} else {
			document.getElementById("dialog").innerHTML="<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span>Sie haben nicht alle Daten vollständig eingegeben. Bitte füllen Sie das Formular vollständig aus!<br></p></div></div";
			$('#dialog').dialog('open');
		}
		
		return false;
	});

});
</script>
<script type="text/javascript">
function loadXMLDoc(url, dialog)
{
	var xmlhttp;
	var data = "";
	if(url=="sendPassword.htm")
	{
		data ="vorname="+document.getElementById("vorname").value+"&nachname="+document.getElementById("nachname").value+"&email="+document.getElementById("email").value;
		
	}
	$( "#dialog").dialog({
		autoOpen: false,
		show: "blind",
		modal: true,
		resizable: false,
		width: 400,
		buttons: {
			'OK': function() { 
					window.location="addReservation.htm";
				  $(this).dialog("close"); 
			}
		}
	});
	
	
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
			document.getElementById(dialog).innerHTML=xmlhttp.responseText;
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
</head>
<body>
	<form:form method="POST">
		<table>
			<tr>
				<td>Lieber Kunde, Sie haben Ihr Passwort vergessen?<br>Bitte geben Sie Ihre E-Mail-Adresse ein!
				</td>
			</tr>
			<tr>
				<td>Vorname:
				</td>
				<td>
					<input type="text" id="vorname" name="vorname"/>
				</td>
			</tr>
			<tr>
				<td>Nachname
				</td>
				<td>
					<input type="text" id="nachname" name="nachname"/>
				</td>
			</tr>
			<tr>
				<td>E-Mail Adresse:
				</td>
				<td>
					<input type="text" id="email" name="email"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" id="submitbutton" value="Senden"/>
				</td>
			</tr>
		</table>
	</form:form>
	<div id="dialog" title="Hinweis"> 
	</div>
</body>
</html>