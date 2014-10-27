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
              <a class="navbar-brand active" href="index.htm"><font color="white">CourtPicker</font></a>
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
                    <li><a href="features.htm#courtconfig">Konfiguration von Platzkategorien und Pl�tzen</a></li>
<!--                    <li><a href="features.htm#reservationconfig">Deine eigenen Reservierungskategorien</a></li>-->
                    <li><a href="features.htm#priceconfig">Flexible Tarifeinstellungen f�r jede Platzkategorie</a></li>
                    <li><a href="features.htm#layoutconfig">Eigenes Layout f�r Deinen CourtPicker</a></li>
<!--                    <li><a href="features.htm#integration">Integration in Deine Homepage</a></li>-->
                    <li class="divider"></li>
                    <li class="dropdown-header">Reservierungsfunktionalit�ten</li>
                    <li><a href="features.htm#combinedweekview">Kombinierte Wochenansicht</a></li>
                    <li><a href="features.htm#dayview">Tagesansicht</a></li>
                    <li><a href="features.htm#reservation">Einzel- und Aboreservierungen</a></li>
<!--                    <li><a href="features.htm#emails">Email-Best�tigungen</a></li>-->
                    <li><a href="features.htm#customerarea">Eigener Benutzerbereich f�r Deine Kunden</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-header">Administrationsfunktionalit�ten</li>
                    <li><a href="features.htm#userconfig">Mehrstufiges Berechtigungskonzept</a></li>
                    <li><a href="features.htm#payment">Bezahlstatus von Reservierungen verwalten</a></li>
                    <li><a href="features.htm#closure">Tagesabschluss auf Knopfdruck</a></li>
<!--                    <li><a href="features.htm#statistics">Statistiken</a></li>-->
<!--                    <li><a href="features.htm#search">Reservierungssuche und Excel-Export</a></li>-->
<!--                    <li><a href="features.htm#settings">Hilfreiche Settings</a></li>-->
<!--                    <li class="divider"></li>-->
                  </ul>
	                </li>
		                <li><a href="pricelist.htm"><spring:message code="menubar.prices"/></a></li>
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

    <div class="container">
    	<h1>CourtPicker - Datenschutzerkl�rung</h1>
    	<hr class="divider">
			Unser Unternehmen, nachstehend CourtPicker genannt, geht mit Ihren pers�nlichen Daten sehr verantwortungsvoll um 
			und die nachstehende Datenschutzerkl�rung soll Ihnen einen �berblick geben, was mit den Daten passiert und welche Schutz wir anbieten.
			<br>
			<h4>1. Geltung der Datenschutzbestimmungen</h4>
			(1) Diese Datenschutzerkl�rung beschreibt, welche personenbezogenen Daten CourtPicker (CourtPicker GesBR, 
			XXX, 1230 Wien, im Zusammenhang mit der Nutzung der Reservierungssysteml�sung "CourtPicker" erhebt und 
			zu welchem Zweck diese verarbeitet werden.
			<br>
			(2) Diese Datenschutzerkl�rung findet Anwendung auf die Datenverarbeitung im Zusammenhang mit 
			<ul>
			<li>a) der Nutzung unserer Website (www.courtpicker.com) sowie
			</li>
			<li>b) der Nutzung der Reservierungssysteml�sung CourtPicker.
			</li>
			</ul>
			(3) Soweit von unserer Website oder CourtPicker auf andere Seiten verlinkt wird, haben wir weder Einfluss 
			noch Kontrolle auf verlinkte Angebote und Inhalte, noch k�nnen wir eine Verantwortung f�r die Einhaltung 
			der Datenschutzbestimmungen auf diesen verlinkten Webseiten �bernehmen. Wir empfehlen daher, die
			Datenschutzbestimmungen dieser verlinkten Webseiten durchzusehen, um feststellen zu k�nnen, wie und 
			in welchem Umfang personenbezogene Informationen erhoben, genutzt oder und anderen zug�nglich 
			gemacht werden.
			<br><br>
			<h4>2. Datenverarbeitung und Datenerhebung auf unserer Website "courtpicker.com"</h4>
			(1) Sie k�nnen unsere Webseiten grunds�tzlich anonym besuchen, d.h., ohne, dass wir Information dar�ber 
			erhalten, wer Sie sind.
			<br>
			(2) Wenn Sie unsere Website aufrufen, werden jedoch standardm��ig Daten �ber diesen Vorgang in einer
			Protokolldatei (sog. Logfile) gespeichert und verarbeitet. Im Einzelnen werden in den sog. Logfiles 
			hierbei Ihre IP-Adresse, das Datum und die Uhrzeit des Aufrufs unserer Website, die aufgerufene URL 
			(unserer Webseite), die URL, woher Sie auf unsere Website gekommen sind und die Kennung Ihres Browsers 
			gespeichert. Diese Daten werden zur Sicherung eines st�rungsfreien Betriebs ben�tigt und werden 
			anonymisiert genutzt, um die Gestaltung der Website und der Betriebsabl�ufe zu verbessern.
			<br>
			(3) Ein R�ckschluss auf Ihre Person ist hierdurch jedoch nicht m�glich. Die Daten in den Logfiles werden 
			ausschlie�lich f�r statistische Zwecke ausgewertet und sp�testens nach Ablauf von sechs (6) Monaten 
			automatisch gel�scht.
			<br>
			(4) Dar�ber hinaus werden pers�nliche (personenbezogene) Daten auf unserer Website nur erhoben, wenn Sie
			uns diese von sich aus bei der Registrierung bereitstellen oder �ber ein Kontaktformular mit uns in 
			Verbindung treten.
			<br>
			(5) Sofern Sie innerhalb unseres Internetangebotes die M�glichkeit zur Eingabe von personenbezogenen 
			Daten erhalten und wahrnehmen, insbesondere pers�nliche oder gesch�ftliche Daten (E-Mail-Adressen, 
			Namen, Anschriften) angeben, so erfolgt dies stets auf freiwilliger Basis. CourtPicker wird diese Daten 
			ausschlie�lich zur Beantwortung und Bearbeitung Ihrer Anfragen speichern und nutzen. Die Daten werden
			nicht an Dritte weitergegeben.  
			<br><br>
			<h4>3. Cookies</h4>
			(1) Ferner verwendet CourtPicker auf den Webseiten sogenannte Cookies. Bei Cookies handelt es sich um
			kleine Textdateien, die beim Besuch unserer Webseite auf dem Ger�t des Nutzers gespeichert werden.
			<br>
			(2) Wenn Sie auf die Website von CourtPicker zur�ckkehren, ist es durch den Cookie m�glich, die zuvor 
			eingegebenen Informationen (Suchanfragen, Benutzernamen etc.) automatisch zu laden, so dass die Daten
			nicht erneut eingegeben werden m�ssen um die zuvorkonfigurierten Funktionen zu nutzen. Auf diese Weise
			k�nnen schnellere und genauere Ergebnisse geliefert und der Webauftritt von CourtPicker f�r den Nutzer
			individualisiert und optimiert werden.
			<br>
			(3) Die Daten, die mit Hilfe der vorgenannten Cookies gesammelt werden, sind anonym. Wir werden diese
			Daten ohne Zustimmung von Ihnen weder mit pers�nlichen (personenbezogenen) Daten verkn�pfen noch
			abgleichen. Sie haben die M�glichkeit, jederzeit �ber Ihre Browsereinstellungen Cookies zu akzeptieren,
			abzulehnen oder manuell zu l�schen. Die Anleitung hierf�r ist den Einstellungen der jeweils benutzten
			Browser zu entnehmen. Falls Cookies abgelehnt werden, kann dies unter Umst�nden die Leistung der
			Dienste herabsetzen oder die Verf�gbarkeit einzelner Dienste auf der Webseite einschr�nken. 
			<h4>4. Kontaktformulare</h4>
			(1) Wir speichern die von Ihnen im Kontaktformular eingegebenen Daten (insbesondere Name, Firma und 
			E-Mail-Adresse) und verwenden diese ausschlie�lich zum Zwecke der individuellen Kommunikation mit Ihnen.
			<br>
			(2) Bitte beachten Sie, dass die �bermittlung der Daten nicht verschl�sselt erfolgt und deshalb keine 
			vertraulichen Informationen �ber das Kontaktformular gesendet werden sollten. 
			<br>
			<h4>Auskunfts-, Berichtigungs- und L�schungsrecht</h4>
			(1) Sie haben das Recht, jederzeit Auskunft �ber die von Ihnen gespeicherten Daten zu erhalten oder 
			deren L�schung oder Berichtigung zu verlangen.
			<br>
			(2) Dieses Auskunfts-, L�schungs- und Berichtigungsrecht ist unentgeltlich. Bitte wenden Sie sich hierzu 
			per E-Mail an: info@courtpicker.com
			
      <!-- FOOTER -->
      <hr class="divider">
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2014 CourtPicker &middot; <a href="agb.htm">AGB</a> &middot; <a href="datasecuritystatement.htm">Datenschutzerkl�rung</a></p>
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>