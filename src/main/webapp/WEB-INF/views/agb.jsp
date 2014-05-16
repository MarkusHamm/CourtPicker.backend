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
    	<h1>CourtPicker - Allgemeine Geschäftsbedingungen</h1> 
    	<hr class="divider">
			für Nutzer des Angebots von CourtPicker
<br>Stand: 15. Juni 2013
<h2>1. Vertragsschluss</h2>
Der Kunde hat die Möglichkeit, sein CourtPicker-Reservierungssystem im Rahmen einer Testperiode kostenlos zu testen.
CourtPicker schickt dem Kunden nach Ablauf der Testperiode ein Mail, 
in dem der Kunde auf den Ablauf der Testperiode hingewiesen und aufgefordert wird,
zu bestätigen, dass er das Reservierungssystem zu den monatlichen Kosten, die ebenfalls im Mail enthalten sind,
weiterbetreiben will. 
Zwischen dem Kunden und CourtPicker kommt ein rechtsgültiger Vertrag zustande, 
sobald der Kunde ein Mail mit Bestätigung an CourtPicker sendet.
Dem Kunden wird abschliessend eine Bestellbestätigung per mail zugesendet.
<h2>2. Zahlungsbedingungen</h2>
2.1 Die Preise ergeben sich aus der jeweiligen Konfiguration und sind auf der Produktbeschreibungsseite ersichtlich.
<br>2.3 Der Kunde hat bei der Bestellung dafür Sorge zu tragen, 
dass die Angaben sämtlicher Daten mit den gewünschten Daten auf der Rechnung übereinstimmen. 
Nachträgliche Änderungen auf Rechnungen können nicht erfolgen.
<br>2.4 Der Kunde ist nicht berechtigt, Zahlungen zurückzuhalten, sofern ihm nicht ein gesetzliches 
Zurückbehaltungsrecht zusteht.
<br>2.5 CourtPicker kann sich Diensten von Drittunternehmen bedienen, um Zahlungsvorgänge abzuwickeln. 
Sofern dies geschieht, wird das jeweils beauftragte Unternehmen im Bestellprozess bezeichnet.
<br>2.6 Bei Zahlungen per Lastschrift gilt: Der Kunde hat dafür Sorge zu tragen, 
dass die angegebene Bankverbindung korrekt ist, er über das Bankkonto verfügungsberechtigt ist 
und das Bankkonto zum Zeitpunkt der Abbuchung eine entsprechende Deckung aufweist. 
Kosten für fehlgeschlagene Abbuchungen, insbesondere Rücklastschrift- und Mahngebühren, werden dem Kunden berechnet, 
sofern nicht CourtPicker für das Fehlschlagen verantwortlich ist.
<br>2.7 Alle Zahlungen sind sofort fällig. Es tritt Verzug ein, wenn eine Abbuchung des Kaufpreises 
oder eine entsprechende Kreditkartenbelastung fehlschlägt oder die Abbuchung oder Kreditkartenbelastung vom Kunden 
ohne Rechtsgrund storniert wird. Bei Zahlung auf Rechnung verpflichtet sich der Kunde, den Rechnungsbetrag 
innerhalb von 14 Tagen nach Erhalt der Rechnung zu begleichen. 
Der Rechnungsbetrag ist auf das in der Rechnung angegebene Konto 
<font style="color:blue;">XXX</font> zu überweisen.
Ist der Kunde im Verzug, berechnet CourtPicker pauschal EUR 3,00 je Mahnung als Verzugsschaden. 
Die Geltendmachung eines weitergehenden Verzugsschadens bleibt vorbehalten.

<h2>3. Preise</h2>
	Die auf der Produktbeschreibungsseite angegebenen Preise verstehen sich als Nettopreise, 
	welche die Mehrwertsteuer in Höhe von 20 % nicht beinhalten.

<h2>4. Rücktritt, Wiederrufsrecht</h2>
	4.1 CourtPicker behält sich das Recht vor, vom Vertrag zurückzutreten, wenn falsche Angaben über die 
	Kreditwürdigkeit des Kunden gemacht wurden oder die Zahlungsfähigkeit des Kunden auf Grund objektiver 
	Gründe angezweifelt werden muss.
<br><font style="color:blue;">4.2 Sofern dem Kunden das angeforderte Reservierungssytem zur Verfügung gestellt wurde, 
kann der Vertrag nicht rückabgewickelt werden. Ein Widerrufsrecht besteht in diesem Fall deshalb nicht.</font>

<h2>5. Partnerangebote, Links</h2>
CourtPicker stellt dem Kunden möglicherweise Links auf Drittseiten und / oder Partnerangebote zur Verfügung. 
Für die entsprechenden Inhalte, deren Rechtmäßigkeit und Richtigkeit ist CourtPicker nicht verantwortlich. 
Insofern distanziert sich CourtPicker vorsorglich von den dort angebotenen Inhalten. 
Im Übrigen gelten die jeweiligen Geschäftsbedingungen der Betreiber der verlinkten Drittseiten / Partnerangebote.

<font style="color:blue;"><h2>6. Gewährleistung, Haftung</h2>
6.1 CourtPicker wendet größte Sorgfalt bei der Erstellung und Pflege der Dateien und Inhalte auf. 
Gleichwohl kann CourtPicker keine Gewähr dafür übernehmen, dass die Dateien und Inhalte für die 
konkreten Bedürfnisse des Kunden passend und richtig sind. 
Der Kunde wählt die Dateien und Inhalte eigenverantwortlich aus und verwendet diese eigenverantwortlich. 
Die Haftung von CourtPicker für die falsche Verwendung der Dateien und Inhalte ist ausgeschlossen.
<br>6.2 Die Dateien und Inhalte dienen lediglich als Anhaltspunkt und ersetzen keinesfalls eine fachkundige Beratung. 
Der Kunde wird deshalb erforderlichenfalls anwaltlichen Rat einholen, bevor er die Dateien und Inhalte verwendet. 
Unterlässt der Kunde dies und entsteht aufgrund dessen ein Schaden, 
ist die Haftung von CourtPicker hierfür ausgeschlossen.
<br>6.3 Die Haftung von CourtPicker im Übrigen ist auf Vorsatz und grobe Fahrlässigkeit beschränkt. 
Davon ausgenommen ist die Haftung für Schäden an Körper, Leben und Gesundheit, 
für die die gesetzlichen Haftungsregeln uneingeschränkt gelten.
<br>6.4 Im Übrigen gelten die gesetzlichen Gewährleistungsvorschriften.</font>

<h2>7.	Datenschutz</h2>

	<font style="color:blue;">Die von Ihnen übermittelten Daten werden von uns ausschließlich zur Abwicklung Ihrer Bestellungen verwendet. 
	Alle Ihre Daten werden von uns streng vertraulich behandelt. Eine Weitergabe der Daten an Dritte 
	(z.B. Versanddienste) erfolgt von uns nur, sofern dies für die Auftragsabwicklung erforderlich ist. 
	Die Bestelldaten werden verschlüsselt und gesichert übertragen, wir übernehmen jedoch keine Haftung für 
	die Datensicherheit während dieser Übertragungen über das Internet (z.B. wegen technischer Fehler des Providers) 
	oder für einen eventuellen kriminellen Zugriff Dritter auf Dateien unserer Internetpräsenz. 
	Zugangsdaten für den Kunden-Login, die auf Wunsch des Kunden an diesen übermittelt werden, 
	sind vom Kunden streng vertraulich zu behandeln da wir keinerlei Verantwortung für die Nutzung und 
	Verwendung dieser Daten übernehmen. Eine darüber hinausgehende Weitergabe Ihrer personenbezogenen Daten 
	erfolgt nur mit Ihrer ausdrücklichen Zustimmung.</font>

<font style="color:blue;"><h2>8. Schlussbestimmungen</h2>
8.1 Ist oder wird eine Bestimmung in diesen allgemeinen Geschäftsbedingungen unwirksam, 
bleiben die übrigen Bestimmungen davon unberührt.
<br>8.2 Es gilt ausschließlich das Recht der Bundesrepublik Deutschland unter Ausschluss des Internationalen 
Privatrechts und des UN-Kaufrechts.
<br>8.3 Erfüllungsort und Gerichtsstand ist Berlin, sofern der Kunde Kaufmann ist.
<br>8.4 CourtPicker kann diese Vertragsbedingungen jederzeit ändern. 
In diesem Fall könnten die jetzt auf Ihre Bestellung anwendbaren AGB zu einem späteren Zeitpunkt 
nicht mehr abrufbar sein. Sie haben die Möglichkeit, die aktuellen AGB jetzt zu speichern (PDF-Format) 
oder für Ihre Unterlagen auszudrucken. Eine Speicherung der Vertragsdaten durch CourtPicker findet nicht statt.</font>
    	  
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
