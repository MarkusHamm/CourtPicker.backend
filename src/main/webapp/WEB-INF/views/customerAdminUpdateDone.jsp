<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<!--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">-->
<!--<html>-->
<!--<head>-->
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!--<title>Insert title here</title>-->
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.11.custom.min.js"></script>
<!--</head>-->
<!--<body>-->
<!--</body>-->
<!--</html>-->
		<style type="text/css">
			.ui-dialog {
				font-size: 12.0px;
			}
			.ui-datepicker {
				font-size: 11.4px;
			}
		</style>
<br>
	<div class="ui-state-success ui-corner-all" style="padding: 0 .7em;"> 
		<table>
			<tr>
				<td valign=top>
					<span class="ui-icon ui-icon-circle-check" style="float: left; margin-right: .3em;background-image: url(${contextPath}/resources/css/images/ui-icons_469bdd_256x240_green.png");"></span>
				</td>
				<td>
					Ihre Änderungen wurden erfolgreich durchgeführt!
				</td>
			</tr>
		</table>
	</div>