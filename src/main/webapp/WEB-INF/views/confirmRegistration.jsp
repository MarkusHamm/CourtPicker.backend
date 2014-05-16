<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.11.custom.min.js"></script>
<authz:authorize ifNotGranted="ROLE_CUSTOMER">
        <!-- error output -->
    	<c:if test="${rd.error != '0'}">
    		<div>
    			<div class="ui-state-error ui-corner-all smallFont" style="padding: 5px; margin-bottom: 10px;"> 
                    <span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span> 
    				<strong>ACHTUNG:</strong>
    				<ul style="margin: 5px 0;">
    					<c:if test="${rd.firstname != '0'}">
    						<li>Das Feld "Vorname" darf nicht leer sein!<br>
    					</c:if>
    					<c:if test="${rd.lastname != '0'}">
    						<li>Das Feld "Nachname" darf nicht leer sein!<br>
    					</c:if>
    					<c:if test="${rd.email == '1'}">
    						<li>Das Feld "Email" darf nicht leer sein!<br>
    					</c:if>
    					<c:if test="${rd.email == '2'}">
    						<li>Es existiert bereits ein Benutzer mit dieser Email-Adresse. Bitte wählen Sie eine andere Email-Adresse!<br>
    					</c:if>
    					<c:if test="${rd.username == '1'}">
    						<li>Das Feld "Benutzername" darf nicht leer sein!<br>
    					</c:if>
    					<c:if test="${rd.username == '2'}">
    						<li>Es existiert bereits ein Benutzer mit diesem Benutzernamen. Bitte wählen Sie einen anderen Benutzernamen!<br>
    					</c:if>
    					<c:if test="${rd.password == '1'}">
    						<li>Ihre beiden Password-Eingaben sind nicht gleich!<br>
    					</c:if>
    					<c:if test="${rd.password == '2'}">
    						<li>Das Feld "Password" darf nicht leer sein!<br>
    					</c:if>
    				</ul>
    			</div>
    		</div>
    	</c:if>

        <jsp:include page="registrationForm.jsp" />
</authz:authorize>