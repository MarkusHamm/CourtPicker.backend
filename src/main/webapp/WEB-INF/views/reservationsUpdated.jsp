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

function loadXMLDoc(url, dialog){
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
	
	if(url=='reservationsUpdated.htm'){
		for(var i=0; i < $('#resReservationCount').val(); i++)
		{
			reservationIds = reservationIds + $('#resReservationId'+i).val()+';';
			reservationStartDates = reservationStartDates + $('#resReservationStartDate'+i).val()+';';
			reservationStartTimes = reservationStartTimes + $('#resReservationStartTime'+i).val()+';';
			resAbos = resAbos + $('#resAbo'+i).val()+';';
			resUsernames = resUsernames + $('#resUsernameData'+i).val()+';';
			resDisplayNames = resDisplayNames + $('#resDisplayName'+i).val()+';';
			resPrices = resPrices + $('#resPrice'+i).val()+';';
			resCourtIds = resCourtIds + $('#courtId'+i).val()+';';
			if($('#resDelete'+i).attr('checked')){
				deleted = deleted + '1';
			} else {
				deleted = deleted + '0';
			}
		}
		//alert(deleted);
		data ='reservationId='+reservationIds+'&reservationStartDate='+reservationStartDates+'&reservationStartTime='+reservationStartTimes+'&resAbo='+resAbos+'&username='+resUsernames+'&displayName='+resDisplayNames+'&price='+resPrices+'&reservationCount='+$('#resReservationCount').val()+'&courtId='+resCourtIds+'&delete='+deleted;
		
		
	}
	if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	} else {// code for IE6, IE5
	  xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
	}
	xmlhttp.onreadystatechange=function(){
	  if (xmlhttp.readyState==4 && xmlhttp.status==200){
		    
		  	document.getElementById(dialog).innerHTML=xmlhttp.responseText; 
		    //evalJS(alert("ALSODOCH"));
		  
		  	evalScript(xmlhttp.responseText);
		  
	    }
	};

xmlhttp.open('POST',url,true);
xmlhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
xmlhttp.setRequestHeader('Content-length', data.length);
xmlhttp.setRequestHeader('Connection', 'close');
xmlhttp.send(data);

}
</script>
<style type="text/css">
	.ui-tab {	
		font-size: 12px;
	}
</style>
			<form:form method="POST" name="reservationForm">
				<table>
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
									<td align="center"><input type="hidden"  id="resReservationId${x}" name="reservationId" value="${reservation.reservationId}"/><input type="hidden" id="courtId${x}" name="courtId" value="${reservation.courtId}"/><input type="hidden" id="resReservationStartDate${x}" name="reservationStartDate" value="${reservation.reservationStartDate}"/><input type="hidden"  name="reservationStartTime" value="${reservation.reservationStartTime}"/>${reservation.reservationStartDate}
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
										<input type="text" id="resUsernameData${x}" name="username" value="${reservation.username}" size=10/>
									</td>
									<td align="center">
										<input type="text" id="resDisplayName${x}" name="displayName" size=5 value="${reservation.reservationName}"/>
									</td>
									<td align="center">
										<input type="text" id="resPrice${x}" name="price" size=3 value="${reservation.price}"/>
									</td>
									<td align="center">
								<!-- <input type="hidden" id="resDelete${x}" name="hiddendelete[${x}]" value="0" /> -->
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
									<input type="hidden" id="resReservationCount" name="resReservationCount" value="${x}" />
									<input type="submit" value="Ändern" id="reservationUpdateButton" onclick="javascript: loadXMLDoc('reservationsUpdated.htm','reservationResult');"/>
								</td>
							</tr>
					</table>
				</form:form>