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
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

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
      <div class="container" style="margin-bottom:0px!important;">
        <div class="navbar navbar-inverse navbar-static-top" role="navigation" style="margin-bottom:0px!important;">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand active" href="index.htm"><font color="white">CourtPicker</font></a>
            </div>
            <div class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
<!--                <li class="active"><a href="index.htm">Home</a></li>-->
                <li><a href="benefits.htm">Vorteile</a></li>
                <li class="dropdown">
                  <a href="features.htm" class="dropdown-toggle" data-toggle="dropdown disabled">Funktionalitäten<b class="caret"></b></a>
                  <ul class="dropdown-menu">
<!--                    <li class="divider"></li>-->
                    <li class="dropdown-header">Online-Konfiguration</li>
                    <li><a href="features.htm#courtconfig">Konfiguration von Platzkategorien und Plätzen</a></li>
                    <li><a href="features.htm#reservationconfig">Deine eigenen Reservierungskategorien</a></li>
                    <li><a href="features.htm#priceconfig">Flexible Tarifeinstellungen für jede Platzkategorie</a></li>
                    <li><a href="features.htm#layoutconfig">Eigenes Layout für Deinen CourtPicker</a></li>
                    <li><a href="features.htm#userconfig">Mehrstufiges Berechtigungskonzept</a></li>
<!--                    <li><a href="features.htm#integration">Integration in Deine Homepage</a></li>-->
                    <li class="divider"></li>
                    <li class="dropdown-header">Reservierungsfunktionalitäten</li>
                    <li><a href="features.htm#combinedweekview">Kombinierte Wochenansicht</a></li>
                    <li><a href="features.htm#dayview">Tagesansicht</a></li>
                    <li><a href="features.htm#reservation">Einzel- und Aboreservierungen</a></li>
                    <li><a href="features.htm#emails">Email-Bestätigungen</a></li>
                    <li><a href="features.htm#customerarea">Eigener Benutzerbereich für Deine Kunden</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-header">Administrationsfunktionalitäten</li>
                    <li><a href="features.htm#payment">Bezahlstatus von Reservierungen verwalten</a></li>
                    <li><a href="features.htm#closure">Tagesabschluss auf Knopfdruck</a></li>
                    <li><a href="features.htm#statistics">Statistiken</a></li>
                    <li><a href="features.htm#search">Reservierungssuche und Excel-Export</a></li>
                    <li><a href="features.htm#settings">Hilfreiche Settings</a></li>
<!--                    <li class="divider"></li>-->
                  </ul>
                </li>
                <li><a href="pricelist.htm">Preise</a></li>
<!--                <li><a href="http://localhost:8080/app/cp.html#/configureCourts?createNew">Try now!</a></li>-->
                <li><a href="ueberuns.htm">Über Uns</a></li>
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
    	<h1>Kontakt</h1> 
    	<hr class="divider">
    	
		  <p>Du hast Interesse an CourtPicker, Fragen, Anregungen oder willst aus einem anderen Grund mit uns Kontakt aufnehmen? Dann kannst Du folgendes Formular verwenden, um uns eine Nachricht zukommen zu lassen.</p>
		   	<form class="form-horizontal" role="form" action="MAILTO:matthiasheindl@gmx.at" method="post" enctype="text/plain">  
		    <div class="form-group">
<!--		    	<label for="inputPassword3" class="col-sm-1 control-label">Betreff</label>-->
		    	<div class="col-sm-12">
		      		<input type="text" class="form-control" id="inputEmail3" placeholder="Dein Name">
		    	</div>
		  	</div>
		    <div class="form-group">
<!--		   	 	<label for="inputEmail3" class="col-sm-1 control-label">Email</label>-->
		    	<div class="col-sm-12">
		     		 <input type="email" class="form-control" id="inputEmail3" placeholder="Deine Email-Adresse">
		    	</div>
		  	</div>
		 	<div class="form-group">
<!--		    	<label for="inputPassword3" class="col-sm-1 control-label">Betreff</label>-->
		    	<div class="col-sm-12">
		      		<input type="text" class="form-control" id="inputEmail3" placeholder="Betreff">
		    	</div>
		  	</div>
		  	<div class="form-group">
<!--			    <label for="inputPassword3" class="col-sm-1 control-label">Text</label>-->
		    	<div class="col-sm-12">
			    	<textarea class="form-control" rows="5" placeholder="Nachricht"></textarea>
		    	</div>
		    </div>
			<div class="form-group">
			    <div class="col-sm-10">
			      <button type="submit" class="btn btn-primary">Senden</button>
			      <button type="reset" class="btn btn-default">Zurücksetzen</button>
			    </div>
		  	</div>
			
		    </form> 
    	
    	
    	  
      <!-- FOOTER -->
      <hr class="divider">
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2014 CourtPicker &middot; <a href="agb.htm">AGB</a> &middot; <a href="datasecuritystatement.htm">Datenschutzerklärung</a> &middot; <a href="contact.htm">Kontakt</a></p>
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
