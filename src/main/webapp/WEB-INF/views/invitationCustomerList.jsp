<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<div id="invitationCustomerScroller" style="overflow-y:scroll;height: 150px;">
	<c:forEach items="${rd.customers}" var="customer">
			<input type="checkbox" id=${customer.customerId} value="${customer.customerId}" class="customerList" /><label for="${customerId}" style="width:188px;">${customer.firstName} ${customer.lastName}</label><br>
	</c:forEach>
</div>
	