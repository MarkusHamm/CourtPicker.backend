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
	<link href="${contextPath}/resources/css/social-buttons.css" rel="stylesheet" />
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
  </head>
<!-- NAVBAR
================================================== -->
  <body>
    <div class="navbar-wrapper">
      <div class="container">
        <div class="container">
          <div class="navbar navbar-inverse navbar-static-top" role="navigation">
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
                <li><a href="benefits.htm">Vorteile</a></li>
                <li class="dropdown">
                  <a href="features.htm" class="dropdown-toggle" data-toggle="dropdown disabled">Funktionalitäten<b class="caret"></b></a>
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

    <div class="container text-justify">
	    <div class="row">
			 <div class="col-md-6"><h1>Über Uns</h1>
			 </div>
			 <div class="col-md-6"><span class="pull-right"><br><a class="btn btn-success" href="http://5.45.104.233/createnew/#/configureCourts" role="button">Meinen CourtPicker jetzt ausprobieren &raquo;</a></span>
			 </div>
		</div> 
	    <hr class="divider"> 
	    	
			<h2>Geschichte</h2>
			<p>Ursprünglich fing alles mit einem kleinen Reservierungssystem an, das Matthias für einen Tennisclub entwickelte.  
			Bevor das Reservierungssystem eingeführt wurde, musste man, um eine Stunde zu reservieren, beim Vereinskassier anrufen und nach einer freien Stunde fragen. 
			Der Kassier gab dann freie Zeiten durch und nahm die Reservierung entgegen. 
			Es gab für Mitglieder und Gäste keine Möglichkeit die Platzbelegung in aktueller Form einzusehen und eigenständig Stunden zu reservieren.
		 	</p>
		 	<p>Das Reservierungssystem war sehr einfach, es verwaltete nur einen Platz und hatte ein ganz einfaches Tarifsystem. 
		 	Das Feedback über den Einsatz des Reservierungssystem in diesem Tennisclub fiel trotzdem sehr positiv aus.
		 	Durch die Veröffentlichung der Platzbelegung im Internet war es nun Mitgliedern und Gästen möglich, sich schnell einen Überblick über freie Stunden zu verschaffen und selbständig Reservierungen durchzuführen.
		 	Die Zahl der Einzelreservierungen konnte im Vergleich zur telefonischen Variante davor erheblich gesteigert werden. 
		 	</p>
		 	<p>Über die Zeit reifte dann die Idee, diesen einfachen "Prototyp" zu einem hoch-konfigurierbaren Produkt weiterzuentwickeln, dem CourtPicker. 
		 	Maßgeblichen Anteil an dieser Weiterentwicklung hat Markus, ein ehemaliger Arbeitskollege von Matthias, der das Reservierungssystem sowohl technisch als auch optisch auf solidere Beine stellte.
		 	Damit sind wir nun in der Lage, Dir CourtPicker anbieten zu können.
		 	</p>
		 	<p class="lead">Verschaffe Dir auf diesen Seiten einen Überblick über CourtPicker und probier' ihn einfach aus!
		 	</p>

			<hr class="divider"> 
			<h2>Team</h2>
		
	
		    <div class="row featurette">
		    	<div class="col-md-2">
		          	<img class="featurette-image img-responsive" src="${contextPath}/resources/images/MaHe.jpg" alt="Generic placeholder image" width="150px;">
		        </div>
		        <div class="col-md-9">
		          <h2 class="featurette-heading">Matthias Heindl. <span class="text-muted">Leidenschaftlicher Tennisspieler.</span></h2>
		          <p class="lead">"CourtPicker soll sowohl kleinen Sportvereinen als auch großen Sportanlagen die Verwaltung von Reservierungen erleichtern."</p>
		          <p>Matthias Heindl hat Informatik studiert und arbeitet seit Jahren in der IT. Er hat einen sehr starken Bezug zum Tennis, spielt er doch seit Jahren mit dem TC Kalksburg in der Wiener Landesliga.</p>
		        	<button class="btn btn-xing" onclick="window.open('https://www.xing.com/profile/Matthias_Heindl');"><i class="fa fa-xing"></i> | Connect with XING</button>
		        	<button class="btn btn-facebook"  onclick="window.open('https://www.facebook.com/matthias.heindl.12');"><i class="fa fa-facebook"></i> | Connect with Facebook</button><br>
		        </div>
		   	</div>
	
	      	<hr class="featurette-divider">
	
	      	<div class="row featurette">
		        <div class="col-md-2">
		          <img class="featurette-image img-responsive" src="${contextPath}/resources/images/MaHa2.jpg" alt="Generic placeholder image" width="150px;">
		        </div>
		        <div class="col-md-9">
		          <h2 class="featurette-heading">Markus Hamm. <span class="text-muted">See for yourself.</span></h2>
		          <p class="lead">tbd.</p>
		          <p>tbd.</p>
		          <button class="btn btn-xing" onclick="window.open('https://www.xing.com/profile/Markus_Hamm7');"><i class="fa fa-xing"></i> | Connect with XING</button>
		         </div>
		   	</div>

	
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
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
  </body>
</html>
