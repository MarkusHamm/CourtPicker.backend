<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:if test="${rd.loginError == '0'}">
	<form method="POST" name="reservationform">
<!--		<div class="weekday-label">&nbsp;</div>-->
		<div class="column">
			<div class="not-selected-day">
				<c:out value="${rd.startdate}" />
			</div>
			<c:forEach items="${rd.toTimes}" var="toTimes">
				<div class="times">
					<div style="position:absolute; top: 25%">${toTimes.key}
					</div>
				</div>
			</c:forEach>
		</div>
			<c:forEach items="${rd.reservationsOfCourt}" var="courts">
				<div class="column">
						<div class="not-selected-day-label">${courts.key}</div>
						<c:forEach items="${courts.value}" var="times">					
							<c:if test="${times.value.bookingType == '1'}">
								<div class="paymentDone">
									<authz:authorize ifAnyGranted="ROLE_ADMIN">
										<c:if test="${times.value.reservationDisplayName != 'leer'}">
											<div class="reservationtext" style="float:left;">
												<c:out value="${times.value.reservationDisplayName}"/>
											</div>
										</c:if>
										<button name="add" id="opener" value="${courts.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-newwin"></span>
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
										<button name="add" id="opener" value="${courts.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-newwin"></span>
										</button>
									</authz:authorize>
								</div>
							</c:if>
								<c:if test="${times.value.bookingType == '0'}">			
									<div class="notreserved-color">
										<authz:authorize ifAnyGranted="ROLE_ADMIN">
											<input type="checkbox" class="courtTime" id= "courtTime" name="courtTime" value="${courts.key}/${times.key}" title="Stunde zur Reservierung auswählen">			
										</authz:authorize>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</c:forEach>
					<div style="width:20px;display: inline-block;">
						&nbsp;
					</div>
		<div>
			<input type="hidden" name="username" id="username" value="<authz:authentication operation="username" />" />
			<input type="hidden" name="selectedCourt" id="selectedCourt" value="${rd.selectedCourt}" />
			<input type="hidden" name="startdate" id="startdate" value="${rd.startdate}" />
			<input type="hidden" id="deleteparameter" />
		</div>
	</form>
</c:if>
<c:if test="${rd.loginError == '1'}">	
			<div class="ui-widget">
				<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;"> 
					<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
					<strong>ACHTUNG: Ihr Login ist fehlgeschlagen!</strong><br>Sie haben entweder einen falschen Benutzernamen oder ein falsches Passwort eingegeben. Bitte wiederholen Sie das Login!<br>
					</p>
				</div>
			</div>
</c:if>