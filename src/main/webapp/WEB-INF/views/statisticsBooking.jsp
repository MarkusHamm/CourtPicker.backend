<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<script type="text/javascript">
$(document).ready( function() {
	initStatisticsBookingStaticContent();
	initStatisticsBookingBindings();
});

function initStatisticsBookingStaticContent() {
	$("#statisticsBookingDatepickerFrom").datepicker({
		dateFormat: 'dd.mm.yy',
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		yearRange: '1910:2020',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
	});
	$("#statisticsBookingDatepickerTo").datepicker({
		dateFormat: 'dd.mm.yy',
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: true,
		changeMonth: true,
		yearRange: '1910:2020',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember']
	});	
	
	populateStatisticsBookingDateInputs();
}

function populateStatisticsBookingDateInputs() {
	// pre-set timespan is the whole current year
	var currentDate = new Date();
	var beginOfYearDate = new Date();
	beginOfYearDate.setMonth(0);
	beginOfYearDate.setDate(1);
	$("#statisticsBookingDatepickerTo").datepicker("setDate", currentDate);
	$("#statisticsBookingDatepickerFrom").datepicker("setDate", beginOfYearDate);	
}

function initStatisticsBookingBindings() {
	$("#statisticsBookingForm").submit(function(event) {
		$.ajax({
			url: "statisticsBookingChart.htm" + "?" + $("#statisticsBookingForm").serialize()
		}).done(function(response) {
			$('#statisticsBookingChartContainer').html(response);
		});
				
		return false;
	});
}

function checkDatepickerActivation() {
	var selectedStatistic = $('input[name=statisticsBookingReport]:checked', '#statisticsBookingForm').val();
	
	if (selectedStatistic == "allYears") {
		$('#statisticsBookingDatepickerFrom').prop('disabled', true);
		$('#statisticsBookingDatepickerTo').prop('disabled', true);
	}
	else {
		$('#statisticsBookingDatepickerFrom').prop('disabled', false);
		$('#statisticsBookingDatepickerTo').prop('disabled', false);
	}
}

</script>


<h2>Buchungsstatistiken</h2>

<form id="statisticsBookingForm">						
	<p>
		<b>Statistik</b> <br/>
	    <input type="radio" name="statisticsBookingReport" value="allYears" onchange="checkDatepickerActivation()">Alle Jahre</input>
	    <input type="radio" name="statisticsBookingReport" value="year" checked onchange="checkDatepickerActivation()">Jahr</input>
	    <input type="radio" name="statisticsBookingReport" value="month" onchange="checkDatepickerActivation()">Monat</input>
	    <input type="radio" name="statisticsBookingReport" value="weekday" onchange="checkDatepickerActivation()">Wochentag</input>
	    <input type="radio" name="statisticsBookingReport" value="playTime" onchange="checkDatepickerActivation()">Buchungszeitpunkt</input>
	</p>
	<p>
		<b>Auswertung</b> <br/>
		<input type="radio" name="statisticsBookingType" value="bookings" checked>Buchungen</input>
	    <input type="radio" name="statisticsBookingType" value="turnover">Umsatz</input> 
	</p>
	<p>
		<b>Beobachtungszeitraum</b> <br/>
		Von: <input id="statisticsBookingDatepickerFrom" type="text" name="statisticsBookingDatepickerFrom" size="10" />
		Bis: <input id="statisticsBookingDatepickerTo" type="text" name="statisticsBookingDatepickerTo" size="10" />
	</p>

	<input type="submit" id="calcBookingStatistics" value="Berechnen"/>
</form>

<div id="statisticsBookingChartContainer" />
