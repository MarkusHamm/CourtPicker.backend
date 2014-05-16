<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<script src="${contextPath}/resources/js/cpapi/objects.js"></script>
<script src="${contextPath}/resources/js/cpapi/functions.js"></script>
<script src="${contextPath}/resources/js/angular.min.js"></script>

<script>

//---------- general ----------

var cpInstanceId = ${sessionScope.cpInstanceId};

var courtCategories = new Array();
var courtCategoriesSelectedIndex = 0;

var rates = new Array();
var ratesSelectedIndex = -1;
var formRate;
var formRateValidator;

$(document).ready(function() {
	courtCategories = CPAPI.getCourtCategories_sync(cpInstanceId);
	if (courtCategories.length > 0) {
		loadRates(courtCategories[courtCategoriesSelectedIndex].id);
	}
	
	populateDatePicker();
});

function populateDatePicker() {
	$("#rateDateFrom").datepicker({
		dateFormat: 'dd.mm.',
		showWeek: true,
		firstDay: 1,
		inline: true,
		changeYear: false,
		changeMonth: true,
		yearRange: '1910:2020',
		dayNamesMin: ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'],
		monthNames: ['Jänner','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
	});
}

function addFormValidation() {
	formCourtCategoryValidator = $("#rateForm").validate({
		rules: {
    		// no quoting necessary
    		courtCategoryName: "required",
		},
		messages: {	
			courtCategoryName: "Bitte geben Sie einen Namen ein"
		},
		submitHandler: function(form) {
			submitCourtCategory();
		}
	});
}

function loadRates(courtCategoryId) {
	rates = CPAPI.getRates_async(courtCategoryId, function(data) { 
		rates = data;
		populateRateTable();
	});
}

function populateRateTable() {
	var tbodyHtml = "";
	
	for (var i = 0; i < rates.length; i++) {
		var rate = rates[i];
		tbodyHtml += "<tr>";
		tbodyHtml += "<td>" + rate.name + "</td>";
		tbodyHtml += "<td>" + rate.price + "</td>";
		tbodyHtml += "<td>" + rate.dateFrom + "</td>";
		tbodyHtml += "<td>" + rate.dateTo + "</td>";
		tbodyHtml += "<td>" + rate.timeFrom + "</td>";
		tbodyHtml += "<td>" + rate.timeTo + "</td>";
		tbodyHtml += "<td>" + rate.weekDays + "</td>";
		tbodyHtml += "<td>" + rate.userGroupIds + "</td>";
		tbodyHtml += "</tr>";
	}
	
	$('#rateTable tbody').html(tbodyHtml);
}

function createNewRate() {
	var orderNr = 0;
	for (var i = 0; i < rates.length; i++) {
		var rate = rates[i];
		if (rate.orderNr > orderNr) {
			orderNr = rate.orderNr;
		}
	}
	orderNr++;
		
	formRate = new Rate(null, courtCategories[courtCategoriesSelectedIndex].id, "", true, 0, orderNr,
						"01-01-2012", "01-01-2013", "06:00", "24:00", "monday,tuesday", "members");
	
	alert(formRate instanceof Rate);
	
	// FIXME
	alert(typeof formRate.dateFrom);
	alert(typeof formRate.id);
	alert(typeof formRate.price);
	
	showRateForm();
}

function fillRateForm(rate) {
	$('#rateName').val(rate.name);
	$('#ratePrice').val(rate.price.toFixed(2));
	
	$('#rateDateFrom').val(formateDateStringForRate(rate.dateFrom));
	$('#rateDateTo').val(formateDateStringForRate(rate.dateTo));
	$('#rateTimeFrom').val(formatTimeStringForRate(rate.timeFrom));
	$('#rateTimeTo').val(formatTimeStringForRate(rate.timeTo));
	
	$('#rateWeekDays').val(rate.weekDays);
	$('#rateUserGroupIds').val(rate.userGroupIds);	
}

function formatDateStringForRate(dateString) {
	if (dateString == null) {
		return "";
	}
	
	var dateElements = dateString.split("-");
	var result = dateElements[0] + "." + dateElements[1] + ".";
	return result;
}

function formatTimeStringForRate(timeString) {
	if (timeString == null) {
		return "";
	}
	
	var timeElements = timeString.split(":");
	var result = timeElements[0] + ":" + timeElements[1];
	return result;
}



function getRateFromForm() {
	
}

function showRateForm() {
	// reset validation
	// FIXME
	//formRateValidator.resetForm();
	
	// populate form
	$('#rateName').val(formRate.name);
	$('#ratePrice').val(formRate.price);
	$('#rateDateFrom').val(formRate.dateFrom);
	$('#rateDateTo').val(formRate.dateTo);
	$('#rateTimeFrom').val(formRate.timeFrom);
	$('#rateTimeTo').val(formRate.timeTo);
	$('#rateWeekDays').val(formRate.weekDays);
	$('#rateUserGroupIds').val(formRate.userGroupIds);	
	
	// show form
	if ($("#rateFormDiv").css("display") == "none") {
		$("#rateFormDiv").toggle("blind");
	}
	if ($("#addRateButton").css("display") != "none") {
		$("#addRateButton").toggle("blind");
	}
}

function hideRateForm() {
    if ($("#rateFormDiv").css("display") != "none") {
    	$("#rateFormDiv").toggle("blind");
    }
    if ($("#addRateButton").css("display") == "none") {
    	$("#addRateButton").toggle("blind");
    }
}


//---------- rate ----------




function rateConfirmDelete(courtArrayIndex) {
	$("#rateConfirmDelete").dialog({
    	resizable: false,
    	modal: true,
    	buttons: {
        	"Löschen": function() {
        		deleteCourtHandler(courtArrayIndex);
        		$(this).dialog("close");
        	},
        	"Abbrechen": function() {
        		$(this).dialog( "close" );
        	}
    	}
	});
}



function submitRate() {
	formCourt.courtName = $('#courtName').val();
	formCourt.indoorCourt = $('#courtType').val();
	if ($('#courtBookable').attr("checked")) {
		formCourt.bookable = 1;
	}
	else {
		formCourt.bookable = 0;
	}	
	formCourt = saveCourt(formCourt);
	
	loadCourts(courtCategories[courtCategoriesSelectedIndex].id);
	hideCourtForm();
}

function editRate(court) {
	formRate = rate;
	showCourtForm();
}

function deleteRateHandler(rateArrayIndex) {
	var rate = rates[rateArrayIndex];
	if (rate.id != null) {
		deleteRate(rate.id);
	}
	
	loadRates();
}



</script>

<style type="text/css">
    .ui-datepicker-year{
        display:none;
    }
</style>

<div id="paddedContent">
    <h2>Tarife</h2>
    

    
    
    <table id="rateTable">
        <thead>
            <tr>
                <th>Name</th>
                <th>Preis</th>
                <th>Datum ab</th>
                <th>Datum bis</th>
                <th>Zeit von</th>
                <th>Zeit bis</th>
                <th>Wochentage</th>
                <th>Benutzergruppe</th>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    
    <button id="addRateButton" onclick="createNewRate();">Tarif hinzufügen</button>
    
    <div id="rateFormDiv" style="display: none;">
        <form id="rateForm">
            <h4>Tarif</h4>
            <fieldset>
                <legend>Eigenschaften</legend>
                <label for="rateName">Name</label> <input id="rateName" type="text" name="rateName"/> <br/>
                <label for="ratePrice">Price</label> <input id="ratePrice" type="text" name="ratePrice"/> <br/>           
            </fieldset>
            <fieldset>
                <legend>Constraints</legend>
                <label for="rateDateFrom">Date From</label> <input id="rateDateFrom" type="text" name="rateDateFrom"/> <br/>
                <label for="rateDateTo">Date To</label> <input id="rateDateTo" type="text" name="rateDateTo"/> <br/>
                <label for="rateTimeFrom">Time From</label> <input id="rateTimeFrom" type="text" name="rateTimeFrom"/> <br/>
                <label for="rateTimeTo">Time To</label> <input id="rateTimeTo" type="text" name="rateTimeTo"/> <br/>
                <label for="rateWeekDays">Weekdays</label> 
                    <input id="rateWeekDaysMonday" type="checkbox" name="rateWeekDaysMonday"/> Montag<br/>
                    <input id="rateWeekDaysTuesday" type="checkbox" name="rateWeekDaysTuesday"/> Dienstag<br/>
                    <input id="rateWeekDaysWednesday" type="checkbox" name="rateWeekDaysWednesday"/> Mittwoch<br/>
                    <input id="rateWeekDaysThursday" type="checkbox" name="rateWeekDaysThursday"/> Donnerstag<br/>
                    <input id="rateWeekDaysFriday" type="checkbox" name="rateWeekDaysFriday"/> Freitag<br/>
                    <input id="rateWeekDaysSaturday" type="checkbox" name="rateWeekDaysSaturday"/> Samstag<br/>
                    <input id="rateWeekDaysSunday" type="checkbox" name="rateWeekDaysSunday"/> Sonntag<br/>
                <label for="rateUserGroupIds">User Groups</label> <input id="rateUserGroupIds" type="text" name="rateUserGroupIds"/> <br/>
            </fieldset>            
            <input type="submit" name="rateSubmit" value="Speichern"/>
        </form>
        <!-- has to be outside the form -->
        <button class="cancel" onclick="hideRateForm();">Abbrechen</button>
    </div>
        
    <div id="rateConfirmDelete" title="Tarif löschen?" style="display: none;">
        <p>Sind Sie sicher das sie diesen Tarif löschen wollen?</p>
    </div>
    
<!--     <h2>Plätze</h2> -->
<!--     <div id="courtSelect" class="selectBox"> -->
<!--     </div> -->
<!--     <button id="addCourtButton" onclick="createNewCourt();" disabled>Platz hinzufügen</button> -->
    
<!--     <div id="courtFormDiv" style="display: none;"> -->
<%--         <form id="courtForm"> --%>
<!--             <h4>Platz</h4> -->
<!--             <label for="courtName">Name</label> -->
<!--             <input id="courtName" type="text" name="courtName"/> -->
<!--             <br/> -->
<!--             <label for="courtType">Typ</label> -->
<!--             <select id="courtType" name="courtType"> -->
<!--                 <option value="1">Hallenplatz</option> -->
<!--                 <option value="0">Freiplatz</option> -->
<!--             </select> -->
<!--             <br/> -->
<!--             <label for="courtBookable">Buchbar</label> -->
<!--             <input id="courtBookable" type="checkbox" name="courtBookable" value="1"> -->
<!--             <br/> -->
<!--             <input type="submit" name="courtSubmit" value="Speichern"/> -->
<%--         </form> --%>
<!--         has to be outside the form -->
<!--         <button class="cancel" onclick="hideCourtForm();">Abbrechen</button> -->
<!--     </div> -->
    
<!--     <div id="courtConfirmDelete" title="Platz löschen?" style="display: none;"> -->
<!--         <p>Dieser Platz wird unwiderruflich gelöscht. Sind Sie sicher?</p> -->
<!--     </div>     -->
</div>
