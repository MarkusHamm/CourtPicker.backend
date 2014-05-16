<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<script src="${contextPath}/resources/js/jquery-1.8.2.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.min.js"></script>
<script src="${contextPath}/resources/js/jquery.tablesorter.js"></script>

<script type="text/javascript">
$(document).ready( function() {
	
	$("table#reservationSearchResultTable tr:even").css("background-color", "#F4F4F8");
	$("table#reservationSearchResultTable tr:odd").css("background-color", "#EFF1F1");
	
	$("#reservationSearchResultTable").tablesorter(); 

	initBindings();
});


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
	{	alert(e);
	}
}

function loadFilterXMLDoc(url, dialog){
	var xmlhttp;
	var data;
	var reservationIds='';
	var deleted='';
	var reservationStartDates='';
	var reservationStartTimes='';
	var resAbos='';
	var	resInvoiceNumbers='';
	var resUsernames='';
	var resDisplayNames='';
	var resPrices = '';
	var resCourtIds = '';
	//alert("ENTERED");
	
	if(url=="reservationData.htm"){
		var data ="rid="+$('#reservationParameter').val();
	}
	
	if(url=='reservationUpdated.htm'||url=="reservationDeleted.htm"){
		data ='reservationId='+$('#adminReservationId').val()+'&userid='+$('#reservationDetailUserId').val()+'&displayName='+$('#adminReservationName').val()+'&price='+$('#adminReservationPrice').val()+'&comment='+$('#adminReservationComment').val()+'&payment='+$('#adminPaymentDone').attr("checked");
		$("#reservationResult").empty().html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>");
	}
	if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	} else {// code for IE6, IE5
	  xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
	}
	xmlhttp.onreadystatechange=function(){
		//alert(dialog);
	  if (xmlhttp.readyState==4 && xmlhttp.status==200){
		  	
		  if(url=="reservationData.htm"){
				document.getElementById(dialog).innerHTML=xmlhttp.responseText; 
		  }
		  	
		  	//if(url=='reservationUpdated.htm'||url=="reservationDeleted.htm"){
		  	//	document.getElementById(dialog).innerHTML=xmlhttp.responseText;
		  	//
		  	//}
		  	
		evalScript(xmlhttp.responseText);
	    }
	};

xmlhttp.open('POST',url,true);
xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
xmlhttp.setRequestHeader('Content-length', data.length);
xmlhttp.setRequestHeader('Connection', 'close');
xmlhttp.send(data);

}

$(function(){
	
	
	//hover states on the static widgets
	$('#dialog_link, ul#icons li').hover(
		function() { $(this).addClass('ui-state-hover'); }, 
		function() { $(this).removeClass('ui-state-hover'); }
	);
	
	
	
		

});

function initBindings(){
	
	//var $dialog = null;
	
	
	
	//if (!$dialog) {
		//$dialog = 
		$("#reservationDialog").dialog({
		autoOpen: false,
		show: "blind",
		modal: true,
		//position: "top",
		width: 600,
		buttons: {
			"Speichern": function() { 
				loadFilterXMLDoc("reservationUpdated.htm","reservationResult");
				$('#filterReservations').click();
				$("#reservationDialog").dialog("close");
			},
			"Löschen": function() { 
				loadFilterXMLDoc("reservationDeleted.htm","reservationResult");
				$('#filterReservations').click();
				$("#reservationDialog").dialog("close");
			},
			"Abbrechen": function() {
				$("#reservationDialog").dialog("close");
			} 
		}
	});
	//}
	
		$('#reservationInfo[name=reservationInfo]').click(function(){
			$('#reservationParameter').val($(this).val());
			loadFilterXMLDoc("reservationData.htm","reservationDialog");
			$("#reservationDialog").dialog('open');
			return false;
		});
};


</script>
<style type="text/css">
	.ui-tab {	
		font-size: 12px;
	}
	.ui-dialog {	
		font-size: 12.0px;
	}
</style>
			<form:form method="POST" name="reservationForm">
			<h3 class="ui-widget-header ui-corner-all">Suchergebnisse</h3>
				<table id="reservationSearchResultTable" class="tablesorter" style="width:100%">
					<thead>
					<tr>
						<th align="center">Datum<span title="Klicken Sie auf einen der Spaltentitel um zu sortieren!"; class="ui-icon ui-icon-info" style="float:right;"></span>
						</th>
						<th align="center">Uhrzeit
						</th>
						<th align="center">Typ
						</th>
						<th align="center">Buchungsdatum
						</th>
						<th align="center">Platz
						</th>
						<th align="center">Rech-Nr.
						</th>
						<th align="center">Benutzername
						</th>
						<th align="center">Anzeigename
						</th>
						<th align="center">Abo-Details
						</th>
						<th align="center">Kommentar
						</th>
						<th align="center">Preis
						</th>
						<th align="center">Bezahlt
						</th>
						<th align="center">Öffnen
						</th>
					</tr>
					</thead>
					<tbody>
						<c:set var="x" value="0" />
						<c:set var="totalPrice" value="0" />
							<c:forEach items="${rd.reservations}" var="reservation">
								<tr>
									<td align="center"><input type="hidden"  id="resReservationId${x}" name="reservationId" value="${reservation.reservationId}"/><input type="hidden" id="courtId${x}" name="courtId" value="${reservation.courtId}"/><input type="hidden" id="resReservationStartDate${x}" name="reservationStartDate" value="${reservation.reservationStartDate}"/><input type="hidden"  name="reservationStartTime" value="${reservation.reservationStartTime}"/>${reservation.reservationStartDate}
									</td>
									<td align="center">${reservation.reservationStartTime}							
									</td>
									<td align="center">
										<c:if test="${reservation.abo==true}">
											Abo
										</c:if>
										<c:if test="${reservation.abo==false}">
											Einzel
										</c:if>
									</td>
									<td align="center">
										${reservation.timeOfReservation}
									</td>
									<td align="center">
										${reservation.courtName}
									</td>
									<td align="center">${reservation.invoiceNumber}
									</td>
									<td align="center">
										${reservation.username}
									</td>
									<td align="center">
										${reservation.reservationName}
									</td>
									<td align="center">
										<c:if test="${reservation.abo==true}">	
											${reservation.aboName}
											<br>
											${reservation.aboWeekDay} von ${reservation.aboFromDate} bis ${reservation.aboToDate}
										</c:if>
									</td>
									<td align="center">
										${reservation.comment}
									</td>
									<td align="center">
										${reservation.price}
									</td>
									
										<c:if test="${reservation.paymentDone==true}">
											<td align="center" style="background-color: #BCE954;">
											<span class="ui-icon ui-icon-check"></span>
										</c:if>
										<c:if test="${reservation.paymentDone==false}">
											<td align="center" style="background-color: #E77471;">
											<span class="ui-icon ui-icon-close"></span>
										</c:if>
									</td>
									<td align="center">
										<button name="reservationInfo" id="reservationInfo" value="${reservation.reservationId}" title="Reservierung bearbeiten"><span class="ui-icon ui-icon-pencil"></span></button>
									</td>
								</tr>
								<c:set var="x" value="${x+1}" />
								<c:set var="totalPrice" value="${totalPrice+reservation.price}" />
								</c:forEach>
								</tbody>
								</table>
								<table>
									<tr style="height:20px">
									</tr>
									<tr style="height:20px">
										<td colspan=10 align=right>
											<b><c:out value="${x}" /> Reservierungen</b>
										</td>
										<td>
											<b><c:out value="${totalPrice}" /> EUR</b>
											<input type="hidden" id="resReservationCount" name="resReservationCount" value="${x}" />
										</td>
									</tr>
							</table>
				</form:form>
				
				<!-- XLS-Export -->
				<c:if test="${rd.reservations.size() > 0}">
					<form:form method="POST" action="adminReservationExcelExport.htm">
						<input type="submit" value="Excel Export"/>
					</form:form>
				</c:if>
									
<input type="hidden" id="reservationParameter" name="reservationParameter"/>
<div id="reservationDialog" title="Reservierungsdaten bearbeiten">
</div>