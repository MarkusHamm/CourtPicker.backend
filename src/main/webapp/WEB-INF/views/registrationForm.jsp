<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<authz:authorize ifNotGranted="ROLE_CUSTOMER">
	<form method="POST" id="registrationForm">
		<table align="center">
			<tr height="50px">
				<td colspan=2>
                    <h2>Registrierung</h2>
				</td>
			</tr>
            <tr>
                <td>
                    <spring:message code="field.firstName" />
                </td>
                <td>
                    <input type="text" id="firstname" value="${rd.customer.firstName}" style="width:100px;">
                </td>
            </tr>
            <tr>
                <td>
                    <spring:message code="field.lastName" />
                </td>
                <td>
                    <input type="text" id="lastname" value="${rd.customer.lastName}" style="width:100px;">
                </td>
            </tr>
            <tr>
                <td>
                    <spring:message code="field.email" />
                </td>
                <td>
                    <input type="text" id="email" value="${rd.customer.email}" style="width:100px;">
                </td>
            </tr>
            <tr>
                <td>
                    <spring:message code="field.loginUsername" />
                </td>
                <td>
                    <input type="text" id="username" value="${rd.customer.username}" style="width:100px;">
                </td>
            </tr>
            <tr>
                <td>
                    <spring:message code="field.loginPassword" />
                </td>
                <td>
                    <input type="password" id="password" value="${rd.customer.password}" style="width:100px;"/>
                </td>
            </tr>
            <tr>
                <td>
                    TCK Mitglied
                </td>
                <td>
                    <input type="checkbox" id="isMember" <c:if test="${rd.customer.isMember=='true'}">CHECKED</c:if> /><br>
                </td>
            </tr>
			<tr height="40px" valign="top">
				<td colspan="2">
					<input type="submit" id="registrationSubmit" name="registrationSubmit" value="Registrieren" class="button"/>
					<button id="registrationCancel" class="button">Abbrechen</button>
				<td>
			</tr>
		</table>	
	</form>
</authz:authorize>