<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
				<div id ="foldButton" title="Messagebox einklappen">
					<span id = "buttonleft" class="ui-icon ui-icon-triangle-1-e"></span>
				</div>
				<c:forEach items="${rd.messages}" var="message">
					<div class="messagecontainer" <c:if test="${message.isRead == false}">style="background-color:#d0e5f5;"</c:if>>			
						<div id="newmessageindicator" class="messagecontent">
							<c:if test="${message.isRead == false}">
								<div>
									<span class="ui-icon ui-icon-mail-closed" ></span>
								</div>
							</c:if>
						</div>
						<div class="messagecontent" id="text"><font size=1><b>${message.customerFirstName} ${message.customerLastName}</b> schreibt am ${message.dateInserted}:</font><br><c:out value="${fn:substring(message.text,0,90)}"/>
						 ...
						</div>
						<input type="hidden" id="messageparameter" value = "${message.id}"/>
					</div>
				</c:forEach>
				<div id ="foldButton" title="Messagebox einklappen">
					<span id = "buttonleft" class="ui-icon ui-icon-triangle-1-e"></span>
				</div>
			</div>