 <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<div style="background-color:#FFFFFF;width:1024px;height:1800px;">
	<div id = "title" style="width:1024px;height:90px;border-top: solid 1px #afafaf;text-align:center;">
		<h1><spring:message code="label.menuwhycourtpicker"/></h1>
	</div>
	<div style="border-top-width:1px;border-top-style:solid;border-top-color:#afafaf;">
		<div class="placeholder50">
		</div>
		<div style="margin:50px;">
			
			<img alt="configuratorImage" src="${contextPath}/resources/css/images/cartoons/tennis1.jpg" style="width:500px;height:300px;" />
			<img alt="configuratorImage" src="${contextPath}/resources/css/images/cartoons/tennis2.jpg" style="width:300px;height:300px;" />			
			<p>Mehr Reservierungen!</p>
			<img alt="configuratorImage" src="${contextPath}/resources/css/images/cartoons/chaos1.jpg" style="width:400px;height:400px;" />
			<img alt="configuratorImage" src="${contextPath}/resources/css/images/cartoons/chaos2.jpg" style="width:400px;height:400px;" />
			<p>Einfachere Administration!</p>
			<img alt="configuratorImage" src="${contextPath}/resources/css/images/cartoons/sports2.jpg" style="width:400px;height:400px;" />
			<img alt="configuratorImage" src="${contextPath}/resources/css/images/cartoons/sports1.jpg" style="width:400px;height:400px;" />
			<p>Flexibel und günstig!</p>
		</div>
	</div>
</div>