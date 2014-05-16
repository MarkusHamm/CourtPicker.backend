<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<script>
var dayDisplay = false;
var selectedCourts= new Array();
$(document).ready(function() {
	initBindings();
});

$(function() {
	$.ajaxSetup ({  
        cache: false  
    });
	
	$( document ).tooltip();
	$( "#contextmenu" ).menu();	
});


	
function loadXMLDoc(url, dialog)
{
	var xmlhttp;
	var data = "";
	if(url=="confirmReservation.htm"){
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
		if(url=="confirmReservation.htm" && j==0)
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
	if(url=="confirmReservationCourts.htm"){
		var selectedCourtandTimes= new Array();
		var j = 0;
		$('input:checkbox:checked.courtTime').each(function() {
		       selectedCourtandTimes[j] = $(this).val();
		       j++;
		  });
		var data ="CourtandTimes="+selectedCourtandTimes+"&startdate="+$('#startdate').val()+"&username="+$('#username').val();
		if(url=="confirmReservationCourts.htm" && j==0)
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
	if(url=="deleteReservation.htm")
	{	
		var data ="id="+$('#deleteparameter').val()+"&court="+$('#selectedCourt').val();
		$("#deletedialog").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
	}
	if(url=="deleteReservationDayView.htm")
	{
		var data ="id="+$('#deleteparameter').val()+"&date="+$('#startdate').val();
		$("#deletedialog").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
	}
	if(url=="reservationDone.htm" || url=="reservationDayViewDone.htm")
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
		data = data+"&reservationType="+$('#reservationTypeSection input:checked').val();
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
			if(url=="reservationDone.htm" || url=="reservationDayViewDone.htm"){
				$("#reservationconfirmationdialog").dialog("option", "buttons", {
					  "Schliessen": function() { 							 
						  reloadDisplay();
						  $(this).dialog("close"); 
					  }
				});
			}
			if(url=="deleteReservation.htm" || url=="deleteReservationDayView.htm"){
				$("#deletedialog").dialog("option", "buttons", {
					"Schliessen": function() {
						reloadDisplay();
						$("#messagebox")  
				        .html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>")
						.load("messagebox.htm",function(){}); 
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
	
	$("#dateselector").datepicker({
		showWeek: false,
		firstDay: 1,
		inline: true,
		changeYear: false,
		changeMonth: false,
		dateFormat: 'dd.mm.yy',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['J�nner','Februar','M�rz','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
		onSelect: function(dateText, inst) {
			reloadDisplay();		
		}
	});
	
	$("#dateselector").datepicker("setDate", new Date());
	
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
					loadXMLDoc("deleteReservation.htm","deletedialog");
				} else {
					loadXMLDoc("deleteReservationDayView.htm","deletedialog");
				}
			}, 
			"Abbrechen": function() {
				reloadDisplay();
				$(this).dialog("close"); 
			} 
		}
	});
	$('#reservationButton').live("click", function(event){
		$('#customerParameter').val($(this).val());
		var customer = $('#customerParameter').val();
		$("#reservationconfirmationdialog").dialog("option", "buttons", {
			'Bestellung abschliessen': function() { 
				if (dayDisplay){
					loadXMLDoc("reservationDayViewDone.htm","reservationconfirmationdialog");
				}else{
					loadXMLDoc("reservationDone.htm","reservationconfirmationdialog");
				}
			}, 
			"Abbrechen": function() { 
				reloadDisplay();
				$(this).dialog("close"); 
			} 
		});
			if (dayDisplay){
				loadXMLDoc("confirmReservationCourts.htm", "reservationconfirmationdialog");
			}else{
				loadXMLDoc("confirmReservation.htm", "reservationconfirmationdialog");
			}
			$('#reservationconfirmationdialog').dialog('open');
		return false;
	});
	
	$('#opener[name=add]').live("click",function(){
		$("#deletedialog").html("<div class=\"ui-widget\"><div class=\"ui-state-highlight ui-corner-all\" style=\"margin-top: 20px; padding: 0 .7em;\"><p><span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span><strong>Hinweis!</strong> Wollen Sie die ausgewählte Einzelstundenreservierung wirklich löschen?<br>Evt. vorhandene Einladungen für diese Stunde werden ebenfalls gelöscht.</p></div></div>");
		$('#deleteparameter').val($(this).val());
		$("#deletedialog").dialog("option", "buttons", {
			'Ok': function() { 
				if(!dayDisplay){
					loadXMLDoc("deleteReservation.htm","deletedialog");
				} else {
					loadXMLDoc("deleteReservationDayView.htm","deletedialog");
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
	$('#opener[name=options]').live("click",function(){	
		$('#contextmenucontainer').children("#contextmenu").children().remove();
		$('#contextmenucontainer').children("#contextmenu").prepend("<li><a href='#' id='deletebutton'>Löschen</a></li><li><a href='#' id='invitebutton'>Spielpartner einladen</a></li><li><a href='#' id='invitationstatusbutton'>Einladungsstatus</a></li>");
		$('#deleteparameter').val($(this).val());
		var buttonparentposition = $(this).parent().position();
		$("#contextmenucontainer").css("left", buttonparentposition.left+295);
		$("#contextmenucontainer").css("top", buttonparentposition.top);
		$("#contextmenucontainer").width(170);
		// check if there is already an invitation for this reservation and adapt context menu accordingly
		$.ajax({
			  url: 'checkIfInvitationExists.htm',
			  data: "resid="+$('#deleteparameter').val()+"&court=Halle",
			  datatype: "html",
			  success: function(response) {
					if(response.indexOf("JA") !== -1){
						$('#contextmenucontainer').children("#contextmenu").children().each(function(i) { 
						    if($(this).find('a:first').attr('id') == "invitebutton"){
						    	$(this).remove();
						    }
						});
					} else {
						$('#contextmenucontainer').children("#contextmenu").children().each(function(i) { 
						    if($(this).find('a:first').attr('id') == "invitationstatusbutton"){
						    	$(this).remove();
						    }
						});
					}
					$('#contextmenucontainer').stop(true,true).slideDown(600,"easeOutExpo");
			  }
		});	
		
		return false;
	});
	$('#opener[name=optionsDayView]').live("click",function(){	
		$('#contextmenucontainer').children("#contextmenu").children().remove();
		$('#contextmenucontainer').children("#contextmenu").prepend("<li><a href='#' id='deletebutton'>Löschen</a></li><li><a href='#' id='invitebutton'>Spielpartner einladen</a></li><li><a href='#' id='invitationstatusbutton'>Einladungsstatus</a></li>");
		$('#deleteparameter').val($(this).val());
		var buttonparentposition = $(this).parent().position();
		$("#contextmenucontainer").css("left", buttonparentposition.left+295);
		$("#contextmenucontainer").css("top", buttonparentposition.top);
		$("#contextmenucontainer").width(170);
		// check if there is already an invitation for this reservation and adapt context menu accordingly
		$.ajax({
			  url: 'checkIfInvitationExistsDayView.htm',
			  data: "resid="+$('#deleteparameter').val()+"&date="+$('#startdate').val(),
			  datatype: "html",
			  success: function(response) {
					if(response.indexOf("JA") !== -1){
						$('#contextmenucontainer').children("#contextmenu").children().each(function(i) { 
						    if($(this).find('a:first').attr('id') == "invitebutton"){
						    	$(this).remove();
						    }
						});
					} else {
						$('#contextmenucontainer').children("#contextmenu").children().each(function(i) { 
						    if($(this).find('a:first').attr('id') == "invitationstatusbutton"){
						    	$(this).remove();
						    }
						});
					}
					$('#contextmenucontainer').stop(true,true).slideDown(600,"easeOutExpo");
			  }
		});	
		
		return false;
	});
	$('#invitation[name=invitation]').live("click",function(){	
		$('#contextmenucontainer').children("#contextmenu").children().remove();
		$('#contextmenucontainer').children("#contextmenu").prepend("<li><a href='#' id='invitationstatusbutton'>Einladungsstatus ändern</a></li>");
		$('#deleteparameter').val($(this).val());
		var buttonparentposition = $(this).parent().position();
		$("#contextmenucontainer").css("left", buttonparentposition.left+295);
		$("#contextmenucontainer").css("top", buttonparentposition.top);
		$("#contextmenucontainer").width(170);
		$('#contextmenucontainer').stop(true,true).slideDown(600,"easeOutExpo");
		return false;
	});
	$('#deletebutton').live("click",function(){
		$('#contextmenucontainer').stop(true,true).slideUp(600,"easeOutExpo");
		$("#deletedialog").html("<div class=\"ui-widget\"><div class=\"ui-state-highlight ui-corner-all\" style=\"margin-top: 20px; padding: 0 .7em;\"><p><span class=\"ui-icon ui-icon-info\" style=\"float: left; margin-right: .3em;\"></span><strong>Hinweis!</strong> Wollen Sie die ausgewählte Einzelstundenreservierung wirklich löschen?<br>Evt. vorhandene Einladungen für diese Stunde werden ebenfalls gelöscht.</p></div></div>");
		$("#deletedialog").dialog("option", "buttons", {
			'Ok': function() { 
				if(!dayDisplay){
					loadXMLDoc("deleteReservation.htm","deletedialog");
				} else {
					loadXMLDoc("deleteReservationDayView.htm","deletedialog");
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
	$('#invitebutton').live("click",function(){
		$('#contextmenucontainer').stop(true,true).slideUp(600,"easeOutExpo");
		$("#invitationCustomerScroller")  
	        .load("invitationCustomerList.htm", function(responseText){  
	        });
		$("#invitationdialog").dialog("option", "buttons", {
			'Ok': function() { 
				var selectedCustomers= new Array();
				var i = 0;
				$('input:checkbox:checked.customerList').each(function () {
					selectedCustomers[i] = $(this).val();
					i++;
				});
				$.ajax({
					  url: 'processInvitation.htm',
					  data: "resid="+$('#deleteparameter').val()+"&customerList="+selectedCustomers+"&limit="+$('#invitationSlots').val()+"&singleInvitation=TRUE"+"&aboInvitation=FALSE"+"&court=Halle",
					  success: function() {
						  reloadDisplay();
							$("#messagebox")  
					        .html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>")
							.load("messagebox.htm",function(){});   	
					  }
				});
				$(this).dialog("close");
			}, 
			"Abbrechen": function() {
				reloadDisplay();
				$(this).dialog("close"); 
			}
		});
		$("#invitationdialog").dialog('open');
		return false;
	});
	$('#invitationstatusbutton').live("click",function(){
		$('#contextmenucontainer').stop(true,true).slideUp(600,"easeOutExpo");
		$("#invitationCustomerScroller")  
        .load("invitationCustomerList.htm", function(responseText){  
        });
		$("#inviteeList")  
        .load("invitationInviteeList.htm", "resid="+$('#deleteparameter').val()+"&court=Halle", function(responseText){  
        });
		
		$("#invitationstatusdialog").dialog("option", "buttons", {
			'Ok': function() { 
				//alert($('#acceptInvitation').val());
				//alert($('#acceptInvitation').attr("checked"));
				$.ajax({
					  url: 'acceptInvitation.htm',
					  data: "inviteeId="+$('#acceptInvitation').val()+"&checked="+$('#acceptInvitation').attr("checked"),
					  success: function() {
						  reloadDisplay();
					  }
				});
				$(this).dialog("close");
			}, 
			"Abbrechen": function() {
				reloadDisplay();
				$(this).dialog("close"); 
			}
		});
		$("#invitationstatusdialog").dialog('open');
		return false;
	});
	$( "#invitationdialog").dialog({
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
			'OK': function() { 
			}, 
			"Abbrechen": function() { 
				reloadDisplay();
				$(this).dialog("close"); 
			} 
		}
	});
	$( "#invitationstatusdialog").dialog({
		autoOpen: false,
		resizable: false,
		show: "blind",
		position:"absolute",
		width: 400,
		height: 'auto',
		top: '50%',
		left: '50%',
		modal: true,
		buttons: {
			'OK': function() { 
			}, 
			"Abbrechen": function() { 
				reloadDisplay();
				$(this).dialog("close"); 
			} 
		}
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
					loadXMLDoc("reservationDayViewDone.htm","reservationconfirmationdialog");
				}else{
					loadXMLDoc("reservationDone.htm","reservationconfirmationdialog");
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
	        .load("reservationView.htm", "startdate="+getFormattedDatepickerDate()+"&court=Halle", function(responseText){  
	        	
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
		       .load("reservationDayView.htm", "startdate="+getFormattedDatepickerDate(), function(responseText){  
		       	$('#base').show('blind', {direction: 'right'}, 500); 
		       });
			}else{//load reservationDayView with selected courts
				$("#base")  
		        .load("reservationDayView.htm", "startdate="+getFormattedDatepickerDate()+"&selectedCourts="+selectedCourts, function(responseText){  
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
	        .load("reservationView.htm", "startdate="+getFormattedDatepickerDate()+"&court=Halle", function(responseText){  
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
		       .load("reservationDayView.htm", "startdate="+getFormattedDatepickerDate(), function(responseText){  
		       	$('#base').show('blind', {direction: 'right'}, 500); 
		       });
			}else{//load reservationDayView with selected courts
				$("#base")  
		        .load("reservationDayView.htm", "startdate="+getFormattedDatepickerDate()+"&selectedCourts="+selectedCourts, function(responseText){  
		        	$('#base').show('blind', {direction: 'right'}, 500); 
		        });
			}
		}
	});
	
	// switch view to weekView
	$('#weekView').live("click",function() { 
		dayDisplay = false;	
/*		$.getScript("${contextPath}/resources/css/style.css", function() {
			$("#scroller") 
			.html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>")
	        .load("courtMenu.htm", function(responseText){  
	        });
		});*/
		hideViewCourtSelection()
		reloadDisplay();		
	});
	
	// switch view to dayView
	$('#dayView').live("click",function() { 
		dayDisplay = true;
/*		$.getScript("${contextPath}/resources/css/style.css", function() {
			$("#scroller")
			.html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>")
	        .load("courtMenu.htm", function(responseText){  
	        });
		});*/
		showViewCourtSelection();
		reloadDisplay();
	});
	
	// update selectedCourts and refresh display if any courtCheckbox is clicked
	$(".courtCheckbox").live("click",function() { 
// 		selectedCourts= new Array();
// 		var i = 0;
// 		/*if(dayDisplay){*/
// 			$('input:checkbox:checked.courtCheckbox').each(function () {
// 			       selectedCourts[i] = $(this).val();
// 			       i++;
// 			  });
// 		/*} else{
// 			$(":checkbox:checked.courtCheckbox").not(this).removeAttr("checked");
// 		    selectedCourts[0] = $(this).val();	
// 		}*/
		
		updateSelectedCourts();
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
	
	$( "#reservationViewSelection" ).buttonset();
	$("#reservationCourtSelect").buttonset();
	
	$( ".courtButton" ).button();
	//$( "#pagebuttonleft" ).button();
	//$( "#pagebuttonright" ).button();
	//$('#submitbutton[name=submitbutton]').button();
	
	$(document).mouseup(function (e){
	    var container = $("#contextmenucontainer");
	    if (container.has(e.target).length === 0)
	    {
	        container.hide();
	    }
	});
	
	$(document).on("change", ".bookableHour", function() {
		updateReservationButtonVisibility();
	});

}

function updateReservationButtonVisibility() {
	var selectedHours = $('.bookableHour:checked').length;
	
	if (selectedHours > 0) {
		showReservationButton();
	}
	else {
		hideReservationButton();
	}
}

function showReservationButton() {
	if ($("#reservationButton").css("display") == "none") {
		$("#reservationButton").toggle("blind");
	}		
}

function hideReservationButton() {
	if ($("#reservationButton").css("display") != "none") {
		$("#reservationButton").toggle("blind");
	}		
}

function showViewCourtSelection() {
	if ($("#reservationCourtSelect").css("display") == "none") {
		$("#reservationCourtSelect").toggle("blind");
	}
}

function hideViewCourtSelection() {
	if ($("#reservationCourtSelect").css("display") == "block") {
		$("#reservationCourtSelect").toggle("blind");
	}
}

function updateSelectedCourts() {
	selectedCourts= new Array();
	var i = 0;
	/*if(dayDisplay){*/
		$('input:checkbox:checked.courtCheckbox').each(function () {
		       selectedCourts[i] = $(this).val();
		       i++;
		  });
	/*} else{
		$(":checkbox:checked.courtCheckbox").not(this).removeAttr("checked");
	    selectedCourts[0] = $(this).val();	
	}*/
}

function getFormattedDatepickerDate() {
	var date = $('#dateselector').datepicker("getDate");
	return $.datepicker.formatDate("yy-mm-dd", date);
}

function reloadDisplay(){
	if(!dayDisplay){
		if(selectedCourts[0] == undefined){
			selectedCourts[0]="Halle";
		}
		$("#base")  
        .load("reservationView.htm", "startdate="+getFormattedDatepickerDate()+"&court="+selectedCourts[0], function(responseText){  
        	$('#base').show('blind', {direction: 'right'}, 500);
        }); 
	}else{
		updateSelectedCourts();
		
		if(selectedCourts.length<1){ //load reservationDayView with ALL bookable courts, when no court is selected, e.g. last court was deselected
			$("#base")  
	       .load("reservationDayView.htm", "startdate="+getFormattedDatepickerDate(), function(responseText){  
	       		$('#base').show('blind', {direction: 'right'}, 500);
	       });
		}else{//load reservationDayView with selected courts
			
			$("#base")  
	        .load("reservationDayView.htm", "startdate="+getFormattedDatepickerDate()+"&selectedCourts="+selectedCourts, function(responseText){  
	        	$('#base').show('blind', {direction: 'right'}, 500);
	        });
		}
	}
}

</script>

<style type="text/css">
/*
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
    */
	#feedback { font-size: 0.5em; }
    #selectable .ui-selecting { background: #FECA40; }
    #selectable .ui-selected { background: #F39814; color: white; }
    #selectable { list-style-type: none; margin: 0; padding: 0; width: 190px; }
    #selectable li { margin: 0px; padding: 0px; float: left; width: 50px; height: 20px; font-size: 0.7em; text-align: center; }
</style>

<div id="courtTypeSelect">
    <ul>
        <li id="courtType1" class="selectedCourtType">Tennis Halle</li>
        <li id="courtType2">Tennis Outdoor</li>
        <li id="courtType3">Fu�ball</li>
        <li id="courtType4">Squash</li>
    </ul>
</div>

<div id="paddedContent">

<c:if test="${rd.loginError == '0'}">

<!-- <div id="reservationTopMenu"> -->
<!-- </div> -->

<div id="reservationViewSelection">
    <input type="radio" id="weekView" name="radio" checked="checked"/><label for="weekView" style="margin-left: 50px;" title="In dieser Ansicht sehen Sie, ob auf der Anlage �berhaupt freie Stunden vorhanden sind (egal auf welchem Platz)">Wochen�bersicht</label>
    <input type="radio" id="dayView" name="radio" /><label for="dayView" style="margin-left: 400px;" title="In dieser Ansicht sehen Sie die Belegung einzelner Pl�tze.">Tagesdetail</label>
</div>

<div id="reservationCourtSelect" style="display: none;">
    <div id="reservationCourtSelectCaption">
        Platzwahl:
    </div>
    <div id="reservationCourtSelectCourtList">
        <jsp:include page="courtMenu.jsp" />
    </div>
</div>

<div id="reservationDatePicker">
    <div id="pagebuttonleft" class="button" style="width: 20px; float: left;">&lt;</div>
    <input type="text" id="dateselector" name="date" size="10" />
    <div id="pagebuttonright" class="button" style="width: 20px; float: right;">&gt;</div>
</div>







<!-- <div class="menu" id="menu"> -->

<!-- 	<div id="dateTitle">Datum -->
<!-- 	</div> -->
<!-- 	<div id ="turnpage"> -->
<!-- 		<div id = "pagebuttonleft"> -->
<!-- 			<span id = "buttonleft" class="ui-icon ui-icon-triangle-1-w"></span> -->
<!-- 		</div> -->
<!-- 		<div id = "pagebuttonright"> -->
<!-- 			<span id = "buttonright" class="ui-icon ui-icon-triangle-1-e"></span> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<div id="viewTitle">Ansicht -->
<!-- 	</div> -->
<!-- 	<div id="viewSelect"> -->
<!-- 	    <input type="radio" id="weekView" name="radio" checked="checked" /><label for="weekView" style="width:92px;">Wochenansicht</label> -->
<!-- 	    <input type="radio" id="dayView" name="radio" /><label for="dayView" style="width:92px;">Tagesansicht</label> -->
<!-- 	</div> -->
<%-- 	<c:if test="${fn:length(rd.courts) le 1}"> --%>
<!-- 		<div id="viewFoot"> -->
<!-- 		</div> -->
<%-- 	</c:if> --%>
    
<%-- 	<c:if test="${fn:length(rd.courts) gt 1}"> --%>
<!-- 		<div id="courtTitle">Platzwahl -->
<!-- 		</div> -->
<!-- 		<div id="courtSubtitle"> -->
			
<!-- 			<span id = "scrollCourtsUpButton" class="ui-icon ui-icon-triangle-1-n" style="position:absolute; left: 50%;"></span> -->
			
<!-- 		</div> -->
<!-- 		<div id = "courtMenu"> -->
<!-- 			<div id="scroller"> -->
<%-- 				<c:forEach items="${rd.courts}" var="courtList"> --%>
<%-- 						<input type="checkbox" id="${courtList}" value="${courtList}" class="courtButton" /><label for="${courtList}" style="width:188px;"><c:out value="${courtList}"/></label><br> --%>
<%-- 				</c:forEach> --%>
<!-- 			</div> -->
<!-- 		</div>	 -->
<!-- 		<div id="courtFoot"> -->
			
<!-- 			<span id = "scrollCourtsDownButton" class="ui-icon ui-icon-triangle-1-s" style="position:absolute; left: 50%;"></span> -->
			
<!-- 		</div> -->
<%-- 	</c:if> --%>	
<!-- </div> -->


<div id = "content">
<!-- <table> -->
<!-- <tr> -->
<!-- <td> -->
	<div id="base">
        <jsp:include page="reservationView.jsp" />	
<%-- 	<form id="reservationform" name="reservationform"> --%>
<!-- 		<div class="day"> -->
<!-- 			<div class="not-selected-day"> -->
<%-- 				<c:out value="${rd.selectedCourt}" /> --%>
<!-- 			</div> -->
<%-- 			<c:forEach items="${rd.toTimes}" var="toTimes"> --%>
<!-- 				<div class="times"> -->
<%-- 					<div style="position:absolute; top: 25%">${toTimes.key} --%>
<!-- 					</div> -->
<!-- 				</div> -->
<%-- 			</c:forEach> --%>
<!-- 		</div> -->
<%-- 		<c:forEach items="${rd.reservationsOfDay}" var="days"> --%>
<!-- 			<div class="day"> -->
<%-- 				<c:if test="${rd.startdateX == days.key}"> --%>
<!-- 					<div class="selected-day-label"> -->
<%-- 						<fmt:formatDate type="date" value="${days.key}" pattern="dd.MM.yyyy" dateStyle="short" /> --%>
<!-- 					</div> -->
<%-- 				</c:if> --%>
<%-- 				<c:if test="${rd.startdateX != days.key}"> --%>
<!-- 					<div class="not-selected-day-label"> -->
<%-- 						<fmt:formatDate type="date" value="${days.key}" pattern="dd.MM.yyyy" dateStyle="short" /> --%>
<!-- 					</div> -->
<%-- 				</c:if> --%>
<%-- 				<c:forEach items="${days.value}" var="times">					 --%>
<%-- 									<c:if test="${times.value.bookingType == '3'}"> --%>
<!-- 											<div class="reserved-by-me-color"> -->
<%-- 													<authz:authorize ifNotGranted="ROLE_CUSTOMER"> --%>
<%-- 														<c:if test="${times.value.reservationDisplayName != 'leer'}"> --%>
<!-- 															<div class="reservationtext"> -->
<%-- 																<c:out value="${times.value.reservationDisplayName}"/> --%>
<!-- 															</div> -->
<%-- 														</c:if> --%>
<%-- 													</authz:authorize> --%>
<%-- 													<authz:authorize ifAnyGranted="ROLE_CUSTOMER"> --%>
<%-- 														<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"> --%>
<%-- 															<c:if test="${days.key > rd.currentDate || days.key == rd.currentDate && times.key >= rd.currentTime}"> --%>
<%-- 																<c:if test="${not rd.settings.invitationModuleEnabled}"> --%>
<%-- 																	<button name="add" id="opener" value="${days.key} ${times.key} 1" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span> --%>
<!-- 																	</button> -->
<%-- 																</c:if> --%>
<%-- 																<c:if test="${rd.settings.invitationModuleEnabled}"> --%>
<%-- 																	<button name="options" id="opener" value="${days.key} ${times.key} 1" title="Reservierung bearbeiten"><span class="ui-icon ui-icon-newwin"></span> --%>
<!-- 																	</button> -->
<%-- 																</c:if> --%>
<%-- 															</c:if> --%>
<%-- 														</c:if> --%>
<%-- 													</authz:authorize> --%>
<!-- 												</div> -->
<%-- 										</c:if> --%>
<%-- 									<c:if test="${times.value.bookingType == '2'}"> --%>
											
<!-- 												<div class="my-abo-color"> -->
<%-- 													<authz:authorize ifNotGranted="ROLE_CUSTOMER"> --%>
<%-- 														<c:if test="${times.value.reservationDisplayName != 'leer'}"> --%>
<!-- 															<div class="reservationtext"> -->
<%-- 																<c:out value="${times.value.reservationDisplayName}"/> --%>
<!-- 															</div> -->
<%-- 														</c:if> --%>
<%-- 													</authz:authorize> --%>
<%-- 													<authz:authorize ifAnyGranted="ROLE_CUSTOMER"> --%>
<%-- 														<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"> --%>
<%-- 															<c:if test="${days.key > rd.currentDate || days.key == rd.currentDate && times.key >= rd.currentTime}"> --%>
<%-- 																<c:if test="${not rd.settings.invitationModuleEnabled}"> --%>
<%-- 																	<button name="add" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span> --%>
<!-- 																	</button> -->
<%-- 																</c:if> --%>
<%-- 																<c:if test="${rd.settings.invitationModuleEnabled}"> --%>
<%-- 																	<button name="options" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung bearbeiten"><span class="ui-icon ui-icon-newwin"></span> --%>
<!-- 																	</button> -->
<%-- 																</c:if> --%>
<%-- 															</c:if> --%>
<%-- 														</c:if> --%>
<%-- 													</authz:authorize> --%>
<!-- 											</div> -->
<%-- 										</c:if> --%>
<%-- 									<c:if test="${times.value.bookingType == '1'}"> --%>
<!-- 										<div class="pre-reserved-color"> -->
<!-- 										</div> -->
<%-- 									</c:if> --%>
<%-- 									<c:if test="${times.value.bookingType == '0'}">			 --%>
<!-- 											<div class="notreserved-color"> -->
<%-- 													<authz:authorize ifAnyGranted="ROLE_CUSTOMER"> --%>
<%-- 														<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"> --%>
<%-- 																<c:if test="${days.key > rd.currentDate || days.key == rd.currentDate && times.key >= rd.currentTime}"> --%>
<%-- 																		<input type="checkbox" class="reservationStartTime" id= "reservationStartTime" name="reservationStartTime" value="${days.key} ${times.key} 0" title="Stunde zur Reservierung auswählen"> --%>
<%-- 																</c:if> --%>
<%-- 														</c:if>  --%>
<%-- 													</authz:authorize> --%>
<!-- 												</div> -->
<%-- 									</c:if> --%>
<%-- 									<c:if test="${times.value.bookingType == '4'}"> --%>
<!-- 										<div class="abo-color"> -->
<%-- 												<authz:authorize ifNotGranted="ROLE_CUSTOMER"> --%>
<%-- 													<c:if test="${times.value.reservationDisplayName != 'leer'}"> --%>
<!-- 														<div class="reservationtext"> -->
<%-- 																<c:out value="${times.value.reservationDisplayName}"/> --%>
<!-- 															</div> -->
<%-- 													</c:if> --%>
<%-- 												</authz:authorize> --%>
<%-- 												<authz:authorize ifAnyGranted="ROLE_CUSTOMER"> --%>
<%-- 													<c:if test="${times.value.invited}"> --%>
<%-- 														<button name="invitation" id="invitation" value="${days.key} ${times.key} 1" title="Einladung beantworten"><span class="ui-icon ui-icon-mail-closed"></span> --%>
<!-- 														</button> -->
<%-- 													</c:if> --%>
<%-- 												</authz:authorize> --%>
<!-- 										</div> -->
<%-- 									</c:if> --%>
<%-- 									<c:if test="${times.value.bookingType == '5'}"> --%>
<!-- 										<div class="reserved-color"> -->
<%-- 												<authz:authorize ifNotGranted="ROLE_CUSTOMER" > --%>
<%-- 													<c:if test="${times.value.reservationDisplayName != 'leer'}"> --%>
<!-- 														<div class="reservationtext"> -->
<%-- 																<c:out value="${times.value.reservationDisplayName}"/> --%>
<!-- 														</div> -->
<%-- 													</c:if> --%>
<%-- 												</authz:authorize> --%>
<%-- 												<authz:authorize ifAnyGranted="ROLE_CUSTOMER"> --%>
<%-- 													<c:if test="${times.value.invited}"> --%>
<%-- 														<button name="invitation" id="invitation" value="${days.key} ${times.key} 1" title="Einladung beantworten"><span class="ui-icon ui-icon-mail-closed"></span> --%>
<!-- 														</button> -->
<%-- 													</c:if> --%>
<%-- 												</authz:authorize> --%>
<!-- 										</div> -->
<%-- 									</c:if> --%>
<%-- 								</c:forEach> --%>
				
				
<!-- 				</div> -->
				
<%-- 		</c:forEach> --%>
		
<!-- 					<div> -->
<%-- 						<input type="hidden" name="username" id="username" value="<authz:authentication operation="username" />" /> --%>
<%-- 						<input type="hidden" name="selectedCourt" id="selectedCourt" value="${rd.selectedCourt}" /> --%>
<%-- 						<input type="hidden" name="startdate" id="startdate" value="${rd.startdate}" /> --%>
<!-- 						<input type="hidden" id="deleteparameter" /> -->
<!-- 					</div> -->
<%-- 		</form> --%>
	</div>	
<!-- </td> -->
<!-- </tr> -->
<!-- <tr> -->
<!-- <td>      -->
<!-- 	<div id="bottom"> -->
<%-- 		<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}"> --%>
<%-- 			<authz:authorize ifAnyGranted="ROLE_CUSTOMER"> --%>
				
<!-- 					<input type="submit" id="submitbutton" name="submitbutton" value="Ausgewählte Stunden reservieren" /> -->
				
<%-- 			</authz:authorize> --%>
<%-- 		</c:if> --%>
<!-- 	</div> -->
<!-- </td> -->
<!-- </tr> -->
<!-- </table> -->

</div>

<!-- <div style="height:40px;"> -->
<!-- </div> -->

<div id="legend">
    Freie Stunden:
    <c:forEach items="${rd.dynamicLegend}" var="legend">
        <div class="notreserved-color-${legend.key} legend-element">${legend.value} EUR</div>
    </c:forEach>

    <br/> Reserviert:
    <div class="reserved-color legend-element">reserviert</div>
    <div class="reserved-by-me-color legend-element">meine Reservierung</div>
    <div class="abo-color legend-element">Abo reserviert</div>
    <div class="my-abo-color legend-element">mein Abo</div>
</div>  

<div id="reservationconfirmationdialog" title="Reservierungsdaten">
</div>
	<div id="deletedialog" title="Reservierung Löschen?">
		<div class="ui-widget">
			<div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
				<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
				<strong>Hinweis!</strong> Wollen Sie die ausgewählte Einzelstundenreservierung wirklich löschen?<br>
				Evt. vorhandene Einladungen für diese Stunde werden ebenfalls gelöscht.</p>
			</div>
		</div>
	</div>
<div id="invitationdialog" title="Spieler einladen">
	<div id = "customerList">
		<p>
			Bitte wählen Sie aus der folgenden Liste die Spieler aus, die Sie einladen wollen:
		</p>
		<div id="invitationCustomerScroller">
		</div>
		<p>
			Wieviele Spieler sollen max. teilnehmen können:
		</p>
	    <select name="invitationSlots" id="invitationSlots" size="1">
		      <option value="1">1</option>
		      <option value="2">2</option>
		      <option value="3">3</option>
		      <option value="4">4</option>
		      <option value="5">5</option>
		      <option value="6">6</option>
		      <option value="7">7</option>
		      <option value="8">8</option>
		      <option value="9">9</option>
		      <option value="10">10</option>
	    </select>
	</div>
</div>
<div id = "contextmenucontainer" style="display:none;position:absolute;">
	<ul id="contextmenu" >

	</ul>
</div>
</c:if>
<c:if test="${rd.loginError == '1'}">
	<div id="base" style="width:1024px!important;">
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;valign:center;"> 
				<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
				<strong>ACHTUNG: Ihr Login ist fehlgeschlagen!</strong><br>Sie haben entweder einen falschen Benutzernamen oder ein falsches Passwort eingegeben. Bitte wiederholen Sie das Login!<br>
				</p>
			</div>
		</div>
	</div>
	<div id="bottom">
	</div>	
	<div id ="rightpaginator">
	</div>
</c:if>

</div>