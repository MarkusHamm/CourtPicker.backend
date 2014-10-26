<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${contextPath}/favicon.ico" type="image/x-icon">
  	<link rel="shortcut icon" href="${contextPath}/favicon.ico" type="image/x-icon">

    <title>CourtPicker</title>
	<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
    <!-- Bootstrap core CSS -->
    <link href="../../dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- bootstrap -->
	<link href="${contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
  </head>
<!-- NAVBAR
================================================== -->
  <body>
    <div class="navbar-wrapper">
      <div class="container">
        <div class="navbar navbar-inverse navbar-static-top" role="navigation">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="index.htm">CourtPicker</a>
            </div>
            <div class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
	<!--                <li class="active"><a href="index.htm">Home</a></li>-->
	                <li><a href="benefits.htm"><spring:message code="menubar.benefits"/></a></li>
	                <li class="dropdown">
	                  <a href="features.htm" class="dropdown-toggle" data-toggle="dropdown disabled"><spring:message code="menubar.features"/><b class="caret"></b></a>
	                  <ul class="dropdown-menu">
	<!--                    <li class="divider"></li>-->
	                     <li class="dropdown-header">Online-Konfiguration</li>
                    <li><a href="features.htm#courtconfig">Konfiguration von Platzkategorien und Plätzen</a></li>
<!--                    <li><a href="features.htm#reservationconfig">Deine eigenen Reservierungskategorien</a></li>-->
                    <li><a href="features.htm#priceconfig">Flexible Tarifeinstellungen für jede Platzkategorie</a></li>
                    <li><a href="features.htm#layoutconfig">Eigenes Layout für Deinen CourtPicker</a></li>
<!--                    <li><a href="features.htm#integration">Integration in Deine Homepage</a></li>-->
                    <li class="divider"></li>
                    <li class="dropdown-header">Reservierungsfunktionalitäten</li>
                    <li><a href="features.htm#combinedweekview">Kombinierte Wochenansicht</a></li>
                    <li><a href="features.htm#dayview">Tagesansicht</a></li>
                    <li><a href="features.htm#reservation">Einzel- und Aboreservierungen</a></li>
<!--                    <li><a href="features.htm#emails">Email-Bestätigungen</a></li>-->
                    <li><a href="features.htm#customerarea">Eigener Benutzerbereich für Deine Kunden</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-header">Administrationsfunktionalitäten</li>
                    <li><a href="features.htm#userconfig">Mehrstufiges Berechtigungskonzept</a></li>
                    <li><a href="features.htm#payment">Bezahlstatus von Reservierungen verwalten</a></li>
                    <li><a href="features.htm#closure">Tagesabschluss auf Knopfdruck</a></li>
<!--                    <li><a href="features.htm#statistics">Statistiken</a></li>-->
<!--                    <li><a href="features.htm#search">Reservierungssuche und Excel-Export</a></li>-->
<!--                    <li><a href="features.htm#settings">Hilfreiche Settings</a></li>-->
<!--                    <li class="divider"></li>-->
                  </ul>
	                </li>
	                	<li class="active"><a href="pricelist.htm"><spring:message code="menubar.prices"/></a></li>
	<!--                <li><a href="http://localhost:8080/app/cp.html#/configureCourts?createNew">Try now!</a></li>-->
<!--	                <li><a href="ueberuns.htm"><spring:message code="menubar.about"/></a></li>-->
						<li><a href="references.htm"><spring:message code="menubar.references"/></a></li>
						<li><a href="contact.htm"><spring:message code="menubar.contact"/></a></li>
	              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
	
    <!-- Marketing messaging and featurettes
    ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->

    <div class="container text-justify">
   		<div class="row">
			 <div class="col-md-6"><h1><spring:message code="prices.title"/> <small><spring:message code="prices.subtitle"/></small></h1>
			 </div>
			 <div class="col-md-6"><span class="pull-right"><br><a class="btn btn-primary" href="http://www.courtpicker.com/createnew/#/configureCourts" role="button"><spring:message code="index.tryOut.button"/> &raquo;</a></span>
			 </div>
		</div>  
		<hr class="divider">
		<p><spring:message code="prices.text"/>
		<br>
		<br>
		</p>
			<table class="table table-hover">
 				<tr class="active">
 					<th><spring:message code="prices.courtNumber"/>
 					</th>
 					<th>1
 					</th>
 					<th>2
 					</th>
 					<th>3
 					</th>
 					<th>4
 					</th>
 					<th>5
 					</th>
 					<th>6
 					</th>
 					<th>7
 					</th>
 					<th>8
 					</th>
 					<th>9
 					</th>
 					<th>10
 					</th>
 				</tr>
 				<tr>
 					<td><spring:message code="prices.price"/>
 					</td>
 					<td>20 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>24 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>28 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>32 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>36 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>42 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>48 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>54 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>60 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>66 <font style="font-size:10px;">EUR</font>
 					</td>
 				</tr>
 				<tr class="active">
 					<th><spring:message code="prices.courtNumber"/>
 					</th>
 					<th>11
 					</th>
 					<th>12
 					</th>
 					<th>13
 					</th>
 					<th>14
 					</th>
 					<th>15
 					</th>
 					<th>16
 					</th>
 					<th>17
 					</th>
 					<th>18
 					</th>
 					<th>19
 					</th>
 					<th>20
 					</th>
 				</tr>
 				<tr>
 					<td><spring:message code="prices.price"/>
 					</td>
 					<td>74 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>82 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>90 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>98 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>106 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>114 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>122 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>130 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>138 <font style="font-size:10px;">EUR</font>
 					</td>
 					<td>146 <font style="font-size:10px;">EUR</font>
 					</td>
 				</tr>
 			</table>
			<p><spring:message code="prices.helpText"/>
			</p>

      <!-- FOOTER -->
	      <hr class="divider">
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2014 CourtPicker &middot; <a href="agb.htm">AGB</a> &middot; <a href="datasecuritystatement.htm">Datenschutzerklärung</a></p>
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
