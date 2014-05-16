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
window.onload = document.forms["login"].elements["j_username"].focus();
var value = "";
function object(){
	this.name = "";
	this.value = "";
}
//ContextMenu
function findPosX(obj) {
   var curleft = 0;
   if(obj.offsetParent) {
      while(obj.offsetParent) {
         curleft += obj.offsetLeft;
         obj = obj.offsetParent;
      }
   }
   else if(obj.x) 
     curleft = obj.x;
   return curleft;
}
 
function findPosY(obj) {
   var curtop = 0;
   if(obj.offsetParent) {
      while(obj.offsetParent) {
         curtop += obj.offsetTop;
         obj = obj.offsetParent;
      }
   }
   else if(obj.y)
      curtop = obj.y;
   return curtop;
}

function hideShow(x, y, context){
	//alert("TEST: "+x+"Y: "+y);
	x = x+23;
	y = y-10;
	document.getElementById(context).style.left=x+"px";
	document.getElementById(context).style.top=y+"px";
	document.getElementById(context).style.width= "150px";
	document.getElementById(context).style.height= "200px";
	if (document.getElementById(context).style.display=="block"){
		document.getElementById(context).style.display="none";
	} else {
		document.getElementById(context).style.display="block";
	}
}

function hide(context){
	document.getElementById(context).style.display = "none";
	//if (context == "divReserveContext"){
		//markAsSelected(value);
	//}
}

function selectDeselectCell(ButtonObject){
	var button = document.getElementById(ButtonObject);
	alert(button.value);
	
	for(var i=0; i < document.reservationform.reservationStartTime.length; i++)
	{
		
		if(document.reservationform.reservationStartTime[i].value == value){
				alert(document.reservationform.reservationStartTime[i].value);
				markedElement = document.reservationform.reservationStartTime[i];
				
				if(markedElement.checked){
					alert("hier bin ich nicht");
					markedElement.checked = false;
					var color = $(this).parent().class.attr("background-color");
					markedElement.parent().css('background-color', color);
				} else {
					alert("hier bin ich");
					markedElement.checked = true;
					markedElement.parent().css('background-color', 'orange');
				}	
		}
		
	}
}

function openAboDialog(){
	
	$('#aboReservationDialog').dialog('open');
	loadXMLDoc("aboReservation.htm","aboReservationDialog");
	
}


</script>
<script type="text/javascript">
$.fx.speeds._default = 100;
$(function() {

	//der Lösch-Dialog
	$( "#dialog" ).dialog({
		autoOpen: false,
		show: "blind",
		modal: true,
		width: 400,
		buttons: {
			'Ok': function() { 
				loadXMLDoc("deleteReservation.htm","dialog"); 
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
	//Der Reservierungsdialog
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
	
	$( "#aboReservationDialog").dialog({
		autoOpen: false,
		show: "blind",
		modal: true,
		width: 400,
		buttons: {
			'Bestellung abschliessen': function() { 
				loadXMLDoc("aboReservation.htm","aboReservationDialog");
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
	
	//Buttonevent für den Submitbutton
	$('#submitbutton[name=submitbutton]').click(function(){
		$('#customerParameter').val($(this).val());
		var customer = $('#customerParameter').val();
		loadXMLDoc("confirmReservation.htm", "reservationConfirmationDialog");
		$('#reservationConfirmationDialog').dialog('open');
		return false;
	});
	//Buttonevent für den Löschbutton
	$('#opener[name=add]').click(function(){
		var x = findPosX(this);
		var y = findPosY(this);
		var value = "";
		hideShow(x,y, "divContext");
		$('#deleteparameter').val($(this).val());
		//$('#dialog').dialog('open');
		return false;
	});
	
	function select(object){
		if($(object).parent().children(":first").attr('checked')){

			$(object).parent().children(":first").attr('checked', false);
			var color = $(object).parent().class.attr("background-color");
			$(object).parent().css('background-color', color);
		} else {
			$(object).parent().children(":first").attr('checked', true);
			$(object).parent().css('background-color', 'orange');
		}	
		
	}
	
	//Buttonevent für den Reservierungsbutton
	$('#reserve[name=reservebutton]').click(function(){
		var x = findPosX(this);
		var y = findPosY(this);
		
		select(this);
		hideShow(x,y, "divReserveContext");
		return false;
	});
	
	//Buttonevent für den Vormerkungsbutton im Reservierungskontextmenü
	$('#vormerk').click(function(){
		select (this);
		hideShow(x,y, "divReserveContext", $(this), value);
		return false;
	});

});
</script>

<script type="text/javascript">
function loadXMLDoc(url, dialog)
{
	var xmlhttp;
	var data = "";
	if(url=="confirmReservation.htm"|| url=="reservationDone.htm")
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
		if(url=="confirmReservation.htm" && j==0)
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
				loadXMLDoc("reservationDone.htm","reservationConfirmationDialog");
				$("#reservationConfirmationDialog").dialog("option", "buttons", {
					  "Fenster schliessen": function() { 
							for(var i=0; i < document.reservationform.reservationStartTime.length; i++)
							{
								if(document.reservationform.reservationStartTime[i].checked)
									{
										document.reservationform.reservationStartTime[i].checked = false;
									}
							}
						  location.reload();
						  $(this).dialog("close"); 
						  }
					});
				
			}, 
			"Abbrechen": function() { 
				for(var i=0; i < document.reservationform.reservationStartTime.length; i++)
				{
					if(document.reservationform.reservationStartTime[i].checked)
						{
							document.reservationform.reservationStartTime[i].checked = false;
						}
				}
				location.reload();
				$(this).dialog("close"); 
			} 
	});
		data ="reservationStartTimes="+allTimes+"&selectedCourt="+$('#selectedCourt').val()+"&startdate="+$('#startdate').val()+"&username="+$('#username').val();
	}
	if(url=="deleteReservation.htm")
	{
		data ="id="+$('#deleteparameter').val()+"&court="+$('#selectedCourt').val();
	}
	if(url=="reservationDone.htm")
	{
		data ="resName=";
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
<c:if test="${rd.loginError == '0'}">
<div id="base">
<table width=100%>
	<tr>
		<td rowspan=4 valign=top><h1>Reservierungsübersicht</h1>
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
		<td class="reserved-color" width = 150 height=20 align=center style="border-style:solid;border-width:1px;">reserviert</td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td class="abo-color" style="color:white;align:center";" width = 150 height=20 align=center style="border-style:solid;border-width:1px;">reserviert (Abo)
		</td>
	</tr>
</table>
<table>
<tr>
<!--Court Selection-->
		<td>Platzauswahl: </td><td>
			<form name="Auswahl" onchange="submit()">
				<select NAME="court" id="court" SIZE="1" scope="session" >
        			<c:forEach var="court" items="${rd.courts}">	
        				<option <c:if test="${court==rd.selectedCourt}">SELECTED</c:if>>
           					<c:out value="${court}" />
           				</option>
       				</c:forEach>
    			</select>
    		</form>
     	</td>
	</tr>
</table>

<!--Reservation Selection-->	
<table>
	<form:form method="POST" name="reservationform" id="reservationform"> <!-- action="confirmReservation.htm"   -->
		<tr>
			<td colspan=7>
				<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
				<authz:authorize ifAnyGranted="ROLE_CUSTOMER,ROLE_ADMIN"><input type="submit" id="submitbutton" name="submitbutton" value="Ausgewählte Stunden reservieren" /></authz:authorize>				
				<!--<authz:authorize ifAnyGranted="ROLE_CUSTOMER"><input type="submit" value="Ausgewählte Stunden reservieren" onClick="javascript: confirmReservation();"/></authz:authorize>-->
				</c:if>
			</td>
		</tr>
		<tr>
			<td align=center>Uhrzeit
			</td>
			<td align=center>MO
			</td>
			<td align=center>DI
			</td>
			<td align=center>MI
			</td>
			<td align=center>DO
			</td>
			<td align=center>FR
			</td>
			<td align=center>SA
			</td>
			<td align=center>SO
			</td>
		</tr>
		<tr>
			<td>
				<table>
					<tr><td><br></td></tr>
						<c:forEach items="${rd.toTimes}" var="toTimes">
							<tr><td height="30px" valign="middle">${toTimes.key} </td>
						</c:forEach>
				</table>
			</td>
			   <c:forEach items="${rd.reservationsOfDay}" var="days">
				<td>
					<table>
						<tr>
							<c:if test="${rd.startdateX == days.key}">
							<td class="selected-date-color">
							</c:if>
							<c:if test="${rd.startdateX != days.key}">
							<td>
							</c:if>
							<fmt:formatDate type="date" value="${days.key}" pattern="dd.MM.yyyy" dateStyle="short" />
							</td>
						</tr>
						<c:forEach items="${days.value}" var="times">					
							<c:if test="${times.value == '3'}">
									<tr>
										<td class="reserved-color" height="30px"><table width="100%"><tr><td><font color="white">Schne</font></td><td align="right"><authz:authorize ifAnyGranted="ROLE_CUSTOMER"><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><button name="add" id="opener" value="${days.key} ${times.key} 1" title="Reservierung löschen" style="padding:0;margin:0;border: 0px;background-color:red;"><img name="arrow" src="${contextPath}/resources/css/images/arrow.gif" /></button></c:if></authz:authorize>&nbsp;
										</td></tr></table></td>
									</tr>
								</c:if>
							<c:if test="${times.value == '2'}">
									<tr>
										<td class="abo-color" height="30px"><table><tr><td><font color="white">Schne</font></td><td align="right"><authz:authorize ifAnyGranted="ROLE_CUSTOMER"><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><button name="add" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span></button><!--<input type="image" name="add" id="opener" src="${contextPath}/resources/delete.png" alt="Delete" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" height="12" title="Reservierung löschen"/>--></c:if> <!-- <input type="image" src="${contextPath}/resources/mail.gif" alt="Delete" onClick="javascript: invite('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1" height="12" title="Stunde einem Freund vorschlagen"/>--></authz:authorize>&nbsp;
										<!--<td class="abo-color" height="30px"><authz:authorize ifAnyGranted="ROLE_CUSTOMER"><input type="checkbox" name="reservationStartTime" value="${days.key} ${times.key} 1" /><input type="image" id="opener" src="${contextPath}/resources/delete.png" alt="Delete" onClick="javascript: deleteReservation('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" height="12" title="Reservierung löschen"/> <input type="image" src="${contextPath}/resources/mail.gif" alt="Delete" onClick="javascript: invite('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1" height="12" title="Stunde einem Freund vorschlagen"/></authz:authorize>&nbsp;
										--></td></tr></table></td>
									</tr>
								</c:if>
<!--							<c:if test="${times.value == '1'}">-->
<!--								<tr>-->
<!--									<td class="pre-reserved-color" height="30px">&nbsp;-->
<!--									</td>-->
<!--								</tr>-->
<!--							</c:if>-->
							<c:if test="${times.value == '0'}">
									<tr>
										<td class="notreserved-color" height="30px" align=right><authz:authorize ifAnyGranted="ROLE_CUSTOMER, ROLE_ADMIN"><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><input type="checkbox" id= "reservationStartTime" name="reservationStartTime" value="${days.key} ${times.key} 0" title="Stunde zur Reservierung auswählen" style="display: none;"><button name="reservebutton" id="reserve" value="${days.key} ${times.key} 1"><span class="ui-icon ui-icon-check"></span></button></c:if> <!-- <input type="image" src="${contextPath}/resources/mail.gif" alt="Delete" onClick="javascript: invite('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1" height="12" title="Stunde einem Freund vorschlagen"/>--></authz:authorize>&nbsp;
										</td>
									</tr></c:if>
							<c:if test="${times.value == '4'}">
								<tr>
									<td class="abo-color" height="30px"><authz:authorize ifAnyGranted="ROLE_ADMIN"><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><button name="add" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span></button><!--<input type="image" src="${contextPath}/resources/delete.png" alt="Delete" name="add" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" height="12" title="Reservierung löschen"/>--></c:if> <!-- <input type="image" src="${contextPath}/resources/mail.gif" alt="Delete" onClick="javascript: invite('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1" height="12" title="Stunde einem Freund vorschlagen"/>--></authz:authorize>&nbsp;
									<!--<td class="abo-color" height="30px"><authz:authorize ifAnyGranted="ROLE_ADMIN"><input type="image" src="${contextPath}/resources/delete.png" alt="Delete" onClick="javascript: deleteReservation('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" height="12" title="Reservierung löschen"/> <input type="image" src="${contextPath}/resources/mail.gif" alt="Delete" onClick="javascript: invite('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1" height="12" title="Stunde einem Freund vorschlagen"/></authz:authorize>&nbsp;
									--></td>
								</tr>
							</c:if>
							<c:if test="${times.value == '5'}">
								<tr>
									<td class="reserved-color" height="30px"><authz:authorize ifAnyGranted="ROLE_ADMIN"><c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"><button name="add" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span></button><!--<input type="image" src="${contextPath}/resources/delete.png" alt="Delete" name="add" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" height="12" title="Reservierung löschen"/>--></c:if> <!-- <input type="image" src="${contextPath}/resources/mail.gif" alt="Delete" onClick="javascript: invite('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1" height="12" title="Stunde einem Freund vorschlagen"/>--></authz:authorize>&nbsp;
									<!--<td class="reserved-color" height="30px"><authz:authorize ifAnyGranted="ROLE_ADMIN"><input type="image" src="${contextPath}/resources/delete.png" alt="Delete" onClick="javascript: deleteReservation('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" height="12" title="Reservierung löschen"/> <input type="image" src="${contextPath}/resources/mail.gif" alt="Delete" onClick="javascript: invite('${days.key} ${times.key} 1', '${rd.selectedCourt}');" value="${days.key} ${times.key} 1" height="12" title="Stunde einem Freund vorschlagen"/></authz:authorize>&nbsp;
									--></td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
				</td>
			</c:forEach>		
	</tr>
	<tr>
		<td colspan=8>
			<input type="hidden" name="username" id="username" value="<authz:authentication operation="username" />" />
			<input type="hidden" name="selectedCourt" id="selectedCourt" value="${rd.selectedCourt}" />
			<input type="hidden" name="startdate" id="startdate" value="${rd.startdate}" />
			<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
				<authz:authorize ifAnyGranted="ROLE_CUSTOMER,ROLE_ADMIN"><input type="submit" id="submitbutton" name="submitbutton" value="Ausgewählte Stunden reservieren" /></authz:authorize>				
				<!--<authz:authorize ifAnyGranted="ROLE_CUSTOMER"><input type="submit" value="Ausgewählte Stunden reservieren" onClick="javascript: confirmReservation();"/></authz:authorize>-->
			</c:if>
		</td>
	</tr>
</form:form>
</table>
<input type="hidden" id="deleteparameter" />
<!-- Context Menu-->
<div id="reservationConfirmationDialog" title="Reservierungsdaten">
</div>
<div id="aboReservationDialog" title="Reservierungsdaten">
</div>
<div id="dialog" title="Reservierung Löschen?">
	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>Wollen Sie die ausgewählte Einzelstundenreservierung wirklich löschen?</p>
</div>
</div>
</c:if>
<c:if test="${rd.loginError == '1'}">
<br>
			<div class="ui-widget">
				<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;"> 
					<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
					<strong>ACHTUNG: Ihr Login ist fehlgeschlagen!</strong><br>Sie haben entweder einen falschen Benutzernamen oder ein falsches Passwort eingegeben. Bitte wiederholen Sie das Login!<br>
					</p>
				</div>
			</div>
			<br>
</c:if>
<div id="divContext" style="border: 1px solid red; display: none; position: absolute; z-index:2; background-color:white;">
	<table>
		<th colspan=2>Kontextmenü
		</th>
		<tr>
			<td>
				<span class="ui-icon ui-icon-trash"></span>
			</td>
			<td><a href=# onClick="javascript: hide('divContext'); $('#dialog').dialog('open');">Löschen</a>
			</td>
		</tr>
		<tr>
			<td>
				<span class="ui-icon ui-icon-mail-closed"></span>
			</td>
			<td><a href=# onClick="javascript: hide('divContext'); $('#dialog').dialog('open');">Nachricht an Besitzer schicken</a>
			</td>
		</tr>
		<tr>
			<td>
			</td>
		</tr>
	</table>   									
</div>
<div id="divReserveContext" style="border: 1px solid blue; display: none; position: absolute; z-index:2; background-color:white;">
	<table>
		<th colspan=2>Kontextmenü
		</th>
		<tr>
			<td>
				<span class="ui-icon ui-icon-check"></span>
			</td>
			<td><a id="vormerk" href=# onClick="javascript: hide('divReserveContext');">zur Reservierung vormerken</a>
			</td>
		</tr>
		<tr>
			<td>
				<span class="ui-icon ui-icon-check"></span>
			</td>
			<td><a href=# onClick="javascript: hide('divReserveContext'); openAboDialog(value);">als Abostunde reservieren</a>
			</td>
		</tr>
		<tr>
			<td>
			</td>
		</tr>
	</table>   									
</div>
