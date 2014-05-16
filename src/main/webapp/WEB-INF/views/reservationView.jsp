<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<c:set var="bookableHourCount" value="1" scope="page" />

<c:if test="${rd.loginError == '0'}">
<!--Reservation Selection-->	
<form id="reservationform" name="reservationform">		
	<div class="time-column">
		<div class="not-selected-day">
            &nbsp;
		</div>
		<c:forEach items="${rd.toTimes}" var="toTimes">
			<div class="times">${toTimes.key}</div>
		</c:forEach>
	</div>
    <c:set var="daycount" value="0" scope="page" />
	<c:forEach items="${rd.reservationsOfDay}" var="days">
		<c:set var="daycount" value="${daycount + 1}" scope="page"/>
		<div class="day">
			<c:if test="${rd.startdateX == days.key}">
				<div class="selected-day-label">
					<c:if test="${daycount==1}" >
					     Mo
					</c:if>
					<c:if test="${daycount==2}" >
					     Di
					</c:if>
					<c:if test="${daycount==3}" >
					     Mi
					</c:if>
					<c:if test="${daycount==4}" >
					     Do
					</c:if>
					<c:if test="${daycount==5}" >
					     Fr
					</c:if>
					<c:if test="${daycount==6}" >
					     Sa
					</c:if>
					<c:if test="${daycount==7}" >
					     So
					</c:if>
					<fmt:formatDate type="date" value="${days.key}" pattern="dd.MM.yyyy" dateStyle="short" />
				</div>
			</c:if>
			<c:if test="${rd.startdateX != days.key}">
				<div class="not-selected-day-label">
					<c:if test="${daycount==1}" >
					     Mo
					</c:if>
					<c:if test="${daycount==2}" >
					     Di
					</c:if>
					<c:if test="${daycount==3}" >
					     Mi
					</c:if>
					<c:if test="${daycount==4}" >
					     Do
					</c:if>
					<c:if test="${daycount==5}" >
					     Fr
					</c:if>
					<c:if test="${daycount==6}" >
					     Sa
					</c:if>
					<c:if test="${daycount==7}" >
					     So
					</c:if> 
					<fmt:formatDate type="date" value="${days.key}" pattern="dd.MM.yyyy" dateStyle="short" />
				</div>
			</c:if>
			
			
			<c:forEach items="${days.value}" var="times">
                <c:choose>
                    <c:when test="${days.key > rd.currentDate || days.key == rd.currentDate && times.key >= rd.currentTime}">			
							<c:if test="${times.value.bookingType == '3'}">
									<div class="reserved-by-me-color">
											<authz:authorize ifNotGranted="ROLE_CUSTOMER">
												<c:if test="${times.value.reservationDisplayName != 'leer'}">
													<c:out value="${times.value.reservationDisplayName}"/>
												</c:if>
											</authz:authorize>
											<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
												<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
													<c:if test="${days.key > rd.currentDate || days.key == rd.currentDate && times.key >= rd.currentTime}">
														<c:if test="${not rd.settings.invitationModuleEnabled}">
															<button name="add" id="opener" value="${days.key} ${times.key} 1" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span>
															</button>
														</c:if>
														<c:if test="${rd.settings.invitationModuleEnabled}">
															<button name="options" id="opener" value="${days.key} ${times.key} 1" title="Reservierung bearbeiten"><span class="ui-icon ui-icon-newwin"></span>
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
													<c:out value="${times.value.reservationDisplayName}"/>
												</c:if>
											</authz:authorize>
											<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
												<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
													<c:if test="${days.key > rd.currentDate || days.key == rd.currentDate && times.key >= rd.currentTime}">
														<c:if test="${not rd.settings.invitationModuleEnabled}">
															<button name="add" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung löschen"><span class="ui-icon ui-icon-trash"></span>
															</button>
														</c:if>
														<c:if test="${rd.settings.invitationModuleEnabled}">
															<button name="options" id="opener" value="${days.key} ${times.key} 1, ${rd.selectedCourt}" title="Reservierung bearbeiten"><span class="ui-icon ui-icon-newwin"></span>
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
									<div class="notreserved notreserved-color-${times.value.rate.timeId}">
											<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
												<c:if test="${(rd.settings.locked == '0') || (rd.settings.locked == '1')}">
														<c:if test="${days.key > rd.currentDate || days.key == rd.currentDate && times.key >= rd.currentTime}">
																<input type="checkbox" class="bookableHour" id= "bookableHour-${bookableHourCount}" name="reservationStartTime" value="${days.key} ${times.key} 0" title="">
                                                                <label for="bookableHour-${bookableHourCount}">&nbsp;</label>
                                                                <c:set var="bookableHourCount" value="${bookableHourCount + 1}" scope="page"/>
														</c:if>
												</c:if> 
											</authz:authorize>
                                            <authz:authorize ifNotGranted="ROLE_CUSTOMER, ROLE_ADMIN">
                                                <label title="Bitte loggen sie sich ein um Stunden zu reservieren">&nbsp;</label>
                                            </authz:authorize>
										</div>
							</c:if>
							<c:if test="${times.value.bookingType == '4'}">
								<div class="abo-color">
										<authz:authorize ifNotGranted="ROLE_CUSTOMER">
											<c:if test="${times.value.reservationDisplayName != 'leer'}">
												<c:out value="${times.value.reservationDisplayName}"/>
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
												<c:out value="${times.value.reservationDisplayName}"/>
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
                    </c:when>
                    <c:otherwise>
                        <div class="past-color">
                            &nbsp;
                        </div>
                    </c:otherwise>
                </c:choose>
			</c:forEach>	
		</div>
	</c:forEach>
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

<div id="reservationButton" class="buttonLight" style="display: none;">
    Ausgewählte Stunden buchen    
</div>

