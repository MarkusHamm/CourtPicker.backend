<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CourtPicker</title>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<link type="text/css" href="${contextPath}/resources/css/courtpicker.css" rel="stylesheet" />
<link type="text/css" href="${contextPath}/resources/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />
<script src="${contextPath}/resources/js/jquery-1.8.2.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.js"></script>
<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.min.js"></script>
<script src="${contextPath}/resources/js/jquery.tablesorter.js"></script>
<!-- liteAccordion -->
<link href="${contextPath}/resources/css/liteaccordion.css" rel="stylesheet" />
<script src="${contextPath}/resources/js/jquery.easing.1.3.js"></script>
<script src="${contextPath}/resources/js/liteaccordion.jquery.js"></script>

<script type="text/javascript">	
$(function() {
	var i = 1;
	
	initBindings();
	
	$("#yourAccordion").liteAccordion({"theme":"light","easing":"easeOutExpo","containerWidth":"999","containerHeight":"150"});
	
	function CheckTypes(val){
		 var element=document.getElementById('otheroption');
		 if(val=='Other')
		   element.style.display='block';
		 else  
		   element.style.display='none';
		}
		
	function calculateDialogPosition(buttonposition, dialog) {
		if(dialog=='#schemeSelectionDialog'){
			
			$(dialog).stop(true,true).slideUp(600,"easeOutExpo");
			$(dialog).css("left", buttonposition.left-365);
			$(dialog).css("top", buttonposition.top-368);
			$(dialog).stop(true,true).slideDown(600,"easeOutExpo");
			$(dialog).effect("highlight", {color: '#BCE954'}, 3000);
		}else{
			$(dialog).stop(true,true).slideUp(600,"easeOutExpo");
			$(dialog).css("left", buttonposition.left-26);
			$(dialog).css("top", buttonposition.top+38);
			$(dialog).stop(true,true).slideDown(600,"easeOutExpo");
			$(dialog).effect("highlight", {color: '#BCE954'}, 3000);
		}
	}
	
	function calculateTotalPrice(){
		var priceString;
		var numberOfCourts= $('.court').length;
		var price = numberOfCourts*10;
		priceString = price+' EUR';
		$('#basispackageprice').text(priceString);
		
		var totalPrice = price;
		$('input:checkbox:checked.additionalFeature').each(function () {
			var price = $(this).val();
			totalPrice = parseInt(totalPrice) + parseInt(price);
		});
		totalPriceString = totalPrice+' EUR';
		$('#totalprice').text(totalPriceString);
		$('#totalprice').css('font-size','20pt');
		
	}	
		
	function setFocus(field)
	{
		document.getElementById(field).focus();
	}
	
	
function initBindings(){	
	
	$('.additionalFeature').click(function(event) { 
		var id = $(this).attr('id')+'Price';
		id = '#'+id;
		if($(this).attr('checked')=='checked'){
			$(id).css('visibility','visible');
		} else {
			$(id).css('visibility','hidden');
		}
		calculateTotalPrice();
	});
	
	$('#courtbutton').click(function(event) { 
		calculateDialogPosition($(this).position(), "#courtDialog");	
		setFocus("courtnumber");
		$("#courtnumber").val(i);
		$("#courttype").val('');
		$("#courtname").val('');
		$("#courttype").val('');
	});
	
	
	$(document).ready(function() {
		$('.removeElement').click(function(event) { 
				
				$(this).parent().remove();
				calculateTotalPrice();
		});
	});
	

	
	$("#courtframetop").live("click", function(event) {
	    event.preventDefault();
	    $("#courtListContent").animate({
	        scrollTop: "-=" + 150 + "px"
	    });
	});
	$("#courtframebottom").live("click", function(event) {
	    event.preventDefault();
	    $("#courtListContent").animate({
	        scrollTop: "+=" + 150 + "px"
	    });
	});	
	
	$("#tariffframetop").live("click", function(event) {
	    event.preventDefault();
	    $("#tariffListContent").animate({
	        scrollTop: "-=" + 150 + "px"
	    });
	});
	$("#tariffframebottom").live("click", function(event) {
	    event.preventDefault();
	    $("#tariffListContent").animate({
	        scrollTop: "+=" + 150 + "px"
	    });
	});	
	
	
	$('#tariffbutton').click(function(event) { 
		calculateDialogPosition($(this).position(), "#tariffDialog");
		setFocus("tariffname");
	});
	
	$('#layoutbutton').click(function(event) { 
		calculateDialogPosition($(this).position(), "#schemeSelectionDialog");	
	});
	
	$('#submitbutton').click(function(event) { 
		$.ajax({
			  url: 'courtpickerCreated.htm',
			  data: "instanceName=test",
			  success: function() {	
			  }
		});
	});
	
	$(document).mouseup(function (e){
	    var container = $(".dialog");
	    if (container.has(e.target).length === 0)
	    {
	        container.hide();
	    }
	});

}

$('#addCourtButton').click(function(event) { 
	
	i = i + 1;

	$('#courtDialog').stop(true,true).slideUp(600,"easeOutExpo");
	if($('#courttype').val()=="Badminton"){
		$('#courtListContent').prepend("<div class='court' style='overflow:hidden;'><div style='float:left;width:55px;overflow:hidden;'><img src='${contextPath}/resources/css/images/badmintoncourt.gif' height='40px' width:'50px'/></div><div style='width:170px;float:left;margin-left:10px;font-family: Verdana;font-size:9pt;'>"+$('#courtnumber').val()+" - "+$('#courtname').val()+"<br> ("+$('#courttype').val()+", "+$('#indoor').val()+") "+"</p></div><div class='removeElement' style='width:20px;height:40px;float:right;'><span class='ui-icon ui-icon-close'></span></div></div>");
		initBindings();
	}
	if($('#courttype').val()=="Tennis"){
		$('#courtListContent').prepend("<div class='court' style='overflow:hidden;'><div style='float:left;width:55px;overflow:hidden;'><img src='${contextPath}/resources/css/images/tenniscourt.gif' height='40px' width:'50px'/></div><div style='width:170px;float:left;margin-left:10px;font-family: Verdana;font-size:9pt;'>"+$('#courtnumber').val()+" - "+$('#courtname').val()+"<br> ("+$('#courttype').val()+", "+$('#indoor').val()+", "+$('#surface').val()+") "+"</p></div><div class='removeElement' style='width:20px;height:40px;float:right;'><span class='ui-icon ui-icon-close'></span></div></div>");
		initBindings();
	}
	if($('#courttype').val()=="Other"){
		$('#courtListContent').prepend("<div class='court' style='overflow:hidden;'><div style='float:left;width:55px;overflow:hidden;'><img src='${contextPath}/resources/css/images/owncourt.gif' height='40px' width:'50px'/></div><div style='width:170px;float:left;margin-left:10px;font-family: Verdana;font-size:9pt;'>"+$('#courtnumber').val()+" - "+$('#courtname').val()+"<br> ("+$('#courttype').val()+", "+$('#indoor').val()+") "+"</p></div><div class='removeElement' style='width:20px;height:40px;float:right;'><span class='ui-icon ui-icon-close'></span></div></div>");
		initBindings();
	}
	if($('#courttype').val()=="Squash"){
		$('#courtListContent').prepend("<div class='court' style='overflow:hidden;'><div style='float:left;width:55px;overflow:hidden;'><img src='${contextPath}/resources/css/images/squashcourt.gif' height='40px' width:'50px'/></div><div style='width:170px;float:left;margin-left:10px;font-family: Verdana;font-size:9pt;'>"+$('#courtnumber').val()+" - "+$('#courtname').val()+"<br> ("+$('#courttype').val()+", "+$('#indoor').val()+") "+"</p></div><div class='removeElement' style='width:20px;height:40px;float:right;'><span class='ui-icon ui-icon-close'></span></div></div>");
		initBindings();
	}
	calculateTotalPrice();
});

$('#addTariffButton').click(function(event) { 
	$('#tariffDialog').stop(true,true).slideUp(600,"easeOutExpo");
	$('#tariffListContent').prepend("<div class='tariff' style='overflow:hidden;'><div style='float:left;width:55px;overflow:hidden;'><img src='${contextPath}/resources/css/images/tariff.gif' height='40px' width:'50px'/></div><div style='width:170px;float:left;margin-left:10px;font-family: Verdana;font-size:9pt;'>"+$('#courtnumber').val()+" - "+$('#courtname').val()+"<br> ("+$('#courttype').val()+", "+$('#indoor').val()+") "+"</p></div><div class='removeElement' style='width:20px;height:40px;float:right;'><span class='ui-icon ui-icon-close'></span></div></div>");
	initBindings();
});


});	
</script>
<style>
       
 
            .call_out {
                color: #444444;              
                background: url('images/callout_bg.gif') repeat;
                -webkit-border-radius: 4px;
                -moz-border-radius: 4px;
                border-radius: 4px;
                -webkit-box-shadow: 1px 0 3px rgba(0, 0, 0, 0.08);
                -moz-box-shadow: 1px 0 3px rgba(0, 0, 0, 0.08);
                box-shadow: 1px 0 3px rgba(0, 0, 0, 0.08);
                margin-top: 20px;
            }

            .call_out .wrap {
                padding: 19px 20px 17px 20px;
                border: 1px solid #d7d4cb;
                -webkit-border-radius: 3px;
                -moz-border-radius: 3px;
                border-radius: 3px;
            }

            .call_out h2 {
                font-family: Verdana; /*Georgia, "Times New Roman", Times, serif;*/
                font-style: italic;
                text-shadow: 0 1px 0 rgba(255, 255, 255, 1);
                color: #444444;
                font-size: 18px;
                line-height: 20px;
                margin: 10px 0;
            }

            .call_out a.alt_btn {
                background: url('images/sprite.png') 24px 356px;
                display: block;
                padding: 0 0 0 23px;
                float: right;
                margin: -45px 0 0 0;
                font-family: Verdana;/*Georgia, "Times New Roman", Times, serif;*/
                font-style: italic;
                font-size: 14px;
                color: #252525;
                text-shadow: 0px 1px 1px rgba(255, 255, 255, 0.8);
                text-align: center;
                border: none;
                -webkit-box-shadow: 0;
                -moz-box-shadow: 0;
                box-shadow: 0;
                text-decoration: none;
                font-weight: bold;
            }

            .call_out a.alt_btn span {
                padding: 14px 23px 15px 0;
                background: url('images/sprite.png') 100% 253px;
                display: block;
            }

            .call_out a:hover.alt_btn { background: url('images/sprite.png') 24px 408px }
            .call_out a:hover.alt_btn span { background: url('images/sprite.png') 100% 304px }
        </style>
</head>
<body>
<img alt="full screen background image" src="${contextPath}/resources/css/images/courtpickerbackground.jpg" id="full-screen-background-image" /> 
   	<div id = "frame">
   		<div id="languageselection" style="width:1024px;height:20px;border: solid 0px #b3b2b2;color:white;text-align:right;">
	   	Sprachauswahl (Flaggen)
	   	</div>
		<div id="titlerow" style="width:1024px;height:80px;border: solid 0px #b3b2b2;background-color:#BCE954;color:white;">
			<div id = "title" style="width:450px;height:80px;border: solid 0px #b3b2b2;float:left;margin-left:10px;">
				<img src="${contextPath}/resources/css/images/courtpickerlogo.gif"/>
			</div>
			<div id = "courtsearch" style="width:280px;height:78px;border: solid 0px #b3b2b2;float:left;">
					<div style="width:180px;border: solid 0px #b3b2b2;float:left;">
						<div style="font-family: Verdana;font-size:9pt;margin-top:5px;">Sie suchen einen Platz?
						</div>
						<div style="font-family: Verdana;font-size:9pt;width:60px;float:left;">Wo?
						</div>		
						<div style="font-size:11pt;">
							<input type = 'text' style="height:10px;width:105px;color:grey;" value="Verein, Ort, Plz, Land"/>
						</div>
						<div style="font-family: Verdana;font-size:9pt;width:60px;float:left;">Wann?
						</div>		
						<div style="font-size:11pt;float:left;">
							<input type = 'text' style="height:10px;width:45px;color:grey;" value="dd.mm.yyyy"/>
						</div>
						<div>
							<select id="timesearch" size="1" style="width:60px;">
							      <option value="">06:00</option>
							      <option value="">07:00</option>
							      <option value="">08:00</option>
							      <option value="">09:00</option>
							      <option value="">10:00</option>
							      <option value="">11:00</option>
							      <option value="">12:00</option>
							      <option value="">13:00</option>
							      <option value="">14:00</option>
							      <option value="">15:00</option>
							      <option value="">16:00</option>
							      <option value="">17:00</option>
							      <option value="">18:00</option>
							      <option value="">19:00</option>
							      <option value="">20:00</option>
							      <option value="">21:00</option>
							      <option value="">22:00</option>
							      <option value="">23:00</option>
							      <option value="">24:00</option>
						    </select>
						</div>
						<div style="font-family: Verdana;font-size:9pt;width:60px;float:left;">Platztyp?
						</div>
						<div>
							<select name="typesearch" size="1" style="width:110px;">
						        <option>Tennis</option>
						        <option>Badminton</option>
						        <option>Squash</option>
							</select>
						</div>
					</div>
					<div style="font-size:11pt;width:95px;float:left;">
						<button style="width:80px;height:55px;margin-top: 20px;">Suchen</button>
					</div>
			</div>
			<div id = "loginbox" style="width:280px;height:78px;border: solid 0px #b3b2b2;float:left;">
				<authz:authorize ifNotGranted="ROLE_CUSTOMER">
					<form method="POST" action="j_acegi_security_check" name="login">
						<div class="loginContainer" style="float:left;">
							<div style="width:100px;float:left;">
								<font class="menu-font" style="font-family: Verdana;font-size:9pt;"><spring:message code="field.loginUsername"/></font><br><input type="text" name="j_username" size="10" style="width:90px;" tabindex="1"> 
							</div>
							<div style="width:90px;float:left;">
								<font class="menu-font" style="font-family: Verdana;font-size:9pt;"><spring:message code="field.loginPassword" /></font><br><input type="password" name="j_password" size="10" style="width:80px;" tabindex="2"/> 
							</div>			
						</div>
						<div class="loginButton">
							<br>
							<input type="submit" value="Einloggen" tabindex="3"/>
						</div>
					</form>
				</authz:authorize>
				<authz:authorize ifAnyGranted="ROLE_CUSTOMER">
					<form method="POST" action="logout.htm">
						<div class="loggedInText">
							<div align="right"><spring:message code="field.loggedInText"/><br><authz:authentication operation="username" />
							</div>
						</div>
						<div class="loginButton">
							<input type="submit" value="Abmelden"/>
						</div>
			
					</form>
				</authz:authorize>
				
			</div>
		</div>
		<div id = "advertisement" style="width:1024px;height:178px;border: solid 0px #b3b2b2;">
			 <div id="yourAccordion" style="margin-left:1px;">
                <ol>
                    <li>
                        <h2><span style="font-size:9pt;font-family: Verdana;">Was ist Courtpicker?</span></h2>
                        <div>
                        	<p style="font-size:9pt;margin:10px;color:white;font-family: Verdana;align:justify;"><b>Courtpicker</b> ist nicht nur eine <b>Plattform wo Sportbegeisterte nach verfügbaren Sportplätzen suchen und diese reservieren können</b>. Mit <b>Courtpicker</b> können Sie ein <b>individuelles web-basiertes Reservierungssystem</b> für Ihren Sportverein bzw. Ihre Sportanlage <b>flexibel konfigurieren</b> und <b>günstig betreiben</b>. Durch die Eingabe von <b>Platz-informationen</b> (Tennis, Badminton, Squash, oder eigene Platztypen), <b>Tarifen</b>, <b>Layoutelementen</b> und die Auswahl von <b>zusätzlichen Funktionalitäten</b> können Sie das Reservierungssystem an Ihre Bedürfnisse anpassen.                       
							</p>
						</div>
                    </li>
                    <li>
                        <h2><span style="font-size:9pt;font-family: Verdana;">Wer braucht das?</span></h2>
                        <div>
                        	<div style ="float:left;width:50%;">
	                        	<p style="font-size:9pt;margin:10px;color:white;font-family: Verdana;align:justify;">
	                        		<b>Sportbegeisterte</b><br>
	                        		die auf der Suche nach einem Tennis-, Badminton-, Squash- oder sonstigem Platz sind, können über die Courtpicker-Suche schnell einen freien Platz zur gefragten Zeit am gefragten Ort finden oder sich über aktuelle Angebote informieren.
	                        	</p>
	                        </div>
	                        <div style ="float:left;width:50%;">
	                        	<p style="font-size:9pt;margin:10px;color:white;font-family: Verdana;align:justify;">
	                        		<b>Sportvereine bzw. Sportanlagen-Betreiber</b><br>
	                        		finden mit Courtpicker eine einfache und praktische Möglichkeit, ihre Reservierungsabläufe zu vereinfachen und potentiellen Kunden die Möglichkeit zu geben via Internet freie Stunden zu finden und zu reservieren.
	                        	</p>
	                        </div>
                        </div>
                    </li>
                    <li>
                        <h2><span style="font-size:8pt;font-family: Verdana;">Was kann Courtpicker?</span></h2>
                        <div>
                        	<div style ="float:left;width:33%;">
	                        	<p style="font-size:9pt;margin:10px;color:white;font-family: Verdana;align:justify;">
	                        		<b>Einfache Reservierung via Internet</b><br>
	                        		durch schnelle Übersicht über Platzbelegung und freie Plätze
	                        	</p>
	                        </div>
	                        <div style ="float:left;width:33%;">
	                        	<p style="font-size:9pt;margin:10px;color:white;font-family: Verdana;align:justify;">
	                        		<b>Optimierung der Abläufe</b><br>
	                        		z.B. durch Paypal-Integration zur automatischen Zahlungsabwicklung, Zahlungsstatusübersicht, Such- und Filtermöglichkeiten...
	                        	</p>
	                        </div>
	                        <div style ="float:left;width:33%;">
	                        	<p style="font-size:9pt;margin:10px;color:white;font-family: Verdana;align:justify;">
	                        		<b>Analyse des Kundenverhaltens</b><br>
	                        		durch Auswertung von Statistiken um z.B. konkrete Sonderangebote machen zu können
	                        	</p>
	                        </div>
	                   </div>
                    </li>
                </ol>
            </div>
		
		
		</div>
		<div id = "configurator" style="width:1022px;height:500px;border: solid 1px #b3b2b2;background-color:white;">
			<div id ="column1" style="width:340px;height:100%;border: solid 0px #b3b2b2;float:left;">
				<div id = "courtselection" style="width:100%;height:245px;">
					<div id="courtbutton" style="width:300px;margin: 0 auto;margin-top:10px;">
						<button style="width:100%;height:30px;align:center;">Add a court</button>
					</div>
					<div id="courtlist" >
						<div id="courtframetop">
							<div style="margin: 0 auto;width:10px;">
								<span class="ui-icon ui-icon-triangle-1-n"></span>
							</div>
						</div>
						<div id="courtframe">
							<div id="courtListContent">
							</div>
						</div>
						<div id="courtframebottom">
							<div style="margin: 0 auto;width:10px;">
								<span class="ui-icon ui-icon-triangle-1-s"></span>
							</div>
						</div>
					</div>
				</div>
				<div id = "tariffselection">
					<div id="tariffbutton" style="width:300px;margin: 0 auto;margin-top:10px;">
						<button style="width:100%;height:30px;align:center;">Add a tariff</button>
					</div>
					<div id="tarifflist" style="margin: 0 auto;width:300px;margin-top:10px;height:169px;border: solid 1px #b3b2b2;">
						<div id="tariffframetop">
							<div style="margin: 0 auto;width:10px;">
								<span class="ui-icon ui-icon-triangle-1-n"></span>
							</div>
						</div>
						<div id="tariffframe">
							<div id="tariffListContent">
							</div>
						</div>
						<div id="tariffframebottom">
							<div style="margin: 0 auto;width:10px;">
								<span class="ui-icon ui-icon-triangle-1-s"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id ="column2" style="width:339px;height:100%;border: solid 0px #b3b2b2;float:left;">
				<div id = "settings" style="margin: 0 auto;width:300px;height:350px;margin-top:10px;border: solid 1px #b3b2b2;">
					<div style="margin:10px;">
						<div id ="text">
							<p style="font-size:9pt;">Define the name of your reservation system, e.g. if the name is tckalksburg, the reservation system will be available under http://www.courtpicker.at/tckalksburg
							</p>
						</div>
						<div style="margin: 0 auto;width:300px;">
							<input type="text" size=30 style="width:270px;vertical-align: middle;" />
						</div>
						<div id ="text2">
							<p style="font-size:9pt;">Select a logo for your reservation system(file format gif, jpg, or png, size 150x80)
							</p>
						</div>
						<div style="margin: 0 auto;width:300px;">
							<input name="Datei" type="file" size="23" maxlength="100000" accept="text/*">
						</div>
						<div id ="text3">
							<p style="font-size:9pt;">If the logo should link to your homepage, pls insert the internet address of your homepage here
							</p>
						</div>
						<div style="margin: 0 auto;width:300px;">
							<input type="text" size=30 style="width:270px;vertical-align: middle;" />
						</div>
						<div id ="text4">
							<p style="font-size:9pt;">Select a banner for your reservation system(file format gif, jpg, or png, size 1024x80)
							</p>
						</div>
						<div style="margin: 0 auto;width:300px;">
							<input name="Datei" type="file" size="23" maxlength="100000" accept="text/*">
						</div>
					</div>
				</div>
				<div id = "layoutselection">
					<div id="layoutbutton" style="width:300px;margin: 0 auto;margin-top:10px;">
						<button style="width:100%;height:30px;align:center;">Select a color scheme</button>
					</div>
					<div id="selectedlayout" style="margin: 0 auto;width:300px;margin-top:10px;height:62px;border: solid 1px #b3b2b2;">
					</div>
				</div>
			</div>
			<div id ="column3" style="width:339px;height:100%;border: solid 0px #b3b2b2;float:left;">
				<div id = "costs">
					<div id = "basisfeatures">
						<div id="text" style="margin: 0 auto;width:300px;margin-top:10px;height:179px;border: solid 1px #b3b2b2;">
							<p style="font-size:9pt;margin:7px;">The following features are included out of the box:</p>
							<div style="width:240px">
								<p style="font-size:9pt;margin:7px;">
								  <input type="checkbox" name="zutat" value="Reservation" checked disabled> Reservation    <span class="ui-icon ui-icon-info" style="float:right;"></span><br>
								  <input type="checkbox" name="zutat" value="Abo Reservation" checked disabled> Abo Reservation    <span class="ui-icon ui-icon-info" style="float:right;"></span><br>
								  <input type="checkbox" name="zutat" value="Administration" checked disabled> Administration    <span class="ui-icon ui-icon-info" style="float:right;"></span><br>
								  <input type="checkbox" name="zutat" value="Flexible Pricing" checked disabled> Flexible Pricing    <span class="ui-icon ui-icon-info" style="float:right;"></span><br>
								  <input type="checkbox" name="zutat" value="Statistics (basic)" checked disabled> Statistics (Basic)    <span class="ui-icon ui-icon-info" style="float:right;"></span><br>
								</p>
							</div>
							<div>
								<div style="width:240px;float:left;">
									<p style="font-size:9pt;margin:7px;">The calculated monthly basis fee is:
									</p>
									<p style="font-size:8pt;margin-left:7px;margin-top:3px;">(Calulated based on the number of selected courts)
									</p>
								</div>
								<div id="basispackageprice" style="margin-top:5px;float:left;">
								0 EUR
								</div>
							</div>
						</div>
					</div>
					<div id = "additionalfeatures">
						<div id="text" style="margin: 0 auto;width:300px;margin-top:10px;height:140px;border: solid 1px #b3b2b2;">
							<p style="font-size:9pt;margin:7px;">You can order the following features additionally:</p>
							<div style="width:240px;height:15px;float:left;">
								<p style="font-size:9pt;margin:7px;margin-top:0px;">
							  		<input type="checkbox" id="globalSearch" name="zutat" value="9" class="additionalFeature"  > Global search integration  <span class="ui-icon ui-icon-info" style="float:right;"></span>
							  	</p>
							</div>
							<div id="globalSearchPrice" style="margin-top:0px;visibility:hidden;">
								<p style="font-size:9pt;margin:7px;"> 9 EUR
								</p>
							</div>
							<div style="width:240px;height:15px;float:left;">
								<p style="font-size:9pt;margin:7px;margin-top:0px;">
							  		<input type="checkbox" id="globalActions" name="zutat" value="9" class="additionalFeature"  > Publish special offers  <span class="ui-icon ui-icon-info" style="float:right;"></span>
							  	</p>
							</div>
							<div id="globalActionsPrice" style="margin-top:0px;visibility:hidden;">
								<p style="font-size:9pt;margin:7px;"> 9 EUR
								</p>
							</div>
							<div style="width:240px;height:15px;float:left;">
								<p style="font-size:9pt;margin:7px;margin-top:0px;">
								  <input type="checkbox" name="zutat" id="messageBox" value="3" class="additionalFeature" > Message box  <span class="ui-icon ui-icon-info" style="float:right;"></span>
								</p>
							</div>
							<div id="messageBoxPrice" style="margin-top:0px;visibility:hidden;">
								<p style="font-size:9pt;margin:7px;"> 3 EUR
								</p>
							</div>
							<div style="width:240px;height:15px;float:left;">
								<p style="font-size:9pt;margin:7px;margin-top:0px;">
							  		<input type="checkbox" name="zutat" id="invitePlayers" class="additionalFeature" value="6" > Invite players functionality  <span class="ui-icon ui-icon-info" style="float:right;"></span>
							  	</p>
							</div>
							<div id="invitePlayersPrice" style="margin-top:0px;visibility:hidden;">
								<p style="font-size:9pt;margin:7px;"> 6 EUR
								</p>
							</div>
							<div style="width:240px;height:15px;float:left;">
								<p style="font-size:9pt;margin:7px;margin-top:0px;">
							  		<input type="checkbox" name="zutat" class="additionalFeature" id="statistics" value="6" > Additional statistics <span class="ui-icon ui-icon-info" style="float:right;"></span>
								</p>
							</div>
							<div id="statisticsPrice" style="margin-top:0px;visibility:hidden;">
								<p style="font-size:9pt;margin:7px;"> 6 EUR
								</p>
							</div>
						</div>
					</div>
					<div id = "save">
						<div id="text" style="margin: 0 auto;width:300px;margin-top:10px;border: solid 0px #b3b2b2;">
							<div id="placeholder" style="width:100%;height:20px;margin: 0 auto;margin-top:0px;">
							</div>
							<div style="width:200px;height:5px;float:left;margin-top:10px;">
								<p style="font-size:12pt;margin:7px;margin-top:0px;">
							  		Total Price per Month: 
								</p>
							</div>
							<div id="totalprice" style="margin-top:5px;">
								<p style="font-size:20pt;margin:0px;">0 EUR
								</p>
							</div>
							<div id="submitbutton" style="width:285px;margin: 0 auto;margin-top:10px;">
								<button style="width:100%;height:50px;background-color:#BCE954;color:white;font-size:20pt;font-weight:bold;">Give it a try!</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="footer" style="width:1024px;height:10px;border: solid 0px #b3b2b2;background-color:#BCE954;color:white;">
		</div>
	</div>
	<div id ='courtDialog' class="dialog">
		<div style="font-family: Verdana;font-size:9pt;margin-left:20px;margin-top:20px;margin-bottom:10px;width:900px;">Bitte geben Sie hier alle Daten für den Platz an, den Sie zu Ihrem Reservierungssystem hinzufügen möchten!
		</div>
		<div style="float:left;">
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:20px;">
				Platznummer
			</div>
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:20px;float:left;">
				<select id="courtnumber" size="1">
					      <option value="1">1</option>
					      <option value="2">2</option>
					      <option value="3">3</option>
					      <option value="4">4</option>
					      <option value="5">5</option>
					      <option value="6">6</option>
					      <option value="7">7</option>
					      <option value="8">8</option>
					      <option value="9">9</option>
					      <option value="10">10</option>
					      <option value="11">11</option>
					      <option value="12">12</option>
					      <option value="13">13</option>
					      <option value="14">14</option>
					      <option value="15">15</option>
					      <option value="16">16</option>
					      <option value="17">17</option>
					      <option value="18">18</option>
					      <option value="19">19</option>
					      <option value="20">20</option>
					      <option value="21">21</option>
					      <option value="22">22</option>
					      <option value="23">23</option>
					      <option value="24">24</option>
					    </select>
			</div>
		</div>
		<div style="float:left;">
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:20px;">
				Platzname
			</div>
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:20px;">	
				<input type="text" name="courtname" id="courtname" />
			</div>
		</div>
		<div style="float:left;">
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:10px;width:110px;">
				Platztyp
			</div>
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:10px;">
				<select id="courttype" size="1">
			      <option value="Tennis">Tennis</option>
			      <option value="Badminton">Badminton</option>
			      <option value="Squash">Squash</option>
			      <option value="Other">Other ...</option>
			    </select>
			</div>
		</div>
		<div style="float:left;">
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:10px;width:120px;">
				Frei/Hallenplatz
			</div>
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:10px;">
				<select id="indoor" size="1">
			      <option value="Outdoor">Freiplatz</option>
			      <option value="Indoor">Hallenplatz</option>
			    </select>
			</div>
		</div>
		<div>
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:10px;">
				Belag
			</div>
			<div style="font-family: Verdana;font-size:9pt;margin-top:5px;margin-left:10px;">
				<select id="surface" size="1">
			      <option value="Sand">Sand</option>
			      <option value="Granulat">Granulat</option>
			      <option value="Hardcourt">Hardcourt</option>
			      <option value="Other">Other ...</option>
			    </select>
			</div>
		</div>
		<div id="addCourtbutton" style="margin:20px;">
				<button id="addCourtButton" style="height:30px;align:center;">Add Court</button>
		</div>
	</div>
		<div id ='tariffDialog' class="dialog">
		<table style="margin:10px;">
			<tr>
				<td>Tarifname
				</td>
				<td><input type="text" name="tariffname" id="tariffname" />
				</td>
			</tr>
			<tr>
				<td>
					<p style="font-size:9pt;margin-bottom:0px;">Abo- oder<br>Einzeltarif
					</p>
				</td>
				<td>
					<p style="font-size:9pt;margin-bottom:0px;">Für Wen
					</p>
				</td>
				<td>
					<p style="font-size:9pt;margin-bottom:0px;">Am
					</p>
				</td>
				<td>
					<p style="font-size:9pt;margin-bottom:0px;">Im Zeitraum von<br> (Datum)
					</p>
				</td>
				<td>
					<p style="font-size:9pt;margin-bottom:0px;">Bis
					</p>
				</td>
				<td>
					<p style="font-size:9pt;margin-bottom:0px;">Zwischen<br> (Uhrzeit)
					</p>
				</td>
				<td>
					<p style="font-size:9pt;margin-bottom:0px;">Und
					</p>
				</td>
				<td>
					<p style="font-size:9pt;margin-bottom:0px;">Um
					</p>
				</td>
			</tr>
			<tr>
				<td>
					<select id="tarifftype" size="1">
					      <option value="single">Einzelstunden-Tarif</option>
					      <option value="abo">Abo-Tarif</option>
				    </select>
				</td>
				<td>
					<select id="targetgroup" size="1">
					      <option value="all">Für alle</option>
					      <option value="members">Für Vereinsmitglieder</option>
					      <option value="guests">Für Gäste</option>
				    </select>
				</td>
				<td>
					<select id="weekday" size="1">
					      <option value="all">Egal an welchem Tag</option>
					      <option value="monday">Montag</option>
					      <option value="tuesday">Dienstag</option>
					      <option value="wednesday">Mittwoch</option>
					      <option value="thursday">Donnerstag</option>
					      <option value="friday">Freitag</option>
					      <option value="saturday">Samstag</option>
					      <option value="sunday">Sonntag</option>
				    </select>
				</td>
				<td><input type="text" name="tariffname" id="tariffname" />
				</td>
				<td><input type="text" name="tariffname" id="tariffname" />
				</td>
				<td>
					<select id="timefrom" size="1">
					      <option value="">05:00</option>
					      <option value="">06:00</option>
					      <option value="">07:00</option>
					      <option value="">08:00</option>
					      <option value="">09:00</option>
					      <option value="">10:00</option>
					      <option value="">11:00</option>
					      <option value="">12:00</option>
					      <option value="">13:00</option>
					      <option value="">14:00</option>
					      <option value="">15:00</option>
					      <option value="">16:00</option>
					      <option value="">17:00</option>
					      <option value="">18:00</option>
					      <option value="">19:00</option>
					      <option value="">20:00</option>
					      <option value="">21:00</option>
					      <option value="">22:00</option>
					      <option value="">23:00</option>
				    </select>
				</td>
				<td>
					<select id="timefrom" size="1">
					      <option value="">06:00</option>
					      <option value="">07:00</option>
					      <option value="">08:00</option>
					      <option value="">09:00</option>
					      <option value="">10:00</option>
					      <option value="">11:00</option>
					      <option value="">12:00</option>
					      <option value="">13:00</option>
					      <option value="">14:00</option>
					      <option value="">15:00</option>
					      <option value="">16:00</option>
					      <option value="">17:00</option>
					      <option value="">18:00</option>
					      <option value="">19:00</option>
					      <option value="">20:00</option>
					      <option value="">21:00</option>
					      <option value="">22:00</option>
					      <option value="">23:00</option>
					      <option value="">24:00</option>
				    </select>
				</td>
				<td>
					<input type="text" name="price" id="price" size="5" style="width:30px;"/>
				</td>
				<td> EUR
				</td>
			</tr>
		</table>
		<div id="addTariffbutton" style="margin:10px;">
				<button id="addTariffButton" style="height:30px;align:center;">Add Tariff</button>
		</div>
	</div>
	<div id="schemeSelectionDialog" class="dialog" style="width:1022px;">
		<p style="font-size:9pt;margin-left:20px;margin-top:20px;margin-bottom:10px;font-family:Verdana;">Hier können Sie die Farben und Layoutelemente konfigurieren.
		</p>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
	</div>
</body>
</html>