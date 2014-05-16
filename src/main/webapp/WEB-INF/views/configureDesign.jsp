<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<html>
    <head>
        <c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
        
        <link type="text/css" href="${contextPath}/resources/css/custom-theme/jquery-ui-1.9.1.custom.css" rel="stylesheet" />
        <link type="text/css" href="${contextPath}/resources/css/style.css" rel="stylesheet" />
        <link type="text/css" href="${contextPath}/resources/css/instance/instancestyle-${sessionScope.cpInstanceId}.css" rel="stylesheet" />
        <script src="${contextPath}/resources/js/jquery-1.8.2.js"></script>
        <script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.min.js"></script>
        <script src="${contextPath}/resources/js/jquery.tablesorter.js"></script>     
        <script src="${contextPath}/resources/js/json2.js"></script>
        <script src="${contextPath}/resources/js/jquery.validate.min.js"></script>
        <script src="${contextPath}/resources/js/jscolor/jscolor.js"></script>

        <script>
        	var cpInstanceId = ${sessionScope.cpInstanceId};
        	var contextPath = "${contextPath}";
			var webdesign;
			var webdesignFile;
			
			$(document).ready(function() {
				// used for correct preview of wochenansicht / detailansicht
            	$("#reservationViewSelection").buttonset();

				webdesign = getWebdesign(cpInstanceId);
				populateDesignForm(webdesign);
				
				loadReservationViewHtml();
							
				var css = createWebdesignCss(webdesign);
				applyCss(css);
				
				$("#logo_upload").on("load", function() {
					var imgUrl = $("#logo_upload").contents().find("body").find("pre").html();
					// remove quotes around url
					imgUrl = imgUrl.substring(1, imgUrl.length - 1);
					var currentDate = new Date();
					$("#headerLogoImg").attr("src", contextPath + imgUrl + "?" + currentDate.getTime());
				});
			});
			
			$(document).on("change", "#designForm input", function() {
				applyCurrentDesign();
			});

			$(document).on("change", "#logoForm input", function() {
				$("#logoForm").submit();
			});
									
            function WebDesign(id, cpInstanceId, backgroundStyle, backgroundColor, headerColor, headerBackgroundColor, 
            				   controlsColor, contentColor, contentBackgroundColor, ctSelectColor, ctSelectBackgroundColor,
            				   ctSelectFocusColor, linkColor, reservableHourColor, nonReservableHourColor, footerColor) {
                this.id = id;
                this.cpInstanceId = cpInstanceId;
                this.backgroundStyle = backgroundStyle;
                this.backgroundColor = backgroundColor;
                this.headerColor = headerColor;
                this.headerBackgroundColor = headerBackgroundColor;
                this.controlsColor = controlsColor;
                this.contentColor = contentColor;
                this.contentBackgroundColor = contentBackgroundColor;
                this.ctSelectColor = ctSelectColor;
                this.ctSelectBackgroundColor = ctSelectBackgroundColor;
                this.ctSelectFocusColor = ctSelectFocusColor;
                this.linkColor = linkColor;
                this.reservableHourColor = reservableHourColor;
                this.nonReservableHourColor = nonReservableHourColor;
                this.footerColor = footerColor;
            }

            function getWebdesign(cpInstanceId) {
            	var wd = null;
            	
            	$.ajax({
            		type: "GET",
            		url: "api/getWebdesign?cpInstanceId=" + cpInstanceId,
            		data: "",
            		contentType: "text/html; charset=utf-8",
            	    dataType: "json",
            	    async: false,
            	    success: function(data) {
            	    	wd = data;
            	    },
            	    failure: function(errMsg) {
            	        alert(errMsg);
            	    }
            	});
            	
            	return wd;
            }
            
            function createWebdesignCss(webdesign) {
            	var css = null;
            	
            	$.ajax({
            		type: "POST",
            		url: "api/createWebdesignCss",
            		data: JSON.stringify(webdesign),
            		contentType: "application/json; charset=utf-8",
            	    dataType: "json",
            	    async: false,
            	    success: function(data) {
            	    	css = data;
            	    },
            	    failure: function(errMsg) {
            	        alert(errMsg);
            	    }
            	});
            	
            	return css;
            }   
            
            function loadReservationViewHtml() {
            	$.get('reservationView.htm', function(data) {
            		$('#base').html(data);
            	});
            }
            
//             function getWebdesignFile(webdesignId, type) {
//             	var wdf = null;
            	
//             	$.ajax({
//             		type: "GET",
//             		url: "api/getWebdesignFile?webdesignId=" + webdesignId + "&type=" + type,
//             		data: "",
//             		contentType: "text/html; charset=utf-8",
//             	    dataType: "json",
//             	    async: false,
//             	    success: function(data) {
//             	    	wdf = data;
//             	    },
//             	    failure: function(errMsg) {
//             	        alert(errMsg);
//             	    }
//             	});
            	
//             	return wdf;
//             }
            
            function populateDesignForm(webdesign) {
            	// general
            	if (webdesign.backgroundStyle == 'TEXTURED') {
            		setCheckedOnRadioInput('designForm', 'backgroundstyle', 'TEXTURED');
            		hideSolidBackgroundSettings();
            	}
            	else {
            		setCheckedOnRadioInput('designForm', 'backgroundstyle', 'SOLID');
            		showSolidBackgroundSettings();
            	}
            	$('#backgroundcolor').val(webdesign.backgroundColor);
            	
            	// logo
            	$('#logowebdesignid').val(webdesign.id);
            	
            	// other elements
            	$('#headerbackgroundcolor').val(webdesign.headerBackgroundColor);
            	$('#headercolor').val(webdesign.headerColor);
            	$('#controlscolor').val(webdesign.controlsColor);
            	$('#contentcolor').val(webdesign.contentColor);
            	$('#contentbackgroundcolor').val(webdesign.contentBackgroundColor);
            	$('#ctselectcolor').val(webdesign.ctSelectColor);
            	$('#ctselectbackgroundcolor').val(webdesign.ctSelectBackgroundColor);
            	$('#footercolor').val(webdesign.footerColor);      
            	$('#ctselectfocuscolor').val(webdesign.ctSelectFocusColor);
            	$('#linkcolor').val(webdesign.linkColor);
            	$('#reservablehourcolor').val(webdesign.reservableHourColor);
            	$('#nonreservablehourcolor').val(webdesign.nonReservableHourColor);
            }
            
            function applyCurrentDesign() {
            	webdesign.backgroundStyle = $('#designForm input[name=backgroundstyle]:checked').val();
            	webdesign.backgroundColor = $('#backgroundcolor').val();
            	webdesign.headerBackgroundColor = $('#headerbackgroundcolor').val();
            	webdesign.headerColor = $('#headercolor').val();
            	webdesign.controlsColor = $('#controlscolor').val();
            	webdesign.contentColor = $('#contentcolor').val();
            	webdesign.contentBackgroundColor = $('#contentbackgroundcolor').val();
            	webdesign.ctSelectColor = $('#ctselectcolor').val();
            	webdesign.ctSelectBackgroundColor = $('#ctselectbackgroundcolor').val();
            	webdesign.footerColor = $('#footercolor').val();
            	webdesign.ctSelectFocusColor = $('#ctselectfocuscolor').val();
            	webdesign.linkColor = $('#linkcolor').val();
            	webdesign.reservableHourColor = $('#reservablehourcolor').val();
            	webdesign.nonReservableHourColor = $('#nonreservablehourcolor').val();
            	
            	var css = createWebdesignCss(webdesign);
            	applyCss(css);
            }
            
            function applyCss(css) {
            	$('#styles').html(css);
            }
            
            function setCheckedOnRadioInput(formId, inputName, checkedValue) {
        		$('#' + formId + ' input[name=' + inputName + ']').each(function() {
        			if (jQuery(this).val() == checkedValue) {
        				jQuery(this).attr('checked', true);
        			}
        			else {
        				jQuery(this).attr('checked', false);
        			}
        		});            	
            }
            
            function hideSolidBackgroundSettings() {
                if ($("#solidBackgroundSettings").css("display") != "none") {
                	$("#solidBackgroundSettings").toggle("blind");
                }
            }

            function showSolidBackgroundSettings() {
                if ($("#solidBackgroundSettings").css("display") == "none") {
                	$("#solidBackgroundSettings").toggle("blind");
                }
            }

            
            function headerlogoUploadDone() {
            	
            	//alert("done");
            }
            
            function getFrameByName(name) {
            	  for (var i = 0; i < frames.length; i++)
            	    if (frames[i].name == name)
            	      return frames[i];
            	 
            	  return null;
            	}
        </script>
        
        <style type="text/css" id="styles">
        </style>
    </head>
    
    <body>
        <!-- DESIGN MENU -->
        
        <h3>Configure Design</h3>
        <div id="designConfig" class="designConfig">
            <!-- own form for logo -->
            <div id="designConfigLogo" class="designConfigSection">
                <h4>Header Logo</h4>
                <form id="logoForm" action="upload/webdesignfile" method="post" enctype="multipart/form-data" target="logo_upload">
                    (Empfohlenes Format: 100x100 Pixel) <br/>
                    <input type="file" name="logofile" id="logofile" size="50" accept="image/*"/>
                    <input type="hidden" name="logowebdesignid" id="logowebdesignid" value=""/>
                    <input type="hidden" name="logotype" id="logotype" value="logo"/>
                    <iframe id="logo_upload" name="logo_upload" src="" style="width:0;height:0;border:0px solid #fff">
                    </iframe>
                </form>
            </div>
                       
            <!-- other design settings -->
            <form id="designForm">
                <div id="designConfigHeader" class="designConfigSection">
                    <h4>Header Design</h4>
                    <label for="headerbackgroundcolor">Hintergrund:</label>
                    <input id="headerbackgroundcolor" type="text" name="headerbackgroundcolor" class="color"/>
                    <br/>
                    <label for="headercolor">Schrift:</label>
                    <input id="headercolor" type="text" name="headercolor" class="color"/>
                </div>
                <div id="designConfigGeneral" class="designConfigSection">
                    <h4>Basis Einstellungen</h4>
                    <label for="backgroundstyle">Hintergrundart:</label> <br>
                    <input type="radio" name="backgroundstyle" value="TEXTURED" 
                           onclick="hideSolidBackgroundSettings();"> Textured<br>
                    <input type="radio" name="backgroundstyle" value="SOLID" checked="checked" 
                           onclick="showSolidBackgroundSettings();"> Solid<br>
                    <div id="solidBackgroundSettings">
                        <label for="backgroundcolor">Hintergrundfarbe</label>
                        <input id="backgroundcolor" type="text" name="backgroundcolor" class="color"/>
                    </div>
                    <label for="linkcolor">Link Farbe:</label>
                    <input id="linkcolor" type="text" name="linkcolor" class="color"/> <br/>                    
                    <label for="footercolor">Fußzeile Farbe:</label>
                    <input id="footercolor" type="text" name="footercolor" class="color"/>                    
                </div>
                <div id="designConfigControls" class="designConfigSection">
                    <h4>Kontroll Elemente</h4>
                    <label for="controlscolor">Button Farbe:</label>
                    <input id="controlscolor" type="text" name="controlscolor" class="color"/> <br/>
                    <label for="ctselectcolor">Platzart Auswahl Farbe:</label>
                    <input id="ctselectcolor" type="text" name="ctselectcolor" class="color"/>
                    <label for="ctselectbackgroundcolor">Platzart Auswahl Hintergrund:</label>
                    <input id="ctselectbackgroundcolor" type="text" name="ctselectbackgroundcolor" class="color"/>
                    <label for="ctselectfocuscolor">Platzart Auswahl Focus Farbe:</label>
                    <input id="ctselectfocuscolor" type="text" name="ctselectfocuscolor" class="color"/>                                    
                </div>
                <div id="designConfigContent" class="designConfigSection">
                    <h4>Content</h4>
                    <label for="contentbackgroundcolor">Hintergrund:</label>
                    <input id="contentbackgroundcolor" type="text" name="contentbackgroundcolor" class="color"/>                
                    <label for="contentcolor">Schrift:</label>
                    <input id="contentcolor" type="text" name="contentcolor" class="color"/>
                    <br/>
                    <label for="nonreservablehourcolor">Farbe nicht reservierbare Stunden:</label>
                    <input id="nonreservablehourcolor" type="text" name="nonreservablehourcolor" class="color"/>                    
                    <label for="reservablehourcolor">Farbe reservierbare Stunden:</label>
                    <input id="reservablehourcolor" type="text" name="reservablehourcolor" class="color"/>
                </div>
            </form>
        </div>
    
        <!-- PREVIEW -->
        
        <div id="paddedContent">            
            <div id="header">
                <div id="headerContent">
                    <div id="headerLogo">
                        <a href=""><img id="headerLogoImg" src='${contextPath}/resources/css/images/tckLogoScaled.png' style="width: 100px;"/></a>
                    </div>
                    
                    <!-- authentication -->
                    <div id="headerLogin">
                        <!-- login -->
            			<div id="loginbutton" class="button" style="width: 100px; margin: 4px auto; margin-bottom: 0;">Login</div>
                        
                        <!-- user registration -->
            			<a href="" id="registrationMenuItem" style="margin-left: 22px;" class="smallFont">Neuer Benutzer?</a>             	
                    </div>
                            
                    <div id="headerText">
                        <h1 style="display: inline;">TC Kalksburg CourtPicker</h1>
                    </div>
                </div>
            </div>
            
            <div id="customerLinks">
            	<a href="">
            		<div class="buttonThinRound mediumFont" style="margin-top: 3px;">
            			Kundenbereich <b>&gt;</b>
            		</div>
            	</a>
            	<a href="">
            		<div class="buttonThinRound mediumFont" style="margin-top: 3px;">
            			Adminbereich <b>&gt;</b>
            		</div>
            	</a>
            </div>
            
            <div style="clear: both;"></div>
            
			<div id="mainframe">
                <div id="courtTypeSelect">
                    <ul>
                        <li id="courtType1" class="selectedCourtType">Tennis Halle</li>
                        <li id="courtType2">Tennis Outdoor</li>
                        <li id="courtType3">Fußball</li>
                        <li id="courtType4">Squash</li>
                    </ul>
                </div>
                
                <div id="paddedContent">                    
                    <div id="reservationViewSelection">
                        <input type="radio" id="weekView" name="radio" checked="checked"/><label for="weekView" style="margin-left: 50px;" title="In dieser Ansicht sehen Sie, ob auf der Anlage überhaupt freie Stunden vorhanden sind (egal auf welchem Platz)">Wochenübersicht</label>
                        <input type="radio" id="dayView" name="radio" /><label for="dayView" style="margin-left: 400px;" title="In dieser Ansicht sehen Sie die Belegung einzelner Plätze.">Tagesdetail</label>
                    </div>
                    
                    <div id="reservationDatePicker">
                        <div id="pagebuttonleft" class="button" style="width: 20px; float: left;">&lt;</div>
                        <input type="text" id="dateselector" name="date" size="10" value="01.01.2013" />
                        <div id="pagebuttonright" class="button" style="width: 20px; float: right;">&gt;</div>
                    </div>
                    
                    <div id = "content">
                    	<div id="base">	
                    	</div>	
                    </div>
                    
<!--                     <div id="legend"> -->
<!--                     	Freie Stunden: -->
<!--                     	<div class="notreserved-color-1 legend-element">10 EUR</div> -->
<!--                     	<div class="notreserved-color-2 legend-element">15 EUR</div> -->
<!--                         <br/> Reserviert: -->
<!--                         <div class="reserved-color legend-element">reserviert</div> -->
<!--                         <div class="reserved-by-me-color legend-element">meine Reservierung</div> -->
<!--                         <div class="abo-color legend-element">Abo reserviert</div> -->
<!--                         <div class="my-abo-color legend-element">mein Abo</div> -->
<!--                     </div> -->
    			</div>
            </div>
            
			<div id="footer">
				TC Kalksburg - Zangerlestrasse/Sportplatz, 1230 Wien, 
                e-mail: <a href="">tennis@tckalksburg.at</a>, Tel: 01/888 69 60 
                Web: <a href="">http://www.tckalksburg.at</a>
			</div>
        </div>
    </body>
</html>


