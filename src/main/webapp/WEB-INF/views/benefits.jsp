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
      <div class="navbar navbar-inverse navbar-static-top" role="navigation">
        <div class="container">
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
<!--                <li><a href="index.htm">Home</a></li>-->
                <li class="active"><a href="benefits.htm"><spring:message code="menubar.benefits"/></a></li>
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
	                <li><a href="pricelist.htm">Preise</a></li>
<!--                <li><a href="http://localhost:8080/app/cp.html#/configureCourts?createNew">Try now!</a></li>-->
<!--                <li><a href="ueberuns.htm">Über Uns</a></li>-->
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

    <div class="container">
   		<div class="row">
			 <div class="col-md-6"><h1><spring:message code="benefits.title"/></h1>
			 </div>
			 <div class="col-md-6"><span class="pull-right"><br><a class="btn btn-primary" href="/configurator" role="button"><spring:message code="index.tryOut.button"/> &raquo;</a></span>
			 </div>
		</div>  
      
    	<hr class="divider">
    	
    	<div class="row">
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="height:275px;">
		      <div class="caption">
		        <h3><spring:message code="benefit1.title"/></h3>
		        <p class="lead"><spring:message code="benefit1.lead"/></p><p><spring:message code="benefit1.text"/></p>
		       </div>
		    </div>
		  </div>
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="height:275px;">
		      <div class="caption">
		        <h3><spring:message code="benefit2.title"/></h3>
		        <p class="lead"><spring:message code="benefit2.lead"/></p><p><spring:message code="benefit2.text"/></p>
		       </div>
		    </div>
		  </div>
		   <div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="height:275px;">
		      <div class="caption">
		        <h3><spring:message code="benefit3.title"/></h3>
		        <p class="lead"><spring:message code="benefit3.lead"/></p><p><spring:message code="benefit3.text"/><br><br><br></p>
		       </div>
		    </div>
		  </div>
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="height:275px;">
		      <div class="caption">
		        <h3><spring:message code="benefit4.title"/></h3>
		        <p class="lead"><spring:message code="benefit4.lead"/></p><p><spring:message code="benefit4.text"/></p>
		       </div>
		    </div>
		  </div>
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="height:275px;">
		      <div class="caption">
		        <h3><spring:message code="benefit5.title"/></h3>
		        <p class="lead"><spring:message code="benefit5.lead"/></p><p><spring:message code="benefit5.text"/></p>
		       </div>
		    </div>
		  </div>
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="height:275px;">
		      <div class="caption">
		        <h3><spring:message code="benefit6.title"/></h3>
		        <p class="lead"><spring:message code="benefit6.lead"/></p><p><spring:message code="benefit6.text"/></p>
		       </div>
		    </div>
		  </div>
		   <div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="height:275px;">
		      <div class="caption">
		        <h3><spring:message code="benefit7.title"/></h3>
		        <p class="lead"><spring:message code="benefit7.lead"/></p><p><spring:message code="benefit7.text"/></p>
		       </div>
		    </div>
		  </div> 
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="height:275px;">
		      <div class="caption">
		        <h3><spring:message code="benefit8.title"/></h3>
		       <p class="lead"><spring:message code="benefit8.lead"/></p><p><spring:message code="benefit8.text"/></p>
		       </div>
		    </div>
		  </div>
		  <div class="col-sm-6 col-md-4">
		    <div class="thumbnail" style="background-color:#428bca;height:275px;">
		      <div class="caption">
		      	<h3>  </h3>
		      		<p class="lead"><br></p>
		        	<br><br><br><br><br><br><br><br>
		       </div>
		    </div>
		  </div> 
<!--		  <div class="col-sm-6 col-md-4">-->
<!--		    <div class="thumbnail">-->
<!--		      <div class="caption">-->
<!--		        <h3>CourtPicker-Portal inklusive.</h3>-->
<!--		        <p class="lead">Eigenes Reservierungssystem und auch im CourtPicker-Portal.</p><p>CourtPicker bietet Dir nicht nur Dein eigenes Reservierungssystem. Du bist mit Deiner Anlage dann auch im CourtPicker-Portal vertreten. Deine Anlage kann dort für Reservierungen gefunden werden.</p>-->
<!--		       </div>-->
<!--		    </div>-->
<!--		  </div> -->
		 </div>
				
    	  
      <!-- FOOTER -->
      <hr class="divider">
      <footer>
        <p class="pull-right"><a href="#">Nach oben</a></p>
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
