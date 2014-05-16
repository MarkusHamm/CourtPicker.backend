<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<!--<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">-->
<!--<html>-->
<!--<head>-->
<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.11.custom.css" rel="stylesheet" />
<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.5.1.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.11.custom.min.js"></script>
<!--<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">-->
<!--<title>Insert title here</title>-->
		<style type="text/css">
			.ui-dialog {
				font-size: 12.0px;
			}

</style>
<table>
<tr>
    <td width=100>Wochentag
	</td>
    <td>
		<select NAME="day" id="day" SIZE="1" >
		    <option>Montag
  			</option>
  			<option>Dienstag
  			</option>
  			<option>Mittwoch
  			</option>
  			<option>Donnerstag
  			</option>
  			<option>Freitag
  			</option>
  			<option>Samstag
  			</option>
  			<option>Sonntag
  			</option>    		
		</select>	
    </td>
</tr>
<tr>
    <td>Uhrzeit
	</td>
    <td>
    	<select NAME="from" id="from" SIZE="1" >
    		<c:forEach items="${rd.times}" var="times">
    			<option value="${times}"><c:out value="${times}"/></option>
			</c:forEach>
		</select>
    </td>
</tr>
</table>