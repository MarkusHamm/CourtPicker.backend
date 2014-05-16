<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<c:forEach items="${rd.courts}" var="courtName" varStatus="loopStatus">
    <c:if test="${loopStatus.count <= 3}">
	   <input type="checkbox" id="${courtName}" value="${courtName}" class="courtCheckbox" checked="checked" /><label for="${courtName}" style="margin-right: 5px; margin-bottom: 5px;"><c:out value="${courtName}"/></label>
    </c:if>
    <c:if test="${loopStatus.count > 3}">
	   <input type="checkbox" id="${courtName}" value="${courtName}" class="courtCheckbox"/><label for="${courtName}" style="margin-right: 5px; margin-bottom: 5px;"><c:out value="${courtName}"/></label>
    </c:if>
</c:forEach>