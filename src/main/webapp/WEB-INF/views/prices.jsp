<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
<link type="text/css" href="${contextPath}/resources/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />

<script src="${contextPath}/resources/js/jquery-1.8.2.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.min.js"></script>
<script src="${contextPath}/resources/js/jquery.tablesorter.js"></script>


<script type="text/javascript">
$(document).ready( function() {
	$("table#singleReservationPrice tr:even").css("background-color", "#F4F4F8");
	$("table#singleReservationPrice tr:odd").css("background-color", "#EFF1F1");
	$("table#aboReservationPrice tr:even").css("background-color", "#F4F4F8");
	$("table#aboReservationPrice tr:odd").css("background-color", "#EFF1F1");
});

$.fx.speeds._default = 100;
$(function(){

	$('#tabs').tabs({ selected: "${rd.tabnumber }"});
	
});
</script>
<style type="text/css">
	.ui-tab {	
		font-size: 12px;
		width:1017px;
	}
</style>
<div id="prices">
	<div id="tabs" class="ui-tab">
			<ul>
				<li><a href="#tabs-1">Einzelstunden-Tarife</a></li>
				<li><a href="#tabs-2">Abostunden-Tarife</a></li>
			</ul>
		<div id="tabs-1">
			<table id="singleReservationPrice" style="width:100%">
				<tr>
					<td>Tarif
					</td>
					<td>Von
					</td>
					<td>Bis
					</td>
					<td>Von
					</td>
					<td>Bis
					</td>
					<td align="center">Mitglieder
					</td>
					<td align="center">Nicht-Mitglieder
					</td>
				</tr>
				<c:forEach items="${rd.prices}" var="price">
					<tr>
						<td align="center">
							<c:out value="${price.name}" />
						</td>
						<td align="center">
							<c:out value="${price.dateFrom}" />
						</td>
						<td align="center">
							<c:out value="${price.dateTo}" />
						</td>
						<td align="center">
							<c:out value="${price.timeFrom}" />
						</td>
						<td align="center">
							<c:out value="${price.timeTo}" />
						</td>
						
						<td align="center">
							<b><c:out value="${price.priceForMember}" /></b> Euro
						</td>
						<td align="center">
							<b><c:out value="${price.priceForNonMember}" /></b> Euro
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div id="tabs-2">
			<table id="aboReservationPrice" style="width:100%">
				<tr>
					<td>Tarif
					</td>
					<td>Von
					</td>
					<td>Bis
					</td>
					<td>Von
					</td>
					<td>Bis
					</td>
					<td align="center">Mitglieder
					</td>
					<td align="center">Nicht-Mitglieder
					</td>
				</tr>
				<c:forEach items="${rd.abos}" var="price">
					<tr>
						<td align="center">
							<c:out value="${price.saisonName}" />
						</td>
						<td align="center">
							<c:out value="${price.saisonBegin}" />
						</td>
						<td align="center">
							<c:out value="${price.saisonEnd}" />
						</td>
						<td align="center">
							<c:out value="${price.saisonTimeFrom}" />
						</td>
						<td align="center">
							<c:out value="${price.saisonTimeTo}" />
						</td>
						
						<td align="center">
							<b><c:out value="${price.aboPriceMember}" /></b> Euro
						</td>
						<td align="center">
							<b><c:out value="${price.aboPriceNonMember}" /></b> Euro
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</div>

