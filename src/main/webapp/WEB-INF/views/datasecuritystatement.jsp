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
              <a class="navbar-brand" href="index.htm"><font color="white">CourtPicker</font></a>
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
    	<h1>CourtPicker - Datenschutzerklärung</h1>
    	<hr class="divider">
			Unser Unternehmen, nachstehend CourtPicker genannt, geht mit Ihren persönlichen Daten sehr verantwortungsvoll um 
			und die nachstehende Datenschutzerklärung soll Ihnen einen Überblick geben, was mit den Daten passiert und welche Schutz wir anbieten.
			<br>
			<h2>1. Gegenstand der Datenschutzerklärung</h2>
			Diese Erklärung bezieht sich auf die Daten, die durch den Besuch unserer Webseite bekannt werden und informiert darüber, 
			wie mit den Daten umgegangen wird. Ein Datenaustausch mit anderen Firmen erfolgt nicht, 
			wodurch die Datenschutzerklärung auf Ihren Besuch unserer Webseite beschränkt bleibt.
			
			<h2>2. Persönliche Daten und ihre Anwendung</h2>
			Um bei uns einkaufen zu können, brauchen Sie ein Kundenkonto. Dieses Kundenkonto beinhaltet persönliche Daten wie den Namen, die Anschrift oder die E-Mail-Adresse. 
			Die Daten werden in unserer Datenbank zwecks späterer Verarbeitung beim Einloggen gespeichert.
			<br>
			<p><font style="color:blue;">Zudem werden automatisch Daten in unseren Logfiles gespeichert, die wir von Ihrem Browser während des Besuches erhalten 
			(Browser ist zum Beispiel der Internet Explorer, Firefox, Safari etc.). 
			Das bedeutet, dass die IP-Adresse bekannt ist und es wird ein Cookie auf Ihrem Computer angelegt. 
			Dieses Cookie garantiert, dass die Abwicklung der Bestellung ordnungsgemäß abgewickelt werden kann und vor allem ist es dadurch möglich, 
			Ihre Interessen zu speichern, sodass wir Ihnen beim nächsten Besuch jene Produkte anbieten können, die Sie besonders interessieren, 
			ohne dass Sie das Interesse wiederholen müssen.</font>
			</p>
			
			<h2>3. Weitergabe der Daten</h2>
			Die Daten, die wir von Ihnen erhalten haben, werden nicht an Dritte weitergegeben. 
			
			<h2>4. Cookies</h2>
			<font style="color:blue;">Immer wieder kommt es zu Unsicherheiten wegen der Cookies, die auf dem Computer des Besuchers gespeichert werden. 
			Doch diese kleinen Dateien sind reine Informationsspeicher. Es werden keine Viren produziert, der Computer wird nicht angegriffen und Sie werden nicht ausgeforscht.
			<br>
			Ziel des Cookies ist einzig, Ihre persönlichen Aktivitäten und Interessen zu speichern, 
			sodass wir bei Ihrem nächsten Besuch damit arbeiten können. Der Vorteil für Sie besteht auch darin, 
			dass Sie beim Besuch unserer Webseite sofort jene Angebote sehen können, die Ihren Interessen entsprechen. 
			Das ist möglich, weil im Cookie gespeichert ist, welche Produkte Sie sich zuletzt angeschaut haben und entsprechende Alternativen oder Ergänzungen herausgesucht werden, 
			sobald Sie die Seite aufrufen.</font>
			
			<h2>5. Bearbeitung und Löschung der Daten</h2>
			Natürlich haben Sie jederzeit das Recht, Ihre eingetragenen persönlichen Daten im Kundenkonto zu korrigieren. Das ist uns sogar sehr wichtig, 
			falls sich beispielsweise eine Adresse ändert. 
			
			<h2>6. Datenschutz</h2>
			Wie bereits erwähnt, werden die Daten nicht weitergegeben. Um die Datensicherheit zu gewährleisten, ist Ihr Kundenkonto passwortgeschützt, 
			wodurch fremde Personen keinen Zugriff auf das Konto und die Daten haben.
			
			<h2>7. Änderungen dieser Datenschutzerklärung</h2>
			Der Webseitenbetreiber behält sich vor, diese Datenschutzerklärung zu ändern. 
			Sollte dies der Fall sein, werden Sie per E-Mail informiert und Sie erhalten entsprechende Informationen auch im Rahmen Ihres Kundenkontos.
    	  
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