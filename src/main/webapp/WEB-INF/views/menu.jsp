<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<head>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.9.custom.css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.9.custom.min.js"></script>
<script type="text/javascript">
$(function(){
	var court = 0;
	
	// Datepicker
	$('#dateselector').datepicker({
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		dateFormat: 'yy-mm-dd',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
		onSelect: function(dateText, inst) {
			//$('#datepicker').datepicker("setDate",dateText);
			loadReservationView("2012-11-30","Halle","base");
			//if(window.location.pathname=="/tck-roger/addReservationCourts.htm"){
			//	window.location="addReservationCourts.htm?startdate="+dateText;
			//} else {
			//	window.location="addReservation.htm?startdate="+dateText;
			//}
		}
	});	
	$('#dateselector').datepicker( "setDate" , "<%= request.getSession().getAttribute("jQueryDate") %>");
	
	$( ".button", ".menu" ).button();
	$( "a", ".button" ).click(function() { return false; });	
	
	 $( "#selectable" ).selectable({
		 selected: function(event, ui) {
	            $(".selectable li").each(function() {
	            	loadReservationView("2012-11-30","Halle","base");
	            	//window.location="addReservation.htm?startdate=2012-11-22";
	               
	            });
             
			 
			 
			 //court = 
			 //
		 }
	 });
});

function loadReservationView(date, court, div)
{
	var xmlhttp;
	var data = "";

	var data ="startdate="+date+"&court="+court;
	$("#base").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
	
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
			$('#base').stop(true,true).slideDown(600,"easeOutExpo");
			
	    }
	};
	xmlhttp.open("POST","reservationView.htm",true);
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
	.button { width:200px !important; font-size: .8em !important;}
	
	#feedback { font-size: 0.7em; }
    #selectable .ui-selecting { background: #FECA40; }
    #selectable .ui-selected { background: #F39814; color: white; }
    #selectable { list-style-type: none; margin: 0; padding: 0; width: 200px; }
    #selectable li { margin: 3px; padding: 1px; float: left; width: 50px; height: 20px; font-size: 0.7em; text-align: center; }
</style>
</head>
<div class="menu" id="menu">
	<div id="dateselector">
	</div>
	<div id="courtselect">
		<ol id="selectable">
		    <c:forEach items="${rd.courts}" var="courts">
				<li class="ui-state-default" value="${courts}">${courts}</li>
			</c:forEach>
		</ol>
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

