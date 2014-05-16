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
		var password = document.getElementById("passwordToSet").value;
		var passwordrepeat = document.getElementById("passwordrepeatToSet").value;
		if (password==passwordrepeat && (password.length)){
			loadXMLDoc("storePassword.htm", "dialog");
			$('#dialog').dialog('open');
		} else {
			document.getElementById("dialog").innerHTML="<div class='ui-widget'><div class='ui-state-error ui-corner-all' style='padding: 0 .7em;'><p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'></span>Die von Ihnen eingegebenen Passwörter sind nicht gleich oder leer. Bitte geben Sie ein neues Passwort ein!<br></p></div></div";
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
	if(url=="storePassword.htm")
	{
		data ="username="+document.getElementById("usernameToSet").value+"&password="+document.getElementById("passwordToSet").value+"&passwordrepeat="+document.getElementById("passwordrepeatToSet").value;
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
	<form:form name="pwdForm" method="POST">
		<table>
			<tr>
				<td>Bitte geben Sie Ihr neues Password ein!
				</td>
			</tr>
			<tr>
				<td>
				</td>
				<td>
					<input type="hidden" id="usernameToSet" name="username" value="${rd.username}"/>
				</td>
			</tr>
			<tr>
				<td>Password:
				</td>
				<td>
					<input type="password" id="passwordToSet" name="password"/>
				</td>
			</tr>
			<tr>
				<td>Password (Wiederholung):
				</td>
				<td>
					<input type="password" id="passwordrepeatToSet" name="passwordrepeat"/>
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