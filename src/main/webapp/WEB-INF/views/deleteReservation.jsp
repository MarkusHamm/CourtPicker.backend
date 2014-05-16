<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>		
<c:if test="${rd.Limit == '0'}">
	<div class="ui-widget">
		<div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
			<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			Sie haben folgende Reservierung erfolgreich gelöscht:<br>
					Datum und Uhrzeit: <b>${rd.ReservationDate} um ${rd.Time}</b><br>Platz: <b>${rd.Court}</b>
			</p>
		</div>
	</div>
</c:if>
<c:if test="${rd.Limit == '1'}">
	<div class="ui-widget">
		<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
			<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			Die Frist zur Stornierung ist <b>${rd.DeletionLimit} min. vor Stundenbeginn</b> und ist leider abgelaufen. <br><b>Sie können diese Stunde nicht mehr stornieren.</b> 
			</p>
		</div>
	</div>
</c:if>
<c:if test="${rd.Limit == '2'}">
	<div class="ui-widget">
		<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
			<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			Folgender Fehler ist aufgetreten: ${rd.Exception} 
			</p>
		</div>
	</div>
</c:if>