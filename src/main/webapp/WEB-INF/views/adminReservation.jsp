<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
<link type="text/css" href="${contextPath}/resources/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />
<script src="${contextPath}/resources/js/jquery-1.8.2.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.min.js"></script>
<script src="${contextPath}/resources/js/jquery.tablesorter.js"></script>
<script>
var dayDisplay = false;
var selectedCourts= new Array();
$(document).ready(function() {
	initBindings();
});
$(function() {
	
	$( "#contextmenu" ).menu();
	
	$.ajaxSetup ({  
        cache: false  
    });
	$("#dateselector").datepicker({
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		dateFormat: 'yy-mm-dd',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
		onSelect: function(dateText, inst) {
			reloadDisplay();		
		}
	});
});
function loadXMLDoc(url, dialog)
{
	var xmlhttp;
	var data = "";
	if(url=="adminConfirmReservation.htm"){
		var allTimes= new Array();
		var j = 0;
			for(var i=0; i < document.reservationform.reservationStartTime.length; i++)
			{
				if(document.reservationform.reservationStartTime[i].checked)
					{
						allTimes[j] =document.reservationform.reservationStartTime[i].value;
						//nachdem die ausgewählte Stunde hinzugefügt worden ist, kann die Checkbox wieder gelöscht werden, damit sie in der Anzeige nicht mehr als gecheckt angezeigt wird.
						document.reservationform.reservationStartTime[i].checked = false;
						j = j+1;
					}
			}
		var data ="reservationStartTimes="+allTimes+"&selectedCourt="+$('#selectedCourt').val()+"&startdate="+$('#startdate').val()+"&username="+$('#username').val();
		if(url=="adminConfirmReservation.htm" && j==0)
		{
			document.getElementById(dialog).innerHTML="Sie haben keine Stunde zur Reservierung ausgewählt!";
			$("#reservationconfirmationdialog").dialog("option", "buttons", {
				  "Schliessen": function() { 
					  $(this).dialog("close"); 
					  }
				});
			return true;
		}
	}
	if(url=="adminConfirmReservationCourts.htm"){
		var selectedCourtandTimes= new Array();
		var j = 0;
		$('input:checkbox:checked.courtTime').each(function() {
		       selectedCourtandTimes[j] = $(this).val();
		       j++;
		  });
		var data ="CourtandTimes="+selectedCourtandTimes+"&startdate="+$('#startdate').val()+"&username="+$('#username').val();
		if(url=="adminConfirmReservationCourts.htm" && j==0)
		{
			document.getElementById(dialog).innerHTML="Sie haben keine Stunde zur Reservierung ausgewählt!";
			$("#reservationconfirmationdialog").dialog("option", "buttons", {
				  "Schliessen": function() { 
					  $(this).dialog("close"); 
					  }
				});
			return true;
		}
	}
	if(url=="adminDeleteReservation.htm")
	{	
		var data ="id="+$('#deleteparameter').val()+"&court="+$('#selectedCourt').val();
		$("#deletedialog").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
	}
	if(url=="adminDeleteReservationDayView.htm")
	{
		var data ="id="+$('#deleteparameter').val()+"&date="+$('#startdate').val();
		$("#deletedialog").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
	}
	if(url=="adminReservationDone.htm" || url=="adminReservationDayViewDone.htm")
	{
		data ="resName=";
		$('[id^="resName_"]').each(function(){
			if (!($(this).val())){
				data = data +"leer"+"#";
			} else {
				data = data + $(this).val()+"#";
			}
		});
		if(!($('#changedCustomer').val())){
			data = data+"&changedCustomer=0";
		}else{
			data = data+"&changedCustomer="+$('#changedCustomer').val();
		}
		data = data+"&reservationType="+$('#reservationTypeSection input:checked').val()+"&comment="+$('#comment').val();
		$("#reservationconfirmationdialog").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
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
			if(url=="adminReservationDone.htm" || url=="adminReservationDayViewDone.htm"){
				$("#reservationconfirmationdialog").dialog("option", "buttons", {
					  "Schliessen": function() { 							 
						  reloadDisplay();
						  $(this).dialog("close"); 
					  }
				});
			}
			if(url=="adminDeleteReservation.htm" || url=="adminDeleteReservationDayView.htm"){
				$("#deletedialog").dialog("option", "buttons", {
					"Schliessen": function() {
						reloadDisplay();
						$(this).dialog("close"); 
					}
				});
			}
	   	}
	};
	xmlhttp.open("POST",url,true);
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-length", data.length);
	xmlhttp.setRequestHeader("Connection", "close");
	xmlhttp.send(data);	
}
function loadRegistrationXMLDoc(url, dialog)
{
	var xmlhttp;
	var data = "";
	if(url=="registrationDone.htm")
	{
		data ="firstname="+$("#firstname").val()+"&lastname="+$("#lastname").val()+"&email="+$("#email").val()+"&password="+$("#password").val()+"&username="+$("#username").val()+"&isMember="+$("#isMember").val();
		$('#registrationmenu').empty().html("<table width='100%' height='100%'  valign='middle'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /><br>Bitte warten...</td></tr></table>");
	}
	if(url=="sendPasswordDone.htm")
	{
		data ="pwdFirstName="+$("#pwdFirstName").val()+"&pwdLastName="+$("#pwdLastName").val()+"&pwdEmail="+$("#pwdEmail").val();
		$('#forgotpasswordmenu').empty().html("<table width='100%' height='100%'  valign='middle'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /><br>Bitte warten...</td></tr></table>");
	}
	if(url=="passwordForm.htm"){
		$('#forgotpasswordmenu').empty().html("<table width='100%' height='100%'  valign='middle'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /><br>Bitte warten...</td></tr></table>");
	}
	if(url=="registrationForm.htm" ){
		$('#registrationmenu').empty().html("<table width='100%' height='100%'  valign='middle'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /><br>Bitte warten...</td></tr></table>");
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
			initBindings();
	    }
	};
	xmlhttp.open("POST",url,true);
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xmlhttp.setRequestHeader("Content-length", data.length);
	xmlhttp.setRequestHeader("Connection", "close");
	xmlhttp.send(data);
}
function initBindings(){	
	$("#deletedialog").dialog({
		autoOpen: false,
		resizable: false,
		show: "blind",
		position:"absolute",
		width: 400,
		height: 200,
		top: '50%',
		left: '50%',
		modal: true,
		buttons: {
			'Ok': function() { 
				if(!dayDisplay){
					loadXMLDoc("adminDeleteReservation.htm","deletedialog");
				} else {
					loadXMLDoc("adminDeleteReservationDayView.htm","deletedialog");
				}
			}, 
			"Abbrechen": function() {
				reloadDisplay();
				$(this).dialog("close"); 
			} 
		}
	});
	$('#submitbutton[name=submitbutton]').live("click", function(event){
		$('#customerParameter').val($(this).val());
		var customer = $('#customerParameter').val();
		$("#reservationconfirmationdialog").dialog("option", "buttons", {
			'Bestellung abschliessen': function() { 
				if (dayDisplay){
					loadXMLDoc("adminReservationDayViewDone.htm","reservationconfirmationdialog");
				}else{
					loadXMLDoc("adminReservationDone.htm","reservationconfirmationdialog");
				}
			}, 
			"Abbrechen": function() { 
				reloadDisplay();
				$(this).dialog("close"); 
			} 
		});
			if (dayDisplay){
				loadXMLDoc("adminConfirmReservationCourts.htm", "reservationconfirmationdialog");
			}else{
				loadXMLDoc("adminConfirmReservation.htm", "reservationconfirmationdialog");
			}
			$('#reservationconfirmationdialog').dialog('open');
		return false;
	});
	$('#deletebutton').live("click",function(){
		$('#contextmenucontainer').stop(true,true).slideUp(600,"easeOutExpo");
		$("#deletedialog").html("<p>Wollen Sie die ausgewählte Einzelstundenreservierung wirklich löschen?</p>");
		$("#deletedialog").dialog("option", "buttons", {
			'Ok': function() { 
				if(!dayDisplay){
					loadXMLDoc("adminDeleteReservation.htm","deletedialog");
				} else {
					loadXMLDoc("adminDeleteReservationDayView.htm","deletedialog");
				}
			}, 
			"Abbrechen": function() {
				reloadDisplay();
				$(this).dialog("close"); 
			}
		});
		$("#deletedialog").dialog('open');
		return false;
	});
	$('#paybutton').live("click",function(){
		$('#contextmenucontainer').stop(true,true).slideUp(600,"easeOutExpo");
		if(dayDisplay){
			if($("#paybutton").text()=='Als nicht bezahlt markieren'){
				$.ajax({
					  url: 'adminSetPaymentDayViewDone.htm',
					  data: "resid="+$('#deleteparameter').val()+"&date="+$('#startdate').val()+"&value=FALSE",
					  success: function() {
						  reloadDisplay();
					  }
					});
			} else{
				$.ajax({
					  url: 'adminSetPaymentDayViewDone.htm',
					  data: "resid="+$('#deleteparameter').val()+"&date="+$('#startdate').val()+"&value=TRUE",
					  success: function() {
						  reloadDisplay();
					  }
					});	
			}
		}else{
			if($("#paybutton").text()=='Als nicht bezahlt markieren'){
				$.ajax({
					  url: 'adminSetPaymentDone.htm',
					  data: "resid="+$('#deleteparameter').val()+"&value=FALSE",
					  success: function() {
						  reloadDisplay();
					  }
					});
			} else {
				$.ajax({
					  url: 'adminSetPaymentDone.htm',
					  data: "resid="+$('#deleteparameter').val()+"&value=TRUE",
					  success: function() {
						  reloadDisplay();
					  }
				});	
			}
		}	
	});
	$('#opener[name=add]').live("click",function(){	
		$('#deleteparameter').val($(this).val());
		var buttonparentposition = $(this).parent().position();
		if($(this).parent().attr('class')=='paymentDone'){
			$("#paybutton").text("Als nicht bezahlt markieren");
		} else {
			$("#paybutton").text("Als bezahlt markieren");
		}
		$("#contextmenucontainer").css("left", buttonparentposition.left+295);
		$("#contextmenucontainer").css("top", buttonparentposition.top);
		$("#contextmenucontainer").width(170);
		$('#contextmenucontainer').stop(true,true).slideDown(600,"easeOutExpo");		
		return false;
	});
	$( "#reservationconfirmationdialog").dialog({
		autoOpen: false,
		resizable: false,
		show: "blind",
		position:"absolute",
		width: 400,
		height: 400,
		top: '50%',
		left: '50%',
		modal: true,
		buttons: {
			'Bestellung abschliessen': function() { 
				if (dayDisplay){
					loadXMLDoc("adminReservationDayViewDone.htm","reservationconfirmationdialog");
				}else{
					loadXMLDoc("adminReservationDone.htm","reservationconfirmationdialog");
				}
			}, 
			"Abbrechen": function() { 
				reloadDisplay();
				$(this).dialog("close"); 
			} 
		}
	});
	
	$('#pagebuttonleft').live("click",function(event) { 
		if(!dayDisplay){
			var newDate = new Date($("#dateselector").datepicker("getDate"));
			newDate.setDate(newDate.getDate()-7);
			$("#dateselector").datepicker("setDate", newDate);
			$('#base').hide('slide', {direction: 'left'}, 500);
			var ajax_load = ""; 
			$("#base")  
	        .load("adminReservationView.htm", "startdate="+$('#dateselector').datepicker({ dateFormat: 'yy-mm-dd' }).val()+"&court=Halle", function(responseText){  
	        	
	    		$('#base').show('slide', {direction: 'right'}, 500); 
	        });
		}else{
			var newDate = new Date($("#dateselector").datepicker("getDate"));
			newDate.setDate(newDate.getDate()-1);
			$("#dateselector").datepicker("setDate", newDate);
			$('#base').hide('slide', {direction: 'left'}, 500);
			var ajax_load = ""; 
			if(selectedCourts.length<1){ //load reservationDayView with ALL bookable courts, when no court is selected, e.g. last court was deselected
				$("#base")  
		       .load("reservationDayView.htm", "startdate="+$('#dateselector').datepicker({ dateFormat: 'yy-mm-dd' }).val(), function(responseText){  
		       	$('#base').show('blind', {direction: 'right'}, 500); 
		       });
			}else{//load reservationDayView with selected courts
				$("#base")  
		        .load("reservationDayView.htm", "startdate="+$('#dateselector').datepicker({ dateFormat: 'yy-mm-dd' }).val()+"&selectedCourts="+selectedCourts, function(responseText){  
		        	$('#base').show('blind', {direction: 'right'}, 500); 
		        });
			}
		}
	});
	
	$('#pagebuttonright').live("click",function() { 
		if(!dayDisplay){
			var newDate = new Date($("#dateselector").datepicker("getDate"));
			newDate.setDate(newDate.getDate()+7);
			$("#dateselector").datepicker("setDate", newDate);
			$('#base').hide('slide', {direction: 'left'}, 500);
			var ajax_load = ""; 
			$("#base") 
	        .load("adminReservationView.htm", "startdate="+$('#dateselector').datepicker({ dateFormat: 'yy-mm-dd' }).val()+"&court=Halle", function(responseText){  
	        	
	    		$('#base').show('slide', {direction: 'right'}, 500); 
	        }); 
		}else{
			var newDate = new Date($("#dateselector").datepicker("getDate"));
			newDate.setDate(newDate.getDate()+1);
			$("#dateselector").datepicker("setDate", newDate);
			$('#base').hide('slide', {direction: 'left'}, 500);
			var ajax_load = ""; 
			if(selectedCourts.length<1){ //load reservationDayView with ALL bookable courts, when no court is selected, e.g. last court was deselected
				$("#base")  
		       .load("adminReservationDayView.htm", "startdate="+$('#dateselector').datepicker({ dateFormat: 'yy-mm-dd' }).val(), function(responseText){  
		       	$('#base').show('blind', {direction: 'right'}, 500); 
		       });
			}else{//load reservationDayView with selected courts
				$("#base")  
		        .load("adminReservationDayView.htm", "startdate="+$('#dateselector').datepicker({ dateFormat: 'yy-mm-dd' }).val()+"&selectedCourts="+selectedCourts, function(responseText){  
		        	$('#base').show('blind', {direction: 'right'}, 500); 
		        });
			}
		}
	});
	$('#weekView').live("click",function() { 
		dayDisplay = false;	
		$.getScript("${contextPath}/resources/css/style.css", function() {
			$("#scroller") 
			.html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>")
	        .load("courtMenu.htm", function(responseText){  
	        });
		});
		reloadDisplay();		
	});
	$('#dayView').live("click",function() { 
		dayDisplay = true;
		$.getScript("${contextPath}/resources/css/style.css", function() {
			$("#scroller")
			.html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>")
	        .load("courtMenu.htm", function(responseText){  
	        });
		});
		reloadDisplay();
	});
	$(".courtButton").live("click",function() { 
		selectedCourts= new Array();
		var i = 0;
		if(dayDisplay){
			$('input:checkbox:checked.courtButton').each(function () {
			       selectedCourts[i] = $(this).val();
			       i++;
			  });
		} else{
			$(":checkbox:checked.courtButton").not(this).removeAttr("checked");
		    selectedCourts[0] = $(this).val();	
		}
		reloadDisplay();
	});
	$("#courtSubtitle").live("click", function(event) {
	    event.preventDefault();
	    $("#scroller").animate({
	        scrollTop: "-=" + 150 + "px"
	    });
	});
	$("#courtFoot").live("click", function(event) {
	    event.preventDefault();
	    $("#scroller").animate({
	        scrollTop: "+=" + 150 + "px"
	    });
	});	
	$( ".button", ".menu" ).button();
	$( "a", ".button" ).click(function() { return false; });	
	$( "#viewSelect" ).buttonset();
	$( ".courtButton" ).button();
	$( "#pagebuttonleft" ).button();
	$( "#pagebuttonright" ).button();
	$('#submitbutton[name=submitbutton]').button();

	$(document).mouseup(function (e){
	    var container = $("#contextmenucontainer");
	    if (container.has(e.target).length === 0)
	    {
	        container.hide();
	    }
	});
}
function reloadDisplay(){
	if(!dayDisplay){
		if(selectedCourts[0] == undefined){
			selectedCourts[0]="Halle";
		}
		$("#base")  
        .load("adminReservationView.htm", "startdate="+$('#dateselector').datepicker({ dateFormat: 'yy-mm-dd' }).val()+"&court="+selectedCourts[0], function(responseText){  
        	$('#base').show('blind', {direction: 'right'}, 500); 
        }); 	
	}else{
		if(selectedCourts.length<1){ //load reservationDayView with ALL bookable courts, when no court is selected, e.g. last court was deselected
			$("#base")  
	       .load("adminReservationDayView.htm", "startdate="+$('#dateselector').datepicker({ dateFormat: 'yy-mm-dd' }).val(), function(responseText){  
	       	$('#base').show('blind', {direction: 'right'}, 500); 
	       });
		}else{//load reservationDayView with selected courts
			
			$("#base")  
	        .load("adminReservationDayView.htm", "startdate="+$('#dateselector').datepicker({ dateFormat: 'yy-mm-dd' }).val()+"&selectedCourts="+selectedCourts, function(responseText){  
	        	$('#base').show('blind', {direction: 'right'}, 500); 
	        });
		}
	}
}

</script>

<style type="text/css">
	.ui-dialog {
		font-size: 12.0px;
	}
	.ui-datepicker {
		font-size: 11.4px;
		width: 184px;
	}
	.ui-widget {                
		font-size: 10px !important;          
	}
	#feedback { font-size: 0.5em; }
    #selectable .ui-selecting { background: #FECA40; }
    #selectable .ui-selected { background: #F39814; color: white; }
    #selectable { list-style-type: none; margin: 0; padding: 0; width: 190px; }
    #selectable li { margin: 0px; padding: 0px; float: left; width: 50px; height: 20px; font-size: 0.7em; text-align: center; }
</style>

<authz:authorize ifAnyGranted="ROLE_ADMIN">
<div class="menu" id="menu">
	<div id="dateTitle">Datum
	</div>
	<div id ="turnpage">
		<div id = "pagebuttonleft">
			<span id = "buttonleft" class="ui-icon ui-icon-triangle-1-w"></span>
		</div>
		<div id = "pagebuttonright">
			<span id = "buttonright" class="ui-icon ui-icon-triangle-1-e"></span>
		</div>
	</div>
	<div id="dateselector">
	</div>
	<div id="viewTitle">Ansicht
	</div>
	<div id="viewSelect">
	    <input type="radio" id="weekView" name="radio" checked="checked" /><label for="weekView" style="width:92px;">Wochenansicht</label>
	    <input type="radio" id="dayView" name="radio" /><label for="dayView" style="width:92px;">Tagesansicht</label>
	</div>
	<c:if test="${fn:length(rd.courts) le 1}">
		<div id="viewFoot">
		</div>
	</c:if>
	<c:if test="${fn:length(rd.courts) gt 1}">
		<div id="courtTitle">Platzwahl
		</div>
		<div id="courtSubtitle">
			
			<span id = "scrollCourtsUpButton" class="ui-icon ui-icon-triangle-1-n" style="position:absolute; left: 50%;"></span>
			
		</div>
		<div id = "courtMenu">
			<div id="scroller">
				<c:forEach items="${rd.courts}" var="courtList">
						<input type="checkbox" id="${courtList}" value="${courtList}" class="courtButton" /><label for="${courtList}" style="width:188px;"><c:out value="${courtList}"/></label><br>
				</c:forEach>
			</div>
		</div>	
		<div id="courtFoot">
			
			<span id = "scrollCourtsDownButton" class="ui-icon ui-icon-triangle-1-s" style="position:absolute; left: 50%;"></span>
			
		</div>
	</c:if>
	<div id="legend">
		<table>
			<tr>
				<td align="left">Legende:
				</td>
			</tr>
			<tr>
				<td class="notreserved-color" height="10px;" align="center" style="border-style:solid;border-width:1px;border-color:white;font-size:10px;height:10px;">frei
				</td>
			</tr>
			<tr>
				<td class="paymentDone" height=10 align=center style="border-style:solid;border-width:1px;font-size:10px;height:10px;">Bezahlt
				</td>
			</tr>
			<tr>
				<td class="paymentNotDone" height=10 align=center style="border-style:solid;border-width:1px;font-size:10px;height:10px;">Nicht bezahlt
				</td>
			</tr>
			<tr>
				<td colspan='2' height=10 align=center><br>&nbsp;
				</td>
			</tr>
		</table>
	</div>		
</div>
<div id = "content">
<table>
<tr>
<td>
	<div id ="top">
		<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
			<authz:authorize ifAnyGranted="ROLE_ADMIN"><input type="submit" id="submitbutton" name="submitbutton" value="Ausgewählte Stunden reservieren" /></authz:authorize>				
			<!--<authz:authorize ifAnyGranted="ROLE_CUSTOMER"><input type="submit" value="Ausgewählte Stunden reservieren" onClick="javascript: confirmReservation();"/></authz:authorize>-->
		</c:if>
	</div>
</td>
</tr>
<tr>
<td>
	<div id="base">	
	<form id="reservationform" name="reservationform">
		<div class="day">
			<div class="not-selected-day">
				<c:out value="${rd.selectedCourt}" />
			</div>
			<c:forEach items="${rd.toTimes}" var="toTimes">
				<div class="times">
					<div style="position:absolute; top: 25%">${toTimes.key}
					</div>
				</div>
			</c:forEach>
		</div>
		<c:forEach items="${rd.reservationsOfDay}" var="days">
			<div class="day">
				<c:if test="${rd.startdateX == days.key}">
					<div class="selected-day-label">
						<fmt:formatDate type="date" value="${days.key}" pattern="dd.MM.yyyy" dateStyle="short" />
					</div>
				</c:if>
				<c:if test="${rd.startdateX != days.key}">
					<div class="not-selected-day-label">
						<fmt:formatDate type="date" value="${days.key}" pattern="dd.MM.yyyy" dateStyle="short" />
					</div>
				</c:if>
				<c:forEach items="${days.value}" var="times">					
						<c:if test="${times.value.bookingType == '1'}">
								<div class="paymentDone">
										<authz:authorize ifAnyGranted="ROLE_ADMIN">
											<c:if test="${times.value.reservationDisplayName != 'leer'}">
												<div class="reservationtext" style="float:left;">
													<c:out value="${times.value.reservationDisplayName}"/>
												</div>
											</c:if>
											<button name="add" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-newwin"></span>
											</button>
										</authz:authorize>
									</div>
							</c:if>
						<c:if test="${times.value.bookingType == '2'}">
									<div class="paymentNotDone">
										<authz:authorize ifAnyGranted="ROLE_ADMIN">
											<c:if test="${times.value.reservationDisplayName != 'leer'}">
												<div class="reservationtext" style="float:left;">
													<c:out value="${times.value.reservationDisplayName}"/>
												</div>
											</c:if>
											<button name="add" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-newwin"></span>
											</button>
										</authz:authorize>
								</div>
							</c:if>
						<c:if test="${times.value.bookingType == '0'}">			
								<div class="notreserved-color">
									<authz:authorize ifAnyGranted="ROLE_ADMIN">
										<input type="checkbox" id="reservationStartTime" name="reservationStartTime" value="${days.key} ${times.key} 0" title="Stunde zur Reservierung auswählen">
									</authz:authorize>
								</div>
						</c:if>
					</c:forEach>
				</div>	
		</c:forEach>
		
					<div>
						<input type="hidden" name="username" id="username" value="<authz:authentication operation="username" />" />
						<input type="hidden" name="selectedCourt" id="selectedCourt" value="${rd.selectedCourt}" />
						<input type="hidden" name="startdate" id="startdate" value="${rd.startdate}" />
						<input type="hidden" id="deleteparameter" />
					</div>
		</form>
	</div>	
</td>
</tr>
<tr>
<td>     
	<div id="bottom">
		<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
			<authz:authorize ifAnyGranted="ROLE_CUSTOMER,ROLE_ADMIN">
				
					<input type="submit" id="submitbutton" name="submitbutton" value="Ausgewählte Stunden reservieren" />
				
			</authz:authorize>
		</c:if>
	</div>
</td>
</tr>
</table>
</div>
<div id="reservationconfirmationdialog" title="Reservierungsdaten">
</div>
<div id="deletedialog" title="Reservierung Löschen?">
	<p>
		Wollen Sie die ausgewählte Einzelstundenreservierung wirklich löschen?
	</p>
</div>
<div id = "contextmenucontainer" style="display:none;position:absolute;">
	<ul id="contextmenu" >
	    <li>
	    	<a href="#" id="paybutton">Als bezahlt markieren</a>
	    </li>
	    <li>
	        <a href="#" id="deletebutton">Löschen</a>
	    </li>
	</ul>
</div>
</authz:authorize>