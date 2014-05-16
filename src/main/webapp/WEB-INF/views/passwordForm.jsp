<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
       
<form:form method="POST" id="passwordForm">
	<table align="center">
		<tr height="50px">
			<td colspan=2>Bitte geben Sie folgende Daten ein, <br>um Ihr Passwort zu erfahren!
			</td>
		</tr>
		<tr>
			<td>Vorname:
			</td>
			<td>
				<input type="text" id="pwdFirstName" name="vorname" style="width:100px;"/>
			</td>
		</tr>
		<tr>
			<td>Nachname
			</td>
			<td>
				<input type="text" id="pwdLastName" name="nachname" style="width:100px;"/>
			</td>
		</tr>
		<tr>
			<td>E-Mail Adresse:
			</td>
			<td>
				<input type="text" id="pwdEmail" name="email" style="width:100px;"/>
			</td>
		</tr>
		<tr height="50px">
			<td colspan="2">
				<input type="submit" value="Senden" class="button" />
                <button id="passwordCancelButton" class="button">Abbrechen</button>
            </td>
		</tr>
	</table>
</form:form>
