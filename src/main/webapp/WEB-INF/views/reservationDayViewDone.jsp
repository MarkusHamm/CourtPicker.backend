<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<c:if test="${rd.success == '1'}">
	<div class="ui-widget">
		<div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
			<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			Sie haben Ihre <b>Reservierungen erfolgreich abgeschlossen!</b> <br>Sie erhalten in Kürze ein <b>Bestätigungs-Email</b> mit Informationen bzgl. Bezahlung.
			</p>
		</div>
	</div>
</c:if>
<c:if test="${rd.success == '0'}">		
	<div class="ui-widget">
		<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
			<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			Die Reservierung konnte nicht durchgeführt werden.
			<br>
			Falls sich das Problem nicht beheben lässt, wenden Sie sich bitte an den Administrator (<a href="mailto:tennis@tckalksburg.at">tennis@tckalksburg.at</a>)!
			</p>
		</div>
	</div>	
</c:if>
<c:if test="${rd.success == '2'}">		
	<div class="ui-widget">
		<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
			<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			Die Reservierung konnte nicht durchgeführt werden, weil eine der von Ihnen ausgewählten Stunden inzwischen reserviert worden ist!
			</p>
		</div>
	</div>		
</c:if>

