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
		<div class="time-column">
			<div class="not-selected-day">&nbsp;</div>
			<c:forEach items="${rd.toTimes}" var="toTimes">
				<div class="times">${toTimes.key}</div>
			</c:forEach>
		</div>
			<c:forEach items="${rd.reservationsOfCourt}" var="courts">
				<div class="column">
						<div class="not-selected-day-label">${courts.key}</div>
						<c:forEach items="${courts.value}" var="times">					
							<c:if test="${times.value.bookingType == '3'}">
								<div class="reserved-by-me-color">
									<authz:authorize ifNotGranted="ROLE_CUSTOMER">
										<c:if test="${times.value.reservationDisplayName != 'leer'}">
											<div class="reservationtext">
												<c:out value="${times.value.reservationDisplayName}"/>
											</div>
										</c:if>
									</authz:authorize>
									<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
										<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
											<c:if test="${rd.startdateX > rd.currentDate || rd.startdateX == rd.currentDate && times.key >= rd.currentTime}">
												<c:if test="${not rd.settings.invitationModuleEnabled}">
													<button name="add" id="opener" value="${courts.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span>
													</button>
												</c:if>
												<c:if test="${rd.settings.invitationModuleEnabled}">
													<button name="optionsDayView" id="opener" value="${courts.key}#${times.key}" title="Reservierung bearbeiten"><span class="ui-icon ui-icon-newwin"></span>
													</button>
												</c:if>
											</c:if>
										</c:if>
									</authz:authorize>
								</div>
							</c:if>					
							
							<c:if test="${times.value.bookingType == '2'}">
										
											<div class="my-abo-color">
												<authz:authorize ifNotGranted="ROLE_CUSTOMER">
													<c:if test="${times.value.reservationDisplayName != 'leer'}">
														<div class="reservationtext">
															<c:out value="${times.value.reservationDisplayName}"/>
														</div>
													</c:if>
												</authz:authorize>
												<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
													<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
														<c:if test="${rd.startdateX > rd.currentDate || rd.startdateX == rd.currentDate && times.key >= rd.currentTime}">
															<c:if test="${not rd.settings.invitationModuleEnabled}">
																<button name="add" id="opener" value="${courts.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span>
																</button>
															</c:if>
															<c:if test="${rd.settings.invitationModuleEnabled}">
																<button name="optionsDayView" id="opener" value="${courts.key}#${times.key}" title="Reservierung bearbeiten"><span class="ui-icon ui-icon-newwin"></span>
																</button>
															</c:if>
														</c:if>
													</c:if>
												</authz:authorize>
										</div>
									</c:if>
								<c:if test="${times.value.bookingType == '1'}">
									<div class="pre-reserved-color">
									</div>
								</c:if>
								<c:if test="${times.value.bookingType == '0'}">			
									<div class="notreserved-color">
										<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
											<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
												<c:if test="${rd.startdateX > rd.currentDate || rd.startdateX == rd.currentDate && times.key >= rd.currentTime}">
													<input type="checkbox" class="courtTime" id= "courtTime" name="courtTime" value="${courts.key}/${times.key}" title="Stunde zur Reservierung auswählen">
												</c:if>
											</c:if> 
										</authz:authorize>
									</div>
								</c:if>
								<c:if test="${times.value.bookingType == '4'}">
									<div class="abo-color">
											<authz:authorize ifNotGranted="ROLE_CUSTOMER">
												<c:if test="${times.value.reservationDisplayName != 'leer'}">
													<div class="reservationtext">
															<c:out value="${times.value.reservationDisplayName}"/>
														</div>
												</c:if>
											</authz:authorize>
											<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
													<c:if test="${times.value.invited}">
														<button name="invitation" id="invitation" value="${days.key} ${times.key} 1" title="Einladung beantworten"><span class="ui-icon ui-icon-mail-closed"></span>
														</button>
													</c:if>
												</authz:authorize>
									</div>
								</c:if>
								<c:if test="${times.value.bookingType == '5'}">
									<div class="reserved-color">
											<authz:authorize ifNotGranted="ROLE_CUSTOMER" >
												<c:if test="${times.value.reservationDisplayName != 'leer'}">
													<div class="reservationtext">
															<c:out value="${times.value.reservationDisplayName}"/>
													</div>
												</c:if>
											</authz:authorize>
											<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
													<c:if test="${times.value.invited}">
														<button name="invitation" id="invitation" value="${days.key} ${times.key} 1" title="Einladung beantworten"><span class="ui-icon ui-icon-mail-closed"></span>
														</button>
													</c:if>
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