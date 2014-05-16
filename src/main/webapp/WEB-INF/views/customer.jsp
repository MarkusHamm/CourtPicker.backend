<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script type="text/javascript">
$(document).ready( function() {
	document.getElementById("tabs").style.visibility="visible";
	$('#tabs').tabs({ selected: $("#tabNumber").val() });

	$("table#singleReservations tr:even").css("background-color", "#F4F4F8");
	$("table#singleReservations tr:odd").css("background-color", "#EFF1F1");
	$("table#aboReservations tr:even").css("background-color", "#F4F4F8");
	$("table#aboReservations tr:odd").css("background-color", "#EFF1F1");
	$("table#deletedReservations tr:even").css("background-color", "#F4F4F8");
	$("table#deletedReservations tr:odd").css("background-color", "#EFF1F1");
	
	$("#singleReservations").tablesorter(); 
	$("#aboReservations").tablesorter(); 
	$("#deletedReservations").tablesorter(); 
});

$(function(){
	
	 $(function() {
		 $( "#selectable" ).selectable();
	 });
	
	//Accordion
	$( "#accordion" ).accordion({
		autoHeight: false,
		collapsible: true,
		width: '100%'
	});
	
	
	// Tabs
	$('#tabs').tabs();
	

	//hover states on the static widgets
	$('#dialog_link, ul#icons li').hover(
		function() { $(this).addClass('ui-state-hover'); }, 
		function() { $(this).removeClass('ui-state-hover'); }
	);
	
	$('.messagecontainer').live("click",function(event){
		$(this).children("#newmessageindicator").css("visibility", "hidden");
		$(this).css("background-color", "white");
		var messageId = $(this).children("#messageparameter").val();
		$.ajax({
			  url: 'setMessageRead.htm',
			  data: "messageId="+messageId,
			  success: function() {}
		});
	});
	$('#messageid').live("click",function(event){
		//alert($(this).attr("value"));
		$("#inviteeList")  
        .load("invitationInviteeListForMessage.htm", "resid="+$(this).attr("value"), function(responseText){  
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
	
	$( "#invitationstatusdialog").dialog({
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
});
</script>
<style type="text/css">
/* 	.ui-tab {	 */
/* 		font-size: 12px; */
/* 		width:1017px; */
/* 	} */
/* 	.ui-dialog { */
/* 		font-size: 12.0px; */
/* 	} */
/* 	.ui-datepicker { */
/* 		font-size: 11.4px; */
/* 	} */
		
/* 	#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;} */
/* 	#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;} */
/* 	ul#icons {margin: 0; padding: 0;} */
/* 	ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;} */
/* 	ul#icons span.ui-icon {float: left; margin: 0 4px;} */
</style>

</head>
<body>
<script type="text/javascript">
$(function(){
	// Datepicker
	$('#datepicker2').datepicker({
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
});
</script>
<input type="hidden" id="tabNumber" value="${rd.tabnumber}" />
<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
		<div id="tabs" class="ui-tab" style="visibility:hidden">
            <div id="tabsHeader">Kundenbereich:</div>
			<ul>
<!--			<li><a href="#tabs-1">Nachrichten</a></li>-->
				<li><a href="#tabs-2">Benutzerdaten</a></li>
				<li><a href="#tabs-3">Reservierungen</a></li>
			</ul>
<!--			<div id="tabs-1">-->
<!--				<c:forEach items="${rd.messages}" var="message">-->
<!--					<div class="messagecontainer" <c:if test="${message.isRead == false}">style="background-color:#d0e5f5;"</c:if>>-->
<!--						-->
<!--							<div id="newmessageindicator" class="messagecontent">-->
<!--							<c:if test="${message.isRead == false}">-->
<!--								<span class="ui-icon ui-icon-mail-closed"></span>-->
<!--							</c:if>-->
<!--							</div>-->
<!--						-->
<!--						<div class="messagecontent" id="sender">-->
<!--							${message.customerFirstName} ${message.customerLastName}-->
<!--						</div>-->
<!--						<div class="messagecontent" id="text">${message.text}-->
<!--						</div>-->
<!--						<input type="hidden" id="messageparameter" value = "${message.id}"/>-->
<!--					</div>-->
<!--				</c:forEach>-->
<!--				<div id="invitationstatusdialog" title="Einladungsstatus">-->
<!--					<div id = "acceptedList">-->
<!--						<p>-->
<!--							Folgenden Spieler werden an dieser Stunde teilnehmen:-->
<!--						</p>-->
<!--						<div id="inviteeList">-->
<!--					</div>-->
<!--				</div>-->
<!--				</div>-->
<!--			</div>-->
			<div id="tabs-2">
			<c:if test="${rd.error != '0'}">
				<div class="ui-widget">
				<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;"> 
					<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
					<strong>ACHTUNG:</strong><br><ul>
					<c:if test="${rd.firstname == '1'}"><li>Das Feld "Vorname" darf nicht leer sein!<br>
					</c:if>
					<c:if test="${rd.lastname == '1'}"><li>Das Feld "Nachname" darf nicht leer sein!<br>
					</c:if>
					<c:if test="${rd.email == '1'}"><li>Das Feld "Email" darf nicht leer sein!<br>
					</c:if>
					<c:if test="${rd.email == '2'}"><li>Es existiert bereits ein Benutzer mit dieser Email-Adresse. Bitte wählen Sie eine andere Email-Adresse!<br>
					</c:if>
					<c:if test="${rd.username == '1'}"><li>Das Feld "Benutzername" darf nicht leer sein!<br>
					</c:if>
					<c:if test="${rd.username == '2'}"><li>Es existiert bereits ein Benutzer mit diesem Benutzernamen. Bitte wählen Sie einen anderen Benutzernamen!<br>
					</c:if>
					</ul>
					</p>
				</div>
			</div>
			<br>
			</c:if>
				<form method="POST" action="customerUpdateDone.htm">
		
			<p class=font><spring:message code="editUserProfileText" /></p>
			<input type="hidden" name="customerId" value="${rd.customer.customerId}">
			<table>
				<tr>
					<td>&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						<spring:message code="field.loginUsername" />
					</td>
					<td><input type="text" name="username" value="${rd.customer.username}" DISABLED><br>
					<input type="hidden" name="username" value="${rd.customer.username}" />
					<input type="hidden" name="code" value="${rd.customer.code}" />
					</td>
					<!--<td>Mit diesem Benutzernamen (und dem Passwort) können Sie sich nach der Registrierung anmelden.
					</td>
				--></tr>
				<tr>
					<td>
						<spring:message code="field.firstName" />
					</td>
					<td>
						<input type="text" name="firstname" value="${rd.customer.firstName}"><br>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td>
						<spring:message code="field.lastName" />
					</td>
					<td>
						<input type="text" name="lastname" value="${rd.customer.lastName}"><br>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td>
						<spring:message code="field.email" />
					</td>
					<td>
						<input type="text" name="email" value="${rd.customer.email}"><br>
					</td>
					<!--<td>Die e-mail muss angegeben werden, weil z.B. Reservierungsbestätigungen per email verschickt werden.
					</td>
				--></tr>
				<tr>
					<td>
						TCK Mitglied
					</td>
					<td>
						<c:if test="${rd.customer.isMember==true}">
							<input type="checkbox" name="isMember" value="1" checked /><br>
						</c:if>
						<c:if test="${rd.customer.isMember==false}">
							<input type="checkbox" name="isMember" value="1" /><br>
						</c:if>
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
						<div><input type="text" name="birthday" id="datepicker2" value="${rd.customer.birthday}"></div><br>
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
					<td>&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="submit" value="Speichern"/></form><input type="reset" value="Abbrechen"/>
					</td>
				</tr>
				<tr></tr>
			</table>
			</form>
			</div>
			<div id="tabs-3">
				
				<div id="accordion">
					<h3><a href="#">Meine Einzelstunden</a></h3>
					<div>
						<c:choose>    
				             <c:when test="${not empty rd.customerReservations}">    
				                <table id="singleReservations" class="tablesorter" style="width:100%">
				                	<thead>
				                	<tr>
				                		<th align=center>Rechnungsnr.<span title="Klicken Sie auf einen der Spaltentitel um zu sortieren!"; class="ui-icon ui-icon-info" style="float:right;"></span>
				                		</th>
				                		<th align=center>Datum
				                		</th>
				                		<th align=center>Stunde
				                		</th>
				                		<th align=center>Reservierungstext
				                		</th>
				                		<th align=center>Preis
				                		</th>
				                		<th align=center>Reserviert am
				                		</th>
				                	</tr>
				                	</thead>
				                	<tbody>
									<c:forEach items="${rd.customerReservations}" var="reservation">
								  		<tr>
								 			<td align=center>
								 				<c:out value="${reservation.invoiceNumber}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${reservation.reservationStartDate}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${reservation.reservationStartTime}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${reservation.reservationName}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${reservation.price}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${reservation.timeOfReservation}" />
								 			</td>
								 		</tr>	
									</c:forEach>
								</tbody>
								</table>    
				             </c:when>    
				             <c:otherwise>    
				      			Sie haben noch keine Einzelstunden reserviert.   
				             </c:otherwise>    
			           </c:choose>    
					</div>
					<h3><a href="#">Meine Abostunden</a></h3>
					<div>
						<c:choose>    
				             <c:when test="${not empty rd.customerAboReservations}">
								<table id="aboReservations" class="tablesorter" style="width:100%">
								<thead>
									<tr>
				                		<th align=center>Rechnungsnr.<span title="Klicken Sie auf einen der Spaltentitel um zu sortieren!"; class="ui-icon ui-icon-info" style="float:right;"></span>
				                		</th>
				                		<th align=center>Abo-Name
				                		</th>
				                		<th align=center>Abo-Beginn
				                		</th>
				                		<th align=center>Abo-Ende
				                		</th>
				                		<th align=center>Wochentag
				                		</th>
				                		<th align=center>Stunde
				                		</th>
				                		<th align=center>Preis
				                		</th>
				                		<th align=center>Reserviert am
				                		</th>
				                	</tr>
				                </thead>
				                <tbody>
									<c:forEach items="${rd.customerAboReservations}" var="abo">
								  		<tr>
								 			<td align=center>
								 				<c:out value="${abo.invoiceNumber}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${abo.aboName}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${abo.aboFromDate}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${abo.aboToDate}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${abo.aboWeekDay}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${abo.reservationStartTime}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${abo.price}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${abo.timeOfReservation}" />
								 			</td>
								 			
								 		</tr>	
									</c:forEach>
									</tbody>
								</table>
							</c:when>
							<c:otherwise>    
				      			Sie haben noch keine Abostunde reserviert.   
				             </c:otherwise>  
						</c:choose>
					</div>
					<h3><a href="#">Stornierte Stunden</a></h3>
					<div>
						<c:choose>    
				             <c:when test="${not empty rd.deletedCustomerReservations}">
								<table id="deletedReservations" class="tablesorter" style="width:100%">
								<thead>
									<tr>
				                		<th align=center>Rechnungsnr.<span title="Klicken Sie auf einen der Spaltentitel um zu sortieren!"; class="ui-icon ui-icon-info" style="float:right;"></span>
				                		</th>
				                		<th align=center>Datum
				                		</th>
				                		<th align=center>Stunde
				                		</th>
				                		<th align=center>Reservierungstext
				                		</th>
				                		<th align=center>Storniert am
				                		</th>
				                	</tr>
			                	</thead>
			                	<tbody>
									<c:forEach items="${rd.deletedCustomerReservations}" var="delreservation">
								  		<tr>
								 			<td align=center>
								 				<c:out value="${delreservation.invoiceNumber}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${delreservation.reservationStartDate}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${delreservation.reservationStartTime}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${delreservation.reservationName}" />
								 			</td>
								 			<td align=center>
								 				<c:out value="${delreservation.timeOfReservation}" />
								 			</td>
								 		</tr>	
									</c:forEach>
								</tbody>
								</table>
							</c:when>
							<c:otherwise>    
				      			Sie haben noch keine Stunde storniert.   
				             </c:otherwise>  
						</c:choose>
					</div>
				</div>
			</div>
				
	

		</div>
</authz:authorize>





</body>
</html>