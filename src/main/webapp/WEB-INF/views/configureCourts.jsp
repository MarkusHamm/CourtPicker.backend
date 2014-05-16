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

//---------- general ----------

var cpInstanceId = ${sessionScope.cpInstanceId};

var courtCategories = new Array();
var courtCategoriesSelectedIndex = -1;
var formCourtCategory;
var formCourtCategoryValidator;

var courts = new Array();
var formCourt;
var formCourtValidator;

$(document).ready(function() {
	loadCourtCategories();
	addFormValidation();
});

function addFormValidation() {
	formCourtCategoryValidator = $("#courtCategoryForm").validate({
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
	
	formCourtValidator = $("#courtForm").validate({
		rules: {
    		// no quoting necessary
    		courtName: "required",
		},
		messages: {	
			courtCategoryName: "Bitte geben Sie einen Namen ein"
		},
		submitHandler: function(form) {
			submitCourt();
		}
	});
}

//---------- courtcategory ----------

function CourtCategory(id, cpInstanceId, orderNr, name) {
	this.id = id;
	this.cpInstanceId = cpInstanceId;
	this.orderNr = orderNr;
	this.name = name;
}

function loadCourtCategories() {
	$.getJSON('api/getCourtCategories?cpInstanceId=' + cpInstanceId, function(data) {
		courtCategories = data;
		populateCourtCategorySelect();
	});
}

function saveCourtCategory(courtCategory) {
	var cc = null;
	
	$.ajax({
		type: "POST",
		url: "api/saveCourtCategory",
		data: JSON.stringify(courtCategory),
		contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    async: false,
	    success: function(data) {
	    	cc = data;
	    },
	    failure: function(errMsg) {
	        alert(errMsg);
	    }
	});
	
	return cc;
}

function deleteCourtCategory(id) {
	$.ajax({
		type: "POST",
		url: "api/deleteCourtCategory?id=" + id,
	    async: false,
	    success: function(data) { },
	    failure: function(errMsg) {
	        alert(errMsg);
	    }
	});
}

function courtCategoryConfirmDelete(courtCategoryArrayIndex) {
	$("#courtCategoryConfirmDelete").dialog({
    	resizable: false,
    	modal: true,
    	buttons: {
        	"Löschen": function() {
        		deleteCourtCategoryHandler(courtCategoryArrayIndex);
        		$(this).dialog("close");
        	},
        	"Abbrechen": function() {
        		$(this).dialog( "close" );
        	}
    	}
	});
}

function showCourtCategoryForm() {
	// reset validation
	formCourtCategoryValidator.resetForm();
	
	// populate form
	$('#courtCategoryName').val(formCourtCategory.name);
	
	// show form
	if ($("#courtCategoryFormDiv").css("display") == "none") {
		$("#courtCategoryFormDiv").toggle("blind");
	}
	if ($("#addCourtCategoryButton").css("display") != "none") {
		$("#addCourtCategoryButton").toggle("blind");
	}
}

function hideCourtCategoryForm() {
    if ($("#courtCategoryFormDiv").css("display") != "none") {
    	$("#courtCategoryFormDiv").toggle("blind");
    }
    if ($("#addCourtCategoryButton").css("display") == "none") {
    	$("#addCourtCategoryButton").toggle("blind");
    }
}

function createNewCourtCategory() {
	var orderNr = 0;
	for (var i = 0; i < courtCategories.length; i++) {
		var cc = courtCategories[i];
		if (cc.orderNr > orderNr) {
			orderNr = cc.orderNr;
		}
	}
	orderNr++;
	
	formCourtCategory = new CourtCategory(null, cpInstanceId, orderNr, '');
	showCourtCategoryForm();
}

function submitCourtCategory() {
	formCourtCategory.name = $('#courtCategoryName').val();
	formCourtCategory = saveCourtCategory(formCourtCategory);

	loadCourtCategories();
	
	hideCourtCategoryForm();
}

// function addNewCourtCategory() {
// 	courtCategories.push(new CourtCategory(4, 1, 4, "baseball"));
// 	populateCourtCategorySelect();
// }

function selectCourtCategory(courtCategory) {
	hideCourtForm();
	
	for (var i = 0; i < courtCategories.length; i++) {
		if (courtCategories[i] == courtCategory) {
			courtCategoriesSelectedIndex = i;
			loadCourts(courtCategory.id);
			$("#addCourtButton").attr("disabled", false);
		}
	}
	populateCourtCategorySelect();
}

function editCourtCategory(courtCategory) {
	formCourtCategory = courtCategory;
	showCourtCategoryForm();
}

function deleteCourtCategoryHandler(courtCategoryArrayIndex) {
	var courtCategory = courtCategories[courtCategoryArrayIndex];
	if (courtCategory.id != null) {
		deleteCourtCategory(courtCategory.id);
	}
	
// 	courtCategories.splice(courtCategoryArrayIndex, 1);
	
	if (courtCategoryArrayIndex == courtCategoriesSelectedIndex) {
		courtCategoriesSelectedIndex = -1;
		courts = new Array();
		populateCourtSelect();
		$("#addCourtButton").attr("disabled", true);
	}
	
// 	populateCourtCategorySelect();

	loadCourtCategories();
}

function populateCourtCategorySelect() {
	var selectItemsHtml = "";
	
	for (var i = 0; i < courtCategories.length; i++) {
		var courtCategory = courtCategories[i];
		if (courtCategoriesSelectedIndex == i) {
			selectItemsHtml += "<div class=\"selectItem selectItemSelected\"\">" + courtCategory.name;
		}
		else {
			selectItemsHtml += "<div class=\"selectItem\" onclick=\"selectCourtCategory(courtCategories[" + i + "]);\">" + courtCategory.name;
		}
		selectItemsHtml += "<div class=\"selectItemButton\" onclick=\"editCourtCategory(courtCategories[" + i + "]); event.preventDefault(); event.stopPropagation();\">" + "edit";
		selectItemsHtml += "</div>";
		selectItemsHtml += "<div class=\"selectItemButton\" onclick=\"courtCategoryConfirmDelete(" + i + "); event.preventDefault(); event.stopPropagation();\">" + "delete";
		selectItemsHtml += "</div>";
		selectItemsHtml += "</div>";
	}
	
	$('#courtCategorySelect').html(selectItemsHtml);
}

// ---------- court ----------

function Court(id, courtNumber, courtName, indoorCourt, bookable, courtCategoryId) {
	this.id = id;
	this.courtNumber = courtNumber;
	this.courtName = courtName;
	this.indoorCourt = indoorCourt;
	this.bookable = bookable;
	this.courtCategoryId = courtCategoryId;
}

function loadCourts(courtCategoryId) {
	$.getJSON('api/getCourts?courtCategoryId=' + courtCategoryId, function(data) {
		courts = data;
		populateCourtSelect();
	});
}

function saveCourt(court) {
	var c = null;
	
	$.ajax({
		type: "POST",
		url: "api/saveCourt",
		data: JSON.stringify(court),
		contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    async: false,
	    success: function(data) {
	    	c = data;
	    },
	    failure: function(errMsg) {
	        alert(errMsg);
	    }
	});
	
	return c;
}

function deleteCourt(id) {
	$.ajax({
		type: "POST",
		url: "api/deleteCourt?id=" + id,
	    async: false,
	    success: function(data) { },
	    failure: function(errMsg) {
	        alert(errMsg);
	    }
	});
}

function courtConfirmDelete(courtArrayIndex) {
	$("#courtConfirmDelete").dialog({
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

function showCourtForm() {
	// reset validation
	formCourtValidator.resetForm();
	
	// populate form
	$('#courtName').val(formCourt.courtName);
	$('#courtType').val(formCourt.indoorCourt);
	if (formCourt.bookable == 1) {
		$("#courtBookable").attr("checked", true);
	}
	else {
		$("#courtBookable").attr("checked", false);
	}
	
	// show form
	if ($("#courtFormDiv").css("display") == "none") {
		$("#courtFormDiv").toggle("blind");
	}
	if ($("#addCourtButton").css("display") != "none") {
		$("#addCourtButton").toggle("blind");
	}
}

function hideCourtForm() {
    if ($("#courtFormDiv").css("display") != "none") {
    	$("#courtFormDiv").toggle("blind");
    }
    if ($("#addCourtButton").css("display") == "none") {
    	$("#addCourtButton").toggle("blind");
    }
}

function submitCourt() {
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

function createNewCourt() {
	var courtNr = 0;
	for (var i = 0; i < courts.length; i++) {
		var court = courts[i];
		if (court.courtNumber > courtNr) {
			courtNr = court.courtNumber;
		}
	}
	courtNr++;
		
	formCourt = new Court(null, courtNr, "", 0, 1, courtCategories[courtCategoriesSelectedIndex].id);	
	showCourtForm();
}

function editCourt(court) {
	formCourt = court;
	showCourtForm();
}

function deleteCourtHandler(courtArrayIndex) {
	var court = courts[courtArrayIndex];
	if (court.id != null) {
		deleteCourt(court.id);
	}
	
	loadCourts(courtCategories[courtCategoriesSelectedIndex].id);
}

function populateCourtSelect() {
	var selectItemsHtml = "";
	
	for (var i = 0; i < courts.length; i++) {
		var court = courts[i];
		selectItemsHtml += "<div class=\"selectItem\">" + court.courtName;
		selectItemsHtml += "<div class=\"selectItemButton\" onclick=\"editCourt(courts[" + i + "]); event.preventDefault(); event.stopPropagation();\">" + "edit";
		selectItemsHtml += "</div>";
		selectItemsHtml += "<div class=\"selectItemButton\" onclick=\"courtConfirmDelete(" + i + "); event.preventDefault(); event.stopPropagation();\">" + "delete";
		selectItemsHtml += "</div>";
		selectItemsHtml += "</div>";
	}
	
	$('#courtSelect').html(selectItemsHtml);
}

</script>

<div id="paddedContent">
    <h2>Platzarten</h2>
    <div id="courtCategorySelect" class="selectBox">
    </div>
    <button id="addCourtCategoryButton" onclick="createNewCourtCategory();">Platzart hinzufügen</button>
    
    <div id="courtCategoryFormDiv" style="display: none;">
        <form id="courtCategoryForm">
            <h4>Platzart</h4>
            <label for="courtCategoryName">Name</label>
            <input id="courtCategoryName" type="text" name="courtCategoryName"/>
            <br/>
            <input type="submit" name="courtCategorySubmit" value="Speichern"/>
        </form>
        <!-- has to be outside the form -->
        <button class="cancel" onclick="hideCourtCategoryForm();">Abbrechen</button>
    </div>
    
    <div id="courtCategoryConfirmDelete" title="Platzart löschen?" style="display: none;">
        <p>Diese Platzart und alle zugehörigen Plätze werden gelöscht. Sind Sie sicher?</p>
    </div>
    
    <h2>Plätze</h2>
    <div id="courtSelect" class="selectBox">
    </div>
    <button id="addCourtButton" onclick="createNewCourt();" disabled>Platz hinzufügen</button>
    
    <div id="courtFormDiv" style="display: none;">
        <form id="courtForm">
            <h4>Platz</h4>
            <label for="courtName">Name</label>
            <input id="courtName" type="text" name="courtName"/>
            <br/>
            <label for="courtType">Typ</label>
            <select id="courtType" name="courtType">
                <option value="1">Hallenplatz</option>
                <option value="0">Freiplatz</option>
            </select>
            <br/>
            <label for="courtBookable">Buchbar</label>
            <input id="courtBookable" type="checkbox" name="courtBookable" value="1">
            <br/>
            <input type="submit" name="courtSubmit" value="Speichern"/>
        </form>
        <!-- has to be outside the form -->
        <button class="cancel" onclick="hideCourtForm();">Abbrechen</button>
    </div>
    
    <div id="courtConfirmDelete" title="Platz löschen?" style="display: none;">
        <p>Dieser Platz wird unwiderruflich gelöscht. Sind Sie sicher?</p>
    </div>    
</div>
