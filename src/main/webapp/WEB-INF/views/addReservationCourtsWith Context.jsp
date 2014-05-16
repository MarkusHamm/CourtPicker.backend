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
$.fx.speeds._default = 100;
$(function() {

	
	$( "#dialog" ).dialog({
		autoOpen: false,
		show: "blind",
		modal: true,
		width: 400,
		buttons: {
			'Ok': function() { 
				loadXMLDoc("deleteReservationCourt.htm","dialog");
				$("#dialog").dialog("option", "buttons", {
					"Fenster schliessen": function() { 
						location.reload();
						$(this).dialog("close"); 
					}
				}); 
			}, 
			"Abbrechen": function() { 
				location.reload();
				$(this).dialog("close"); 
			} 
		}
	});
	
	$( "#reservationConfirmationDialog").dialog({
		autoOpen: false,
		show: "blind",
		modal: true,
		width: 400,
		buttons: {
			'Bestellung abschliessen': function() { 
				loadXMLDoc("reservationDone.htm","reservationConfirmationDialog");
				$("#reservationConfirmationDialog").dialog("option", "buttons", {
					  "Fenster schliessen": function() { 
						  location.reload();
						  $(this).dialog("close"); 
						  }
					});
				
			}, 
			"Abbrechen": function() { 
				location.reload();
				$(this).dialog("close"); 
			} 
		}
	});
	
	$('#submitbutton[name=submitbutton]').click(function(){
		$('#customerParameter').val($(this).val());
		var customer = $('#customerParameter').val();
		loadXMLDoc("confirmReservationCourts.htm", "reservationConfirmationDialog");
		$('#reservationConfirmationDialog').dialog('open');
		return false;
	});
	
	
	$('#opener[name=add]').click(function(){
		$('#deleteparameter').val($(this).val());
		$('#dialog').dialog('open');
		return false;
	});
});
</script>
<script type="text/javascript">
function loadXMLDoc(url, dialog)
{
	var xmlhttp;
	if(url=="confirmReservationCourts.htm"|| url=="reservationCourtsDone.htm")
	{
		var allTimes= new Array();
		var j = 0;
			for(var i=0; i < document.reservationform.reservationStartTime.length; i++)
			{
				if(document.reservationform.reservationStartTime[i].checked)
					{
						allTimes[j] =document.reservationform.reservationStartTime[i].value;
						j = j+1;
					}
			}
		if(url=="confirmReservationCourts.htm" && j==0)
		{
			document.getElementById(dialog).innerHTML="Sie haben keine Stunde zur Reservierung ausgewählt!";
			$("#reservationConfirmationDialog").dialog("option", "buttons", {
				  "Fenster schliessen": function() { 
					  $(this).dialog("close"); 
					  }
				});
			return true;
		}
		//Buttons wieder auf den Ausgangsstand zurücksetzen, damit nach einer Leerauswahl trotzdem wieder reserviert werden kann
		$("#reservationConfirmationDialog").dialog("option","buttons",{
			'Bestellung abschliessen': function() { 
				loadXMLDoc("reservationCourtsDone.htm","reservationConfirmationDialog");
				$("#reservationConfirmationDialog").dialog("option", "buttons", {
					  "Fenster schliessen": function() { 
						  location.reload();
						  $(this).dialog("close"); 
						  }
					});
				
			}, 
			"Abbrechen": function() { 
				location.reload();
				$(this).dialog("close"); 
			} 
	});
		var data ="reservationStartTimes="+allTimes+"&selectedCourt="+$('#selectedCourt').val()+"&startdate="+$('#startdate').val()+"&username="+$('#username').val();
	}
	if(url=="deleteReservationCourt.htm")
	{
		var data ="id="+$('#deleteparameter').val()+"&date="+$('#startdate').val();
	}
	if(url=="reservationCourtsDone.htm")
	{
		var data ="resName=";
		$('[id^="resName_"]').each(function(){
			if (!($(this).val())){
				data = data +"leer"+",";
			} else {
				data = data + $(this).val()+",";
			}
		});
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
<!--Reservation Selection-->	
<div>
<table width=100%>
	<tr>
		<td rowspan=4 valign=top><h1>Tagesübersicht für ${rd.startdate}</h1>
		</td>
		<td>
		</td>
		<td align=right>Legende:
		</td>
		<td class="notreserved-color" width = 150 height=20 align=center style="border-style:solid;border-width:1px;">frei
		</td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td class="reserved-color" width = 150 height=20 align=center style="border-style:solid;border-width:1px;">Reservierung</td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td class="abo-color" style="color:white;align:center";" width = 150 height=20 align=center style="border-style:solid;border-width:1px;">Aboreservierung
		</td>
	</tr>
</table>
<table>
	<form:form method="POST" name="reservationform">
		<tr>
		<td colspan=10>
			<authz:authorize ifAnyGranted="ROLE_CUSTOMER"><input type="submit" id="submitbutton" name="submitbutton" value="Ausgewählte Stunden reservieren"/></authz:authorize>
		</td>
		</tr>
		<tr>
			<td>
				<table>
					<tr><td><br></td></tr>
						<c:forEach items="${rd.toTimes}" var="toTimes">
							<tr><td height="30px" valign="middle">${toTimes.key}</td>
						</c:forEach>
				</table>
			</td>
			<c:set var="i" value="0" />
			<c:forEach items="${rd.reservationsOfCourt}" var="court">
				<td>
					<table>
						<tr>
							<td width="80"><c:out value="${court.key}" />
							</td>
						</tr>
						<c:forEach items="${court.value}" var="times">					
							<c:if test="${times.value == '3'}">
								<tr>
									<td class="reserved-color" height="30px"><authz:authorize ifAnyGranted="ROLE_CUSTOMER"><!--<input type="checkbox" name="reservationStartTime" value="${court.key}/${times.key}" />--><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><button name="add" id="opener" value="${court.key} ${times.key}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span></button><!--<input type="image" src="${contextPath}/resources/delete.png" id="opener" name="add" alt="Delete" value="${court.key} ${times.key}" height="12"/> --></c:if></authz:authorize>&nbsp;
									<!--
									<td class="reserved-color" height="30px"><authz:authorize ifAnyGranted="ROLE_CUSTOMER"><input type="checkbox" name="reservationStartTime" value="${court.key}/${times.key}" /><input type="image" src="${contextPath}/resources/delete.png" id="opener" name="add" alt="Delete" onClick="javascript: deleteReservation('${rd.startdate}', '${times.key}', '${court.key}');" value="${court.key} ${times.key} 1" height="12"/></authz:authorize>&nbsp;
									--></td>
								</tr>
							</c:if>
							<c:if test="${times.value == '2'}">
								<tr>
									<td class="abo-color" height="30px"><authz:authorize ifAnyGranted="ROLE_CUSTOMER"><!--<input type="checkbox" name="reservationStartTime" value="${court.key}/${times.key}" />--><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><button name="add" id="opener" value="${court.key} ${times.key}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span></button><!-- <input type="image" src="${contextPath}/resources/delete.png" id="opener" name="add" alt="Delete" value="${court.key} ${times.key}" height="12"/> --></c:if></authz:authorize>&nbsp;
									<!--<td class="abo-color" height="30px"><authz:authorize ifAnyGranted="ROLE_CUSTOMER"><input type="checkbox" name="reservationStartTime" value="${court.key}/${times.key}" /><input type="image" src="${contextPath}/resources/delete.png" id="opener" name="add" alt="Delete" onClick="javascript: deleteReservation('${rd.startdate}', '${times.key}', '${court.key}');" value="${court.key} ${times.key} 1" height="12"/></authz:authorize>&nbsp;
									--></td>
								</tr>
							</c:if>
							<c:if test="${times.value == '1'}">
								<tr>
									<td class="pre-reserved-color" height="30px">&nbsp;
									</td>
								</tr>
							</c:if>
							<c:if test="${times.value == '0'}">
								<tr>
									<td class="notreserved-color" height="30px"><authz:authorize ifAnyGranted="ROLE_CUSTOMER"><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><input type="checkbox" name="reservationStartTime" value="${court.key}/${times.key}" /></c:if></authz:authorize>&nbsp;
									</td>
								</tr>
							</c:if>
							<c:if test="${times.value == '4'}">
								<tr>
									<td class="abo-color" height="30px"><authz:authorize ifAnyGranted="ROLE_ADMIN"><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><button name="add" id="opener" value="${court.key} ${times.key}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span></button><!-- <input type="image" id="opener" src="${contextPath}/resources/delete.png" alt="Delete" name="add" value="${court.key} ${times.key}" height="12"/> --></c:if></authz:authorize>&nbsp;
									<!--<td class="abo-color" height="30px"><authz:authorize ifAnyGranted="ROLE_ADMIN"><input type="image" id="opener" src="${contextPath}/resources/delete.png" alt="Delete" name="add" onClick="javascript: deleteReservation('${rd.startdate}', '${times.key}', '${court.key}');" value="${court.key} ${times.key} 1" height="12"/></authz:authorize>&nbsp;
									--></td>
								</tr>
							</c:if>
							<c:if test="${times.value == '5'}">
								<tr>
									<td class="reserved-color" height="30px"><authz:authorize ifAnyGranted="ROLE_ADMIN"><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><button name="add" id="opener" value="${court.key} ${times.key}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span></button><!-- <input type="image" id="opener" name="add" src="${contextPath}/resources/delete.png" alt="Delete" value="${court.key} ${times.key}" height="12"/> --></c:if></authz:authorize>&nbsp;
									<!--<td class="reserved-color" height="30px"><authz:authorize ifAnyGranted="ROLE_ADMIN"><input type="image" id="opener" name="add" src="${contextPath}/resources/delete.png" alt="Delete" onClick="javascript: deleteReservation('${rd.startdate}', '${times.key}', '${court.key}');" value="${court.key} ${times.key} 1" height="12"/></authz:authorize>&nbsp;
									--></td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</td>
			</c:forEach>		
	</tr>
	<tr>
		<td colspan=3>
			<input type="hidden" name="username" value="<authz:authentication operation="username" />" /><!--
			<input type="hidden" name="selectedCourt" value="${rd.selectedCourt}" />
			--><input type="hidden" name="startdate" id="startdate" value="${rd.startdate}" />				
			<authz:authorize ifAnyGranted="ROLE_CUSTOMER"><input type="submit" id="submitbutton" name="submitbutton" value="Ausgewählte Stunden reservieren"/></authz:authorize>
		</td>
	</tr>
</form:form>
</table>
<input type="hidden" id="deleteparameter" />
<div id="reservationConfirmationDialog" title="Reservierungsdaten">
</div>
<div id="dialog" title="Reservierung Löschen?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Wollen Sie die ausgewählte Einzelstundenreservierung wirklich löschen?</p>
</div>
</div>