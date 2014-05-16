<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/jquery.jqplot.css" />

<script src="${contextPath}/resources/js/jquery-1.8.2.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.min.js"></script>
<script src="${contextPath}/resources/js/jquery.tablesorter.js"></script>
<script src="${contextPath}/resources/js/jquery.jqplot.min.js"></script>
<script src="${contextPath}/resources/js/jqplot.barRenderer.min.js"></script>
<script src="${contextPath}/resources/js/jqplot.categoryAxisRenderer.min.js"></script>
<script src="${contextPath}/resources/js/jqplot.canvasTextRenderer.min.js"></script>
<script src="${contextPath}/resources/js/jqplot.canvasAxisLabelRenderer.min.js"></script>
<script src="${contextPath}/resources/js/jqplot.pointLabels.min.js"></script>
<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="${contextPath}/resources/js/excanvas.min.js"></script><![endif]-->

<script type="text/javascript">
var fromDate;
var toDate;

$(document).ready( function() {
	
	initBindings();
	
	document.getElementById("adminPage").style.visibility="visible";
	$('#tabs').tabs({ selected: $("#tabNumber").val() });


	//table for reservation search results
	$("table#reservationSearchResultTable tr:even").css("background-color", "#F4F4F8");
	$("table#reservationSearchResultTable tr:odd").css("background-color", "#EFF1F1");
	
	//table for customer list
	$("table#customerListTable tr:even").css("background-color", "#F4F4F8");
	$("table#customerListTable tr:odd").css("background-color", "#EFF1F1");
	
	
	$("#customerListTable").tablesorter(); 	
});

function initBindings() {
	$('#reservationUpdateButton').click(function(){	
		loadXMLDoc('reservationsUpdated.htm','reservationResult');
		return false;
	});	
}
function updateCourt() {
	this.document.formCourts.action="courtUpdated.htm";
	this.document.formCourts.submit();
	return true;
}
function updateTime() {
		this.document.formTimes.action="timeUpdated.htm";
		this.document.formTimes.submit();
		return true;
}
function updateSaison() {
	this.document.formSaisons.action="saisonUpdated.htm";
	this.document.formSaisons.submit();
	return true;
}
function updateReservation() {
	this.document.reservationForm.action="reservationsUpdated.htm";
	this.document.reservationForm.submit();
	return true;
}

function cancel() {
	this.document.customerEdit.action="admin.htm";
	$('#tabs').tabs({selected: $('#tabNumber').val()});
	this.document.customerEdit.submit();
	return true;
}
function deleteTime() {
	   this.document.formTimes.action="timeDeleted.htm";
	   this.document.formTimes.submit();
	   return true;
}

function selectAllDeleteCheckboxes(){
	if($('#multiselectDelete').is(':checked')){
		for(var j=0; j < $('#resReservationCount').val(); j++){
			$('#resDelete'+j+'[name^=checkdelete]').attr('checked', true);
		}
	}else{
		for(var j=0; j < $('#resReservationCount').val(); j++){
			$('#resDelete'+j+'[name^=checkdelete]').attr('checked', false);
		}
	}
}

function setPermissions(){
	if (document.customerEdit.Enabled.checked) { document.customerEdit.Enabled.value = "1"; }
	else { document.customerEdit.Enabled.value = "0"; }
	if (document.customerEdit.roleAdmin.checked) { document.customerEdit.roleAdmin.value = "1"; }
	else { document.customerEdit.roleAdmin.value = "0"; }
	if (document.customerEdit.roleCustomer.checked) { document.customerEdit.roleCustomer.value = "1"; }
	else { document.customerEdit.roleCustomer.value = "0"; }
	if (document.customerEdit.isMember.checked) { document.customerEdit.isMember.value = "1"; }
	else { document.customerEdit.isMember.value = "0"; }
}

function evalScript(scripts)
	{	try
		{	if(scripts != '')	
			{	var script = "";
				scripts = scripts.replace(/<script[^>]*>([\s\S]*?)<\/script>/gi, function(){
		       	                         if (scripts !== null) script += arguments[1] + '\n';
	 	        	                        return '';});
				if(script) (window.execScript) ? window.execScript(script) : window.setTimeout(script, 0);
			}
			return false;
		}
		catch(e)
		{	alert(e)
		}
	}

$.fx.speeds._default = 100;
$(function(){
	
	$( "#accordion" ).accordion({
		autoHeight: false,
		collapsible: true
	});
	
	$( "#customerAccordion" ).accordion({
		autoHeight: false,
		collapsible: true
	});
	
	// Tabs
	$('#tabs').tabs();
	
	//hover states on the static widgets
	$('#dialog_link, ul#icons li').hover(
		function() { $(this).addClass('ui-state-hover'); }, 
		function() { $(this).removeClass('ui-state-hover'); }
	);
	
	$("#customerDialog").dialog({
		autoOpen: false,
		show: "blind",
		modal: true,
		position: "top",
		width: 600,
		buttons: {
			"Speichern": function() { 
			  	$(this).dialog("option", "buttons", { 
			  		"Schliessen": function() { 
					  	location.reload();
					  	$(this).dialog("close");
					 }
				});
				setPermissions();
				loadXMLDoc("customerAdminUpdateDone.htm","customerDialog");
			}, 
			"Löschen": function() { 
			  	$(this).dialog("option", "buttons", { 
			  		"Schliessen": function() { 
					  	location.reload();
					  	$(this).dialog("close");
					 }
				});
				setPermissions();
				loadXMLDoc("customerAdminDeleteDone.htm","customerDialog");
			},
			"Abbrechen": function() { 
				location.reload();
				$('#customerDialog').dialog("close"); 
			} 
		}
	});
	
	
	$('#customerInfo[name=customerInfo]').click(function(){
		$('#customerParameter').val($(this).val());
		loadXMLDoc("customerData.htm","customerDialog");
		$('#customerDialog').dialog('open');
		return false;
	});
	
	$('#filterReservations').button();
	$('#filterReservations').css({ width: '200px', 'padding-top': '5px', 'padding-bottom': '5px' });
	
	$('#filterReservations').click(function(){	
		loadXMLDoc('adminReservationFilterResults.htm','reservationResult');
		return false;
	});


	var passwordValue = "";

	function loadXMLDoc(url, dialog){
		var xmlhttp;
		var data;
		var reservationIds="";
		var deleted="";
		var reservationStartDates="";
		var reservationStartTimes="";
		var resAbos="";
		var	resInvoiceNumbers="";
		var resUsernames="";
		var resDisplayNames="";
		var resPrices = "";
		var resCourtIds = "";
		//alert("ENTERED");
		if(url=="customerData.htm"){
			var data ="cid="+$('#customerParameter').val();
		}
	
		if(url=="customerAdminUpdateDone.htm"){
				
				//wenn ein neues Password eingegeben worden ist, dann übergeben, ansonsten nicht
				var passwordValueAfterEdit = document.getElementById("adminPassword").value;
				if(passwordValue == passwordValueAfterEdit){
					var data ="adminCustomerId="+$('#adminCustomerId').val()+"&adminUsername="+$('#adminUsername').val()+"&code="+$('#code').val()+"&firstname="+$('#adminFirstName').val()+"&lastname="+$('#adminLastName').val()+"&email="+$('#adminEmail').val()+"&isMember="+$('#adminIsMember').val()+"&street="+$('#adminStreet').val()+"&plz="+$('#adminPlz').val()+"&city="+$('#adminCity').val()+"&birthday="+$('#adminBirthday').val()+"&country="+$('#adminCountry').val()+"&telefon="+$('#adminTelefon').val()+"&handy="+$('#adminHandy').val()+"&Enabled="+$('#Enabled').val()+"&roleAdmin="+$('#roleAdmin').val()+"&roleCustomer="+$('#roleCustomer').val();
				}else{
					data ="adminCustomerId="+$('#adminCustomerId').val()+"&adminUsername="+$('#adminUsername').val()+"&code="+$('#code').val()+"&firstname="+$('#adminFirstName').val()+"&lastname="+$('#adminLastName').val()+"&email="+$('#adminEmail').val()+"&password="+$('#adminPassword').val()+"&passwordrepeat="+$('#adminPasswordrepeat').val()+"&isMember="+$('#adminIsMember').val()+"&street="+$('#adminStreet').val()+"&plz="+$('#adminPlz').val()+"&city="+$('#adminCity').val()+"&birthday="+$('#adminBirthday').val()+"&country="+$('#adminCountry').val()+"&telefon="+$('#adminTelefon').val()+"&handy="+$('#adminHandy').val()+"&Enabled="+$('#Enabled').val()+"&roleAdmin="+$('#roleAdmin').val()+"&roleCustomer="+$('#roleCustomer').val();		
				}		
				$("#customerDialog").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
		
		}
		if(url=="customerAdminDeleteDone.htm"){
			
			var data ="adminCustomerId="+$('#adminCustomerId').val()+"&roleAdmin="+$('#roleAdmin').val()+"&roleCustomer="+$('#roleCustomer').val();		
			$("#customerDialog").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
	
	}
		if(url=="adminReservationFilterResults.htm"){
			$("#reservationResult").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
			var resTypeValue="";
			for (var i=0; i < $('#resType').length; i++)
			   {
			   if ($('#resType')[i].checked)
			      {
			      	resTypeValue = $('#resType')[i].value;
			      }
			   }
			data ="resFromDate="+$('#datepicker5').val()+"&resToDate="+$('#datepicker6').val()+"&resFromTime="+$('#resFromTime').val()+"&resToTime="+$('#resToTime').val()+"&resAbo="+$('#resAbo').val()+"&resInvoice="+$('#resInvoice').val()+"&resUsername="+$('#resUsername').val()+"&resDisplayName="+$('#resDisplayName').val();
			//alert(data);
		}
		if(url=="reservationsUpdated.htm"){
			for(var i=0; i < $('#resReservationCount').val(); i++)
			{
				reservationIds = reservationIds + $('#resReservationId'+i).val()+";";
				reservationStartDates = reservationStartDates + $('#resReservationStartDate'+i).val()+";";
				reservationStartTimes = reservationStartTimes + $('#resReservationStartTime'+i).val()+";";
				resAbos = resAbos + $('#resAbo'+i).val()+";";
				resUsernames = resUsernames + $('#resUsernameData'+i).val()+";";
				resDisplayNames = resDisplayNames + $('#resDisplayName'+i).val()+";";
				resPrices = resPrices + $('#resPrice'+i).val()+";";
				resCourtIds = resCourtIds + $('#courtId'+i).val()+";";
				if($('#resDelete'+i).attr('checked')){
					deleted = deleted + "1";
				} else {
					deleted = deleted + "0";
				}
			}
			//alert(deleted);
			data ="reservationId="+reservationIds+"&reservationStartDate="+reservationStartDates+"&reservationStartTime="+reservationStartTimes+"&resAbo="+resAbos+"&username="+resUsernames+"&displayName="+resDisplayNames+"&price="+resPrices+"&reservationCount="+$('#resReservationCount').val()+"&courtId="+resCourtIds+"&delete="+deleted;
			
			
		}
		if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
		  xmlhttp=new XMLHttpRequest();
		} else {// code for IE6, IE5
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function(){
		  if (xmlhttp.readyState==4 && xmlhttp.status==200){
			    
			  	document.getElementById(dialog).innerHTML=xmlhttp.responseText; 
			  	if(url=="customerData.htm"){
			    	//alten Passwordwert zwischenspeichern
			    	passwordValue = document.getElementById("adminPassword").value;
			    }
			  	evalScript(xmlhttp.responseText);
			  	initBindings();
		    }
		};

	xmlhttp.open("POST",url,true);
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-length", data.length);
	xmlhttp.setRequestHeader("Connection", "close");
	xmlhttp.send(data);

	}
	
	// Datepicker
	$('#datepicker3').datepicker({
		dateFormat: 'yy-mm-dd',
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		yearRange: '1910:2020',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember']				
	});	
	$('#datepicker4').datepicker({
		dateFormat: 'yy-mm-dd',
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		yearRange: '1910:2020',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember']				
	});
	$('#datepicker5').datepicker({
		dateFormat: 'yy-mm-dd',
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		yearRange: '1910:2020',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],	
		onSelect: function(dateText, inst){
			fromDate = dateText;
		}
	});
	$('#datepicker6').datepicker({
		dateFormat: 'yy-mm-dd',
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		yearRange: '1910:2020',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
		onSelect: function(dateText, inst){
			toDate = dateText;
		}
	});
	$('#createCustomerDatePicker').datepicker({
		dateFormat: 'yy-mm-dd',
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		yearRange: '1910:2020',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember']				
	});	
	
	$('#filterReservations').click(function() {
		$('#reservationResult').stop(true,true).slideDown(600,"linear");
	});
});
</script>
<style type="text/css">
/* 	.ui-tab {	 */
/* 		font-size: 12px; */
/* 	} */
/* 	.ui-dialog {	 */
/* 		font-size: 12.0px; */
/* 	} */
/* 	.ui-datepicker { */
/* 		font-size: 11.4px; */
/* 	}			 */
/* 	#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;} */
/* 	#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;} */
/* 	ul#icons {margin: 0; padding: 0;} */
/* 	ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;} */
/* 	ul#icons span.ui-icon {float: left; margin: 0 4px;} */
</style>
</head>
<body>
<input type="hidden" id="tabNumber" value="${rd.tabnumber}" />
<div id="adminPage" style="visibility:hidden">
	<authz:authorize ifAnyGranted="ROLE_ADMIN">
		<div id="tabs" class="ui-tab">
            <div id="tabsHeader">Adminbereich:</div>
			<ul>
				<li><a href="#tabs-1">Plätze</a></li>
				<li><a href="#tabs-2">Tarife</a></li>
				<li><a href="#tabs-3">Abos</a></li>
				<li><a href="#tabs-4">Settings</a></li>
				<li><a href="#tabs-5">Reservierungen</a></li>
				<li><a href="#tabs-6">Kundenverwaltung</a></li>
				<li><a href="#tabs-8">Mitgliederverwaltung</a></li>
				<li><a href="#tabs-7">Statistiken</a></li>	
			</ul>
			<div id="tabs-1">
				
				<h2>Einen neuen Platz anlegen:</h2>
				
				<table>
				  <form:form method="POST" action="courtCreated.htm">
					<tr>
						<td>Nummer
						</td>
						<td>Name
						</td>
						<td>Platzart
						</td>
						<td>Reservierbar
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="courtNumber" size=3/>
						</td>
						<td>
							<input type="text" name="courtName" size=10/>
						</td>
						<td>
							<select NAME="courtType" id="courtType" SIZE="1">
		   						<option value="0">Freiplatz
		   						</option>
		   						<option value="1">Hallenplatz
		   						</option>
		      				</select>
						</td>
						<td>
							<input type="checkbox" name="bookable" value="1" CHECKED/>
						</td>
						<td colspan=4>	
							<input type="submit" value="Anlegen"/>
						</td>
					</tr>
					
				  </form:form>
				</table>

<br>
<br>
<h2>Folgende Plätze sind bereits angelegt:</h2>
				<table>
					<tr>
						<td>
						</td>
						<td>Nummer
						</td>
						<td>Name
						</td>
						<td>Indoor Court
						</td>
						<td>Reservierbar
						</td>
						<td>Löschen
						</td>
					</tr>
					<form:form method="POST" name="formCourts">
					<c:set var="j" value="0" />
						<c:forEach items="${rd.courts}" var="court">
						<tr>
							<td>
								<input type="hidden" name="courtId" value="${court.id}" />
							</td>
							<td>
								<input type="text" name="courtNumber" value="${court.courtNumber}" size=3/>
							</td>
							<td>
								<input type="text" name="courtName" value="${court.courtName}" size=10/>
							</td>
							<td>
							  <select name="courtType" SIZE="1">
		   						<option value="0" <c:if test="${court.indoorCourt==0}">SELECTED</c:if>>Freiplatz
		   						</option>
		   						<option value="1" <c:if test="${court.indoorCourt==1}">SELECTED</c:if>>Hallenplatz
		   						</option>
		      				  </select>
							</td>
							<td>
								<input type="hidden" name="isBookable[${j}]" value="0" />
								<input type="checkbox" name="isBookable[${j}]" value="1" <c:if test="${court.bookable==1}">CHECKED</c:if> />
							</td>
							<td>
								<input type="hidden" name="deleted[${j}]" value="0" />
								<input type="checkbox" name="deleted[${j}]" value="1" />							
							</td>
						</tr>
							<c:set var="j" value="${j+1}" />
						</c:forEach>
						<tr>
							<td colspan=4>
								<input type="hidden" name="count" value="${j}" />
								<input type="submit" value="Ändern" onClick="javascript: updateCourt();"/>
							</td>
						</tr>
					</form:form>				
				</table>
				
			</div>
			<div id="tabs-2">
				
				<h2>Einen neuen Tarif anlegen:</h2>
				
				<table>
				  <form:form method="POST" name="formCreated" action="timeCreated.htm">
					<tr>
						<td>Name
						</td>
						<td>Von-Datum
						</td>
						<td>Bis-Datum
						</td>
						<td>Von-Zeit
						</td>
						<td>Bis-Zeit
						</td>
						<td>Preis für 
						<br>Mitglieder
						</td>
						<td>Preis für 
						<br>Nichtmitglieder
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="timeName" size=10/>
						</td>
						<td>
							<input type="text" name="dateFrom" size=8/>
						</td>
						<td>
							<input type="text" name="dateTo" size=8/>
						</td>
						<td>
							<!-- <input type="text" name="timeFrom" size=6/> -->
							<select name="timeFrom" size="1">
							      <option value="06:00:00">06:00</option>
							      <option value="07:00:00">07:00</option>
							      <option value="08:00:00">08:00</option>
							      <option value="09:00:00">09:00</option>
							      <option value="10:00:00">10:00</option>
							      <option value="11:00:00">11:00</option>
							      <option value="12:00:00">12:00</option>
							      <option value="13:00:00">13:00</option>
							      <option value="14:00:00">14:00</option>
							      <option value="15:00:00">15:00</option>
							      <option value="16:00:00">16:00</option>
							      <option value="17:00:00">17:00</option>
							      <option value="18:00:00">18:00</option>
							      <option value="19:00:00">19:00</option>
							      <option value="20:00:00">20:00</option>
							      <option value="21:00:00">21:00</option>
							      <option value="22:00:00">22:00</option>
							      <option value="23:00:00">23:00</option>
							</select>
						</td>
						<td>
							<!-- <input type="text" name="timeTo" size=6/> -->
							<select name="timeTo" size="1">
							      <option value="06:00:00">06:00</option>
							      <option value="07:00:00">07:00</option>
							      <option value="08:00:00">08:00</option>
							      <option value="09:00:00">09:00</option>
							      <option value="10:00:00">10:00</option>
							      <option value="11:00:00">11:00</option>
							      <option value="12:00:00">12:00</option>
							      <option value="13:00:00">13:00</option>
							      <option value="14:00:00">14:00</option>
							      <option value="15:00:00">15:00</option>
							      <option value="16:00:00">16:00</option>
							      <option value="17:00:00">17:00</option>
							      <option value="18:00:00">18:00</option>
							      <option value="19:00:00">19:00</option>
							      <option value="20:00:00">20:00</option>
							      <option value="21:00:00">21:00</option>
							      <option value="22:00:00">22:00</option>
							      <option value="23:00:00">23:00</option>
							</select>
						</td>
						<td>
							<input type="text" name="priceForMember" size=2/>
						</td>
						<td>
							<input type="text" name="priceForNonMember" size=2/>
						</td>
						<td colspan=4>	
							<input type="submit" value="Anlegen"/>
						</td>	
					</tr>
				
				  </form:form>
				</table>
				
				<h2>Folgende Tarife sind bereits angelegt:</h2>
				<table>
					<tr>
						<td></td>
						<td>Name
						</td>
						<td>Von-Datum
						</td>
						<td>Bis-Datum
						</td>
						<td>Von-Uhrzeit
						</td>
						<td>Bis-Zeit
						</td>
						<td>Einzelpreis für 
						<br>Mitglieder
						</td>
						<td>Einzelpreis für <br>
						Nichtmitglieder 
						</td>
						<td>Löschen
						</td>
					</tr>
					<form:form name="formTimes" method="POST" >
					<c:set var="m" value="0" />
					<c:forEach items="${rd.times}" var="time">
						<tr>
							<td>
								<input type="hidden" name="timeId" value="${time.timeId}" size=3/>
							</td>
							<td>
								<input type="text" name="timeName" value="${time.name}" size=10/>
							</td>
							<td>
								<input type="text" name="dateFrom" value="${time.dateFrom}" size=9/>
							</td>
							<td>
								<input type="text" name="dateTo" value="${time.dateTo}" size=9/>
							</td>
							<td>
								<!-- <input type="text" name="timeFrom" value="${time.timeFrom}" size=6/> -->
								<select name="timeFrom" size="1">
							      <option value="06:00:00" <c:if test="${time.timeFrom == '06:00:00'}">SELECTED</c:if>>06:00</option>
							      <option value="07:00:00" <c:if test="${time.timeFrom == '07:00:00'}">SELECTED</c:if>>07:00</option>
							      <option value="08:00:00" <c:if test="${time.timeFrom == '08:00:00'}">SELECTED</c:if>>08:00</option>
							      <option value="09:00:00" <c:if test="${time.timeFrom == '09:00:00'}">SELECTED</c:if>>09:00</option>
							      <option value="10:00:00" <c:if test="${time.timeFrom == '10:00:00'}">SELECTED</c:if>>10:00</option>
							      <option value="11:00:00" <c:if test="${time.timeFrom == '11:00:00'}">SELECTED</c:if>>11:00</option>
							      <option value="12:00:00" <c:if test="${time.timeFrom == '12:00:00'}">SELECTED</c:if>>12:00</option>
							      <option value="13:00:00" <c:if test="${time.timeFrom == '13:00:00'}">SELECTED</c:if>>13:00</option>
							      <option value="14:00:00" <c:if test="${time.timeFrom == '14:00:00'}">SELECTED</c:if>>14:00</option>
							      <option value="15:00:00" <c:if test="${time.timeFrom == '15:00:00'}">SELECTED</c:if>>15:00</option>
							      <option value="16:00:00" <c:if test="${time.timeFrom == '16:00:00'}">SELECTED</c:if>>16:00</option>
							      <option value="17:00:00" <c:if test="${time.timeFrom == '17:00:00'}">SELECTED</c:if>>17:00</option>
							      <option value="18:00:00" <c:if test="${time.timeFrom == '18:00:00'}">SELECTED</c:if>>18:00</option>
							      <option value="19:00:00" <c:if test="${time.timeFrom == '19:00:00'}">SELECTED</c:if>>19:00</option>
							      <option value="20:00:00" <c:if test="${time.timeFrom == '20:00:00'}">SELECTED</c:if>>20:00</option>
							      <option value="21:00:00" <c:if test="${time.timeFrom == '21:00:00'}">SELECTED</c:if>>21:00</option>
							      <option value="22:00:00" <c:if test="${time.timeFrom == '22:00:00'}">SELECTED</c:if>>22:00</option>
							      <option value="23:00:00" <c:if test="${time.timeFrom == '23:00:00'}">SELECTED</c:if>>23:00</option>
								</select>
							</td>
							<td>
								<!-- <input type="text" name="timeTo" value="${time.timeTo}" size=6/> -->
								<select name="timeTo" size="1">
							      <option value="06:00:00" <c:if test="${time.timeTo == '06:00:00'}">SELECTED</c:if>>06:00</option>
							      <option value="07:00:00" <c:if test="${time.timeTo == '07:00:00'}">SELECTED</c:if>>07:00</option>
							      <option value="08:00:00" <c:if test="${time.timeTo == '08:00:00'}">SELECTED</c:if>>08:00</option>
							      <option value="09:00:00" <c:if test="${time.timeTo == '09:00:00'}">SELECTED</c:if>>09:00</option>
							      <option value="10:00:00" <c:if test="${time.timeTo == '10:00:00'}">SELECTED</c:if>>10:00</option>
							      <option value="11:00:00" <c:if test="${time.timeTo == '11:00:00'}">SELECTED</c:if>>11:00</option>
							      <option value="12:00:00" <c:if test="${time.timeTo == '12:00:00'}">SELECTED</c:if>>12:00</option>
							      <option value="13:00:00" <c:if test="${time.timeTo == '13:00:00'}">SELECTED</c:if>>13:00</option>
							      <option value="14:00:00" <c:if test="${time.timeTo == '14:00:00'}">SELECTED</c:if>>14:00</option>
							      <option value="15:00:00" <c:if test="${time.timeTo == '15:00:00'}">SELECTED</c:if>>15:00</option>
							      <option value="16:00:00" <c:if test="${time.timeTo == '16:00:00'}">SELECTED</c:if>>16:00</option>
							      <option value="17:00:00" <c:if test="${time.timeTo == '17:00:00'}">SELECTED</c:if>>17:00</option>
							      <option value="18:00:00" <c:if test="${time.timeTo == '18:00:00'}">SELECTED</c:if>>18:00</option>
							      <option value="19:00:00" <c:if test="${time.timeTo == '19:00:00'}">SELECTED</c:if>>19:00</option>
							      <option value="20:00:00" <c:if test="${time.timeTo == '20:00:00'}">SELECTED</c:if>>20:00</option>
							      <option value="21:00:00" <c:if test="${time.timeTo == '21:00:00'}">SELECTED</c:if>>21:00</option>
							      <option value="22:00:00" <c:if test="${time.timeTo == '22:00:00'}">SELECTED</c:if>>22:00</option>
							      <option value="23:00:00" <c:if test="${time.timeTo == '23:00:00'}">SELECTED</c:if>>23:00</option>
								</select>
							</td>
							<td><input type="text" name="priceForMember" value="${time.priceForMember}" size=2/>
							</td>
							<td><input type="text" name="priceForNonMember" value="${time.priceForNonMember}" size=2/>
							</td>
							<td>
							<input type="hidden" name="deleted[${m}]" value="0" />
							<input type="checkbox" name="deleted[${m}]" value="1"/>
							</td>
						</tr>
						<c:set var="m" value="${m+1}" />
					</c:forEach>
						<tr>
							<td colspan=3>
								<input type="submit" value="Ändern" onClick="javascript: updateTime();" />
							</td>
						</tr>
					</form:form>				
				</table>
				
			</div>
			<div id="tabs-3">
				<h2>Eine neues Abo anlegen:</h2>
				<table>
				  <form:form method="POST" action="saisonCreated.htm">
					<tr>
						<td>Aboname
						</td>
						<td>Abobeginn
						</td>
						<td>Aboende
						</td>
						<td>Abostunde<br>
						nach
						</td>
						<td>Abostunde<br>
						vor
						</td>
						<td>Preis für <br>
						Mitglieder
						</td>
						<td>Preis für <br>
						Nicht-Mitglieder
						</td>
						<td>Reservierbar
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="saisonName" size=20/>
						</td>
						<td>
							<div><input type="text" name="saisonBegin" id="datepicker3" size=10/></div>
						</td>
						<td>
							<div><input type="text" name="saisonEnd" id="datepicker4" size=10/></div>
						</td>
						<td>
							<input type="text" name="saisonTimeFrom" value="${saison.saisonTimeFrom}" size=10/>
						</td>
						<td>
							<input type="text" name="saisonTimeTo" value="${saison.saisonTimeTo}" size=10/>
						</td>
						<td>
							<input type="text" name="aboPriceMember" size=2/>
						</td>
						<td>
							<input type="text" name="aboPriceNonMember" size=2/>
						</td>
						<td>
							<input type="checkbox" name="bookable" value="1" CHECKED/>
						</td>
						<td colspan=4>	
							<input type="submit" value="Anlegen"/>
						</td>
					</tr>
					
				  </form:form>
				</table>

<br>
<br>
<h2>Folgende Saisonen sind bereits angelegt:</h2>
				<table>
					<tr>
						<td>
						</td>
						<td>Aboname
						</td>
						<td>Abobeginn
						</td>
						<td>Aboende
						</td>
						<td>Abostunde<br>
						nach
						</td>
						<td>Abostunde<br>
						vor
						</td>
						<td>Preis für <br>
						Mitglieder
						</td>
						<td>Preis für <br>
						Nicht-Mitglieder
						</td>
						<td>Reservierbar
						</td>
					</tr>
					<form:form method="POST" name="formSaisons">
					<c:set var="k" value="0" />
						<c:forEach items="${rd.saisons}" var="saison">
						<tr>
							<td>
								<input type="hidden" name="saisonId" value="${saison.saisonId}" />
							</td>
							<td>
								<input type="text" name="saisonName" value="${saison.saisonName}" size=20/>
							</td>
							<td>
								<input type="text" name="saisonBegin" value="${saison.saisonBegin}" size=10/>
							</td>
							<td>
								<input type="text" name="saisonEnd" value="${saison.saisonEnd}" size=10/>
							</td>
							<td>
								<input type="text" name="saisonTimeFrom" value="${saison.saisonTimeFrom}" size=10/>
							</td>
							<td>
								<input type="text" name="saisonTimeTo" value="${saison.saisonTimeTo}" size=10/>
							</td>
							<td>
								<input type="text" name="aboPriceMember" value="${saison.aboPriceMember}" size=2/>
							</td>
							<td>
								<input type="text" name="aboPriceNonMember" value="${saison.aboPriceNonMember}" size=2/>
							</td>
							<td>
								<input type="hidden" name="Book[${k}]" value="0" />
								<input type="checkbox" name="Book[${k}]" value="1" <c:if test="${saison.bookable==1}">CHECKED</c:if> />
							</td>
							<td>
								<input type="hidden" name="delete[${k}]" value="0" />
								<input type="checkbox" name="delete[${k}]" value="1" />							
							</td>
						</tr>
							<c:set var="k" value="${k+1}" />
						</c:forEach>
						<tr>
							<td colspan=4>
								<input type="hidden" name="saisonCount" value="${k}" />
								<input type="submit" value="Ändern" onClick="javascript: updateSaison();"/>
							</td>
						</tr>
					</form:form>				
				</table>
				
			</div>
			<div id="tabs-4">
				<form:form method="POST" name="settingsForm" action="settingsUpdated.htm">
					<h1>Limit für Reservierungen</h1>	
						<table>
							<tr>
								<td colspan="2">Bitte geben Sie hier an, bis zu welchem Datum Reservierungen möglich sein sollen. Alle Reservierungen, die für ein Datum nach diesem Limit gemacht werden, sind nicht möglich.
								</td>
							</tr>
							<tr><td>&nbsp;<td></tr>
							<tr>
								<td>Reservierungslimit (Datum)
								</td>
								<td>
									<input type="text" name="reservationDateLimit" value="${rd.settings.reservationDateLimit}"/>
								</td>
							</tr>
						</table>
					<h1>E-Mail Weiterleitung</h1>	
						<table>
							<tr>
								<td colspan="2">Bitte geben Sie hier an, ob Reservierungen, die von Kunden getätigt werden, an die angegebene Email-Adresse (zB. des Kassiers) weitergeleitet werden sollen.
								</td>
							</tr>
							<tr><td>&nbsp;<td></tr>
							<tr>
								<td>Weiterleiten?
								</td>
								<td>
									<input type="radio" name="forward" value="1" <c:if test="${rd.settings.forward == 1}">CHECKED</c:if> />ja
									<input type="radio" name="forward" value="0" <c:if test="${rd.settings.forward == 0}">CHECKED</c:if> />nein
								</td>
							<tr>
								<td>Weiterleiten an folgende Adresse:
								</td>
								<td>
									<input type="text" name="forwardEmail" value="${rd.settings.forwardEmail}"/>
								</td>
							</tr>
						</table>
					<h1>Stornierungsfrist</h1>
						<table>
							<tr>
								<td colspan="2">
									Bitte geben Sie hier an, wieviel Minuten vor Beginn eine reservierte Stunde noch storniert werden kann.
								</td>
							</tr>
							<tr><td>&nbsp;<td></tr>
							<tr>
								<td>Löschfrist (in Min.)
								</td>
								<td>
									<input type="text" name="deletionLimit" value="${rd.settings.deletion}"/>
								</td>
							</tr>
						</table>
					<h1>Sperren</h1>
						<table>
							<tr>
								<td colspan="2">
									Bitte geben Sie hier an, ob Sie die Einzelstunden-, Aboreservierung oder beide Reservierungsarten für normale Benutzer sperren wollen.
								</td>
							</tr>
							<tr><td>&nbsp;<td></tr>
							<tr>
								<td>Sperre auswählen
								</td>
								<td>
									<select NAME="lock" id="lock" SIZE="1" scope="session" >
		       				   			<option value="0" <c:if test="${rd.settings.locked==0}">SELECTED</c:if>>keine Sperren</option>
		               					<option value="1" <c:if test="${rd.settings.locked==1}">SELECTED</c:if>>Aboreservierung sperren</option>
		               					<option value="2" <c:if test="${rd.settings.locked==2}">SELECTED</c:if>>Einzelstundenreservierung sperren</option>
		               					<option value="3" <c:if test="${rd.settings.locked==3}">SELECTED</c:if>>Einzelstunden- und Aboreservierung sperren</option>
		       						</select>
								</td>
							</tr>
							<tr>
								<td>
									<input type="submit" value="Speichern" />
								</td>
							</tr>
						</table>
				</form:form>
			</div>
			<div id="tabs-5">
				<div id="accordion">
					<h3><a href="#">Reservierungssuche</a></h3>
					<div id="searchform">
						
						<div style="height:30px;">Geben Sie hier Ihre Suchkriterien ein und klicken Sie "Reservierungen suchen."
						</div>
						<table>
							<tr>
								<td>
									Von-Datum <br>
									<div id="datepicker5" name="resFromDate" size=8></div>
								</td>
								<td width=20>
								</td>
								<td>
									Bis-Datum <br>
									<div id="datepicker6" name="resToDate" size=8></div>
								</td>
								<td width=20>
								</td>
								<td valign=top>
								Von-Uhrzeit<br>
								<select id="resFromTime" name="fromTime" >
										<option value=null SELECTED></option>
										<option value="06:00">06:00</option>
										<option value="07:00">07:00</option>
										<option value="08:00">08:00</option>
										<option value="09:00">09:00</option>
										<option value="10:00">10:00</option>
										<option value="11:00">11:00</option>
										<option value="12:00">12:00</option>
										<option value="13:00">13:00</option>
										<option value="14:00">14:00</option>
										<option value="15:00">15:00</option>
										<option value="16:00">16:00</option>
										<option value="17:00">17:00</option>
										<option value="18:00">18:00</option>
										<option value="19:00">19:00</option>
										<option value="20:00">20:00</option>
										<option value="21:00">21:00</option>
										<option value="22:00">22:00</option>
										<option value="23:00">23:00</option>
									</select>
								<br>
								<br>
								Bis-Uhrzeit
								<br>
								<select id="resToTime" name="toTime" >
											<option value=null SELECTED></option>
										<option value="06:00">06:00</option>
										<option value="07:00">07:00</option>
										<option value="08:00">08:00</option>
										<option value="09:00">09:00</option>
										<option value="10:00">10:00</option>
										<option value="11:00">11:00</option>
										<option value="12:00">12:00</option>
										<option value="13:00">13:00</option>
										<option value="14:00">14:00</option>
										<option value="15:00">15:00</option>
										<option value="16:00">16:00</option>
										<option value="17:00">17:00</option>
										<option value="18:00">18:00</option>
										<option value="19:00">19:00</option>
										<option value="20:00">20:00</option>
										<option value="21:00">21:00</option>
										<option value="22:00">22:00</option>
										<option value="23:00">23:00</option>
									</select>
								<br>
								<br>
									Reservierungstyp
									<br>	
									<select id="resAbo" name="abo" >
										<option value=null SELECTED></option>
										<option value="TRUE">Abo</option>
										<option value="FALSE">Einzel</option>
									</select>
								<br>
								<br>
									Benutzername
									<br>
									<select id="resUsername" name="username" >
										<option value=null></option>
										<c:forEach var="user" items="${rd.customers}">		
		        							<option value="${user.username}">
		           								<c:out value="${user.username}" />
		           							</option>
		       							</c:forEach>
									</select>
								</td>
								<td width=20>
								</td>
								<td valign=top>
									Rechnungsnr.
									<br>
									<select id="resInvoice" name="invoice" >
										<option value=null></option>
										<c:forEach var="invoice" items="${rd.invoiceIds}">		
		        							<option value="${invoice.invoiceId}">
		           								<c:out value="${invoice.invoiceId}" />
		           							</option>
		       							</c:forEach>
									</select>
									<br>
									<br>
									Reservierungstext
									<br>
									<input type="text" id="resDisplayName" name="displayName" size="8"/>
								</td>
							</tr>
							<tr style="height:20px;">
								<td colspan=10>
								</td>
							</tr>
						</table>
						<table style="width:100%">
							<tr>
								<td align=right>
									<input type="submit" id="filterReservations" value="Reservierungen suchen"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
					<div id="reservationResult" style="display:none">
					<form:form method="POST" name="reservationForm">
					<h4 class="ui-widget-header ui-corner-all">Suchergebnisse</h4>
						<table id="reservationSearchResultTable">
							<thead>
							<tr>
								<th align="center">Datum
								</th>
								<th align="center">Uhrzeit
								</th>
								<th align="center">Abo
								</th>
								<th align="center">Rech-Nr.
								</th>
								<th align="center">Kunde
								</th>
								<th align="center">Anzeigename
								</th>
								<th align="center">Preis
								</th>
		<!--						<th align="center">Bezahlstatus-->
		<!--						</th>-->
								<th align="center">Löschen
								</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td colspan=7>
								</td>
								<td align="center">
									<input type="checkbox" id="multiselectDelete" onclick="javascript: selectAllDeleteCheckboxes();" />
								</td>
							</tr>
						<c:set var="x" value="0" />
							<c:forEach items="${rd.reservations}" var="reservation">
							<tr>
								<td align="center"><input type="hidden"  id="resReservationId${x}" name="reservationId" value="${reservation.reservationId}"/><input type="hidden"  id="courtId${x}" name="courtId" value="${reservation.courtId}"/><input type="text" id="resReservationStartDate${x}" name="reservationStartDate" value="${reservation.reservationStartDate}" style="width:100px;"/><input type="hidden"  name="reservationStartTime" value="${reservation.reservationStartTime}"/>
								</td>
								<td align="center"><input type="text" id="resReservationStartTime${x}" value="${reservation.reservationStartTime}" style="width:100px;"/>							
								</td>
								<td align="center">
									<c:if test="${reservation.abo==true}">
										<input type="text" id="resAbo${x}" value="ja" />
									</c:if>
									<c:if test="${reservation.abo==false}">
										<input type="text" id="resAbo${x}" value="nein" />
									</c:if>
								</td>
								<td align="center"><input type="text" id="resInvoiceNumber${x}" value="${reservation.invoiceNumber}" />
								</td>
								<td align="center">
									<select id="resUsernameData${x}" name="username" >
	<!--									<option value="0"></option>-->
										<c:forEach var="user" items="${rd.customers}">		
		        							<option value="${user.username}" <c:if test="${reservation.username==user.username}">SELECTED</c:if>>
		           								<c:out value="${user.username}" />
		           							</option>
		       							</c:forEach>
									</select>
	<!--								<input type="text"  name="username" value="${reservation.username}" size=10/>-->
								</td>
								<td align="center">
									<input type="text" id="resDisplayName${x}" name="displayName" size=5 value="${reservation.reservationName}"/>
								</td>
								<td align="center">
									<input type="text" id="resPrice${x}" name="price" size=3 value="${reservation.price}"/>
								</td>
	<!--							<td>-->
	<!--								<input type="text"  name="paymentStatus" size=1 />-->
	<!--							</td>-->
								<td align="center">
									<!-- <input type="hidden" id="resDelete${x}" name="hiddendelete[${x}]" value="0" />
									<input type="checkbox"  id="resDelete${x}" name="checkdelete[${x}]" value="1" />-->
									<input type="checkbox"  id="resDelete${x}" name="checkdelete" />
								</td>
							</tr>
							<c:set var="x" value="${x+1}" />
							</c:forEach>
							<tr>
								<td>
									<c:out value="${x}" /> Reservierungen
								</td>
							</tr>
							<tr>
								<td colspan=9>
									<input type="hidden" id="resReservationCount" name="reservationCount" value="${x}" />
									<input type="submit" value="Ändern" id="reservationUpdateButton"/>
								</td>
							</tr>
							</tbody>
						</table>
					</form:form>
					</div>
			</div>
			<div id="tabs-6">
				<div id="customerAccordion">
					<h3><a href="#">Einen neuen Kunden anlegen</a></h3>
					<div>
						<form method="POST" action="customerCreated.htm">
						<table>
						<tr><td>&nbsp;</td>
						</tr>
						<tr>
							<td>
								<spring:message code="field.firstName" />*</td><td><input type="text" name="firstname"><br>
							</td>
							<td></td>
						</tr>
						<tr>
							<td>
								<spring:message code="field.lastName" />*</td><td><input type="text" name="lastname"><br>
							</td>
							<td></td>
						</tr>
						<tr>
							<td>
								<spring:message code="field.email" />*</td><td><input type="text" name="email"><br>
							</td>
							<td>Die e-mail muss angegeben werden, weil z.B. Reservierungsbestätigungen per email verschickt werden.</td>
						</tr>
						<tr>
							<td>
								<spring:message code="field.loginUsername" />*</td><td><input type="text" name="username"><br>
							</td>
							<td>Mit diesem Benutzernamen (und dem Passwort) können Sie sich nach der Registrierung anmelden.</td>
						</tr>
						<tr>
							<td><spring:message code="field.loginPassword" />*</td><td><input type="password" name="password" /><br>
								
							</td>
						</tr>
						<tr>
							<td><spring:message code="field.loginPasswordRepeat" />*</td><td><input type="password" name="passwordrepeat" /><br>
								
							</td>
						</tr>
						<tr><td>&nbsp;</td>
						</tr>
						<tr>
							<td>
								TCK Mitglied
							</td>
							<td>
								<input type="checkbox" name="isMember" value="0"/><br>
							</td>
						</tr>
						<tr>
							<td>
								Strasse und Hausnummer
							</td>
							<td>
								<input type="text" name="street" value="${rd.customer.street}"/><br>
							</td>
						</tr>
						<tr>
							<td>
								PLZ und Ort
							</td>
							<td>
								<input type="text" name="plz" value="${rd.customer.plz}"/><br>
							</td>
							<td>
								<input type="text" name="city" value="${rd.customer.city}"/><br>
							</td>
						</tr>
						<tr>
							<td>
								Geburtsdatum
							</td>
							<td>
								<div><input type="text" name="birthday" id="createCustomerDatePicker" value="${rd.customer.birthday}"></div><br>
							</td>
						</tr>
						<tr>
							<td>
								Land
							</td>
							<td>
								<input type="text" name="country" value="${rd.customer.country}"/><br>
							</td>
						</tr>
						<tr>
							<td>
								Telefonnummer
							</td>
							<td>
								<input type="text" name="telefon" value="${rd.customer.telefon}"/><br>
							</td>
						</tr>
						<tr>
							<td>
								Handy
							</td>
							<td>
								<input type="text" name="handy" value="${rd.customer.handy}"/><br>
							</td>
						</tr>
						<tr>
							<td colspan="3"><input type="submit" value="Anlegen"/>
							</td>
						</tr>
						</table>
						</form>
						<br>
						<br>
					</div>
					<h3><a href="#">Kundenliste</a></h3>
					<div>			
						<table id="customerListTable" class="tablesorter">
							<thead>
								<tr>
								<th align="center">Kunden-ID <span title="Klicken Sie auf einen der Spaltentitel um zu sortieren!"; class="ui-icon ui-icon-info" style="float:right;"></span>
								</th>
								<th align="center">Vorname
								</th>
								<th align="center">Nachname
								</th>
								<th align="center">Email
								</th>
								</tr>
							</thead>
							<tbody>
						<c:forEach items="${rd.customers}" var="customer">
							<tr>
								<td>
									<c:out value="${customer.customerId}" />
								</td>
								<td>
									<c:out value="${customer.firstName}" />
								</td>
								<td>
									<c:out value="${customer.lastName}" />
								</td>
								<td>
									<c:out value="${customer.email}" />
								</td>
								<td>
									<button name="customerInfo" id="customerInfo" value="${customer.customerId}" title="Kundendaten bearbeiten"><span class="ui-icon ui-icon-pencil"></span></button>
								</td>
							</tr>
						</c:forEach>
						</tbody>
						</table>
					</div>
				</div>
		</div>
		<div id="tabs-8">
			<div>Test	dsafasdflkjasd öfalöksd
			asdfo ajsdföjasd
			fa ösdofkja sdf	
			</div>
		</div>
		<div id="tabs-7">
				<jsp:include page="statisticsBooking.jsp" />
		</div>
		
	</div>
	</authz:authorize>

	<input type="hidden" id="customerParameter" name="customerParameter"/>
	<input type="hidden" id="tabNumber" name="tabNumber" value="${rd.tabNumber}"/>
	<div id="customerDialog" title="Kundendaten bearbeiten">	
	</div>
</div>
</body>
</html>