<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<table>
	<c:forEach items="${rd.invitees}" var="invitee">
		<tr>
			<c:if test="${rd.user != invitee.customerReference}">
				<c:if test="${invitee.participates}">
					<td align="center" style="background-color: #BCE954;">
							<span class="ui-icon ui-icon-check"></span>
					</td>
				</c:if>
				<c:if test="${not invitee.participates}">
					<td align="center" style="background-color: #E77471;">
						<span class="ui-icon ui-icon-close"></span>
					</td>
				</c:if>
			</c:if>
			<c:if test="${rd.user == invitee.customerReference}">
				<c:if test="${invitee.participates}">
					<td style="background-color: #BCE954;">
						<input id = "acceptInvitation" type="checkbox" value="${invitee.id}" CHECKED />
					</td>
				</c:if>
				<c:if test="${not invitee.participates}">
					<c:if test="${registered ge rd.invitation.participantLimit}">
						<td style="background-color: #E77471;">
							<input id = "acceptInvitation" type="checkbox" value="test" DISABLED/>
						</td>
					</c:if>
					<c:if test="${rd.registered lt rd.invitation.participantLimit}">
						<td style="background-color: #E77471;">
							<input id = "acceptInvitation" type="checkbox" value="${invitee.id}" />
						</td>
					</c:if>
				</c:if>
			</c:if>
			<td>
				<c:out value="${invitee.customerLastName}" />
			</td>
			<td>
				<c:out value="${invitee.customerFirstName}" />
			</td>
		</tr>
	</c:forEach>
</table>
<c:if test="${rd.user == rd.invitation.inviter}">
<div id = "customerList">
		<p>
			Bitte wählen Sie aus der folgenden Liste die Spieler aus, die Sie einladen wollen:
		</p>
		<div>
		<div id="invitationCustomerScroller" style="overflow-y:scroll;height: 150px;">
			<c:forEach items="${rd.customers}" var="customer">
					<input type="checkbox" id=${customer.customerId} value="${customer.customerId}" class="customerList" /><label for="${customerId}" style="width:188px;">${customer.firstName} ${customer.lastName}</label><br>
			</c:forEach>
		</div>
		</div>
		<p>
			Wieviele Spieler sollen max. teilnehmen können:
		</p>
	    <select name="invitationSlots" id="invitationSlots" size="1">
		      <option value="1">1</option>
		      <option value="2">2</option>
		      <option value="3">3</option>
		      <option value="4">4</option>
		      <option value="5">5</option>
		      <option value="6">6</option>
		      <option value="7">7</option>
		      <option value="8">8</option>
		      <option value="9">9</option>
		      <option value="10">10</option>
	    </select>
	</div>
</c:if>

