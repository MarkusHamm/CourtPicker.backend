<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
    <head>
        <c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
        
        <link type="text/css" href="${contextPath}/resources/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />
        <link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
        <link type="text/css" href="${contextPath}/resources/css/instance/1/instanceStyle.css" rel="stylesheet" />
        <script src="${contextPath}/resources/js/jquery-1.8.2.js"></script>
        <script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.min.js"></script>
        <script src="${contextPath}/resources/js/jquery.tablesorter.js"></script>     
        <script src="${contextPath}/resources/js/json2.js"></script>
        <script src="${contextPath}/resources/js/jquery.validate.min.js"></script>
        
        <script>
            setInterval(function() {
            	$("#messagebox")  
                .html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>")
            	.load("messagebox.htm",function(){});
            }, 
            1000 * 60 * 1
            );
            
            $(function() {
            	$( document ).tooltip();
            $('.messagecontainer').live("click",function(event){
            	$(this).children("#newmessageindicator").css("visibility", "hidden");
            	$(this).css("background-color", "white");
            	var messageId = $(this).children("#messageparameter").val();
            	$("#messagedetailview").css('top', $(this).position().top-1);
            	$("#messageIndicator").css('top', $(this).position().top+20);
            	$.ajax({
            		  url: 'setMessageRead.htm',
            		  data: "messageId="+messageId,
            		  success: function() {}
            	});
            	$("#messagedetailview")  
            	.html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>")
                .load("message.htm", "messageId="+messageId, function(){});
            	
            	$('#messagedetailview').show('blind', {direction: 'right'}, 500);
            	$('#messageIndicator').show('blind', {direction: 'right'}, 500);
            });
            $('#messageid').live("click",function(event){
            	//alert($(this).attr("value"));
            	$("#inviteeList") 
            	.html("<table width='100%'><tr><td align = 'center'><img src='${contextPath}/resources/css/custom-theme/images/ajax-loader.gif' alt='Loading, please wait...' /></td><tr><td align='center'>Bitte warten...</td></tr></table>")
                .load("invitationInviteeListForMessage.htm", "resid="+$(this).attr("value"), function(responseText){  
                });
            	$("#invitationstatusdialog").dialog("option", "buttons", {
            		'Ok': function() { 
            			//alert($('#acceptInvitation').val());
            			//alert($('#acceptInvitation').attr("checked"));
            			$.ajax({
            				  url: 'acceptInvitation.htm',
            				  data: "inviteeId="+$('#acceptInvitation').val()+"&checked="+$('#acceptInvitation').attr("checked"),
            				  success: function() {
            					  reloadDisplay();
            				  }
            			});
            			$(this).dialog("close");
            		}, 
            		"Abbrechen": function() {
            			reloadDisplay();
            			$(this).dialog("close"); 
            		}
            	});
            	$("#invitationstatusdialog").dialog('open');
            	$("#messagedetailview").hide();
            	return false;
            });
            
            $( "#invitationstatusdialog").dialog({
            	autoOpen: false,
            	resizable: false,
            	show: "blind",
            	position:"absolute",
            	width: 400,
            	height: 400,
            	top: '50%',
            	left: '50%',
            	modal: true,
            	buttons: {
            		'OK': function() { 
            			alert("HIER");
            		}, 
            		"Abbrechen": function() { 
            			reloadDisplay();
            			$(this).dialog("close"); 
            		} 
            	}
            });
            
            $("#foldButton").live("click", function(event) {
            	$('#messagebox').hide('blind', {direction: 'right'}, 300);
            	$('#unfoldButton').stop(true, true).slideDown(600,"easeOutExpo");
            });
            $("#unfoldButton").live("click", function(event) {
            	$('#messagebox').show('blind', {direction: 'right'}, 300);
            	$('#unfoldButton').stop(true, true).slideUp(600,"easeOutExpo");
            });
            
            $(document).mouseup(function (e){
                var container = $("#messagedetailview");
                if (container.has(e.target).length === 0)
                {
                    container.hide();
                    $("#messageIndicator").css("display", "none");
                }
            });
                      
            });
        </script>
        
        <style type="text/css">
        /*.ui-dialog {
        		font-size: 12.0px;
        	}
        	.ui-datepicker {
        		font-size: 11.4px;
        		width: 184px;
        	}
        	.ui-widget {                
        		font-size: 10px !important;          
        	}*/
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title><tiles:getAsString name="title" /></title>
    </head>

    <body>
<!-- 		<div id="frame">	 -->
<!-- 			<div id="header"> -->
				<tiles:insertAttribute name="header" />
<!-- 			</div> -->
			<div id="mainframe">
				<tiles:insertAttribute name="content" />
			</div>
			<div id="footer">
				<tiles:insertAttribute name="footer" />
			</div>
<!-- 		</div> -->
        
		<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
    		<c:if test="${fn:length(rd.messages) gt 0}">
    			<div id="messagebox">
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
    								<input type="hidden" id="newMessageExists" value="yes"/>
    							</c:if>
    						</div>
    						<div class="messagecontent" id="text"><font size=1><b>${message.customerFirstName} ${message.customerLastName}</b> schreibt am ${message.dateInserted}:</font><br><c:out value="${fn:substring(message.text,0,50)}"/>
    						 ...
    						</div>
    						<input type="hidden" id="messageparameter" value = "${message.id}"/>
    					</div>
    				</c:forEach>
    				<div id ="foldButton" title="Messagebox einklappen">
    					<span id = "buttonleft" class="ui-icon ui-icon-triangle-1-e"></span>
    				</div>
    			</div>
    			<div id ="unfoldButton" style="display:none" title="Messagebox ausklappen">
    				<span id = "buttonleft" class="ui-icon ui-icon-triangle-1-w"></span>
    			</div>
    			<div id ="messagedetailview" style="display:none">
    				DAS ist ein Test
    			</div>
    			<div id="messageIndicator" style="display:none">
    				<span id = "buttonleft" class="ui-icon ui-icon-triangle-1-w"></span>
    			</div>
    		</c:if>
            
    		<div id="invitationstatusdialog" title="Einladungsstatus">
    			<div id = "acceptedList">
    				<div id="inviteeList">
    				</div>
    			</div>
    		</div>
		</authz:authorize>
    </body>
</html>