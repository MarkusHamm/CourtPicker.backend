<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>CourtPicker - Features</title>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<div style="background-color:#FFFFFF;width:1024px;">
	<div id = "title" style="width:1024px;height:90px;border-top: solid 1px #afafaf;text-align:center;">
		<h1>CourtPicker - <spring:message code="label.menubuttonreferences"/></h1>
	</div>
	<div id ="container" style="width:1024px;height:1400px;border-top-width:1px;border-top-style:solid;border-top-color:#afafaf; background-color:#FFFFFF;">	
		<div class='feature' style="width:100%;height:630px;border-bottom: solid 1px #afafaf;">
			<div style="height:50px;background-color:white;">
			</div>
			<div style="margin:20px;">
				<b>Tennisclub Kalksburg</b><br>
				
				"Durch CourtPicker haben wir haben wir die Auslastung unseres Hallenplatzes signifikant erhöhen können."
				<br>Eduard Schneidhofer, TCK Vizepräsident
<!--				<img alt="configuratorImage" src="${contextPath}/resources/css/images/reference-tckalksburg.png" style="width:400px;" />-->
			</div>
		</div>
	
	</div>

</div>