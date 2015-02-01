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
    <!-- google analytics -->
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
    
      ga('create', 'UA-58129508-1', 'auto');
      ga('send', 'pageview');
    </script>
  </head>
<!-- NAVBAR
================================================== -->
  <body>
  
  <c:if test="${empty param.textonly}">
  
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
    
  </c:if>
  
        <h1>Impressum</h1> 
        <hr class="divider">
        <b>Eigentümer und Urheber:</b><br>
        CourtPicker GesbR<br>
        Pilotengasse 9/19<br>
        1220 Wien<br>
        Österreich<br>
        <br>
        <b>Gesellschafter:</b><br>
        Markus Hamm <br>
        Matthias Heindl<br>
        <br>
    
    	<h1>Allgemeine Geschäftsbedingungen</h1> 
    	<hr class="divider">Stand: 26. Oktober 2014<br><br>

<h4>1. Geltung der Geschäftsbedingungen</h4>
(1) Die nachfolgenden Geschäftsbedingungen (nachfolgend AGB) gelten für alle Rechtsgeschäfte und 
Verträge zwischen der CourtPicker GesbR, Pilotengasse 9/19, 1220 Wien (nachfolgend "CourtPicker") und dem
Nutzer der Reservierungssystemlösung "CourtPicker", der CourtPicker als Dienstleister für seine Kunden 
bereitstellt. 
<br><br>
(2) Von diesen AGB abweichende Vertragsbedingungen werden nur dann zum Gegenstand einer vertraglichen
Vereinbarung zwischen dem Nutzer und CourtPicker, wenn CourtPicker diese zuvor anerkannt hat. Dies gilt
auch, wenn CourtPicker abweichenden Geschäftsbedingungen nicht ausdrücklich widerspricht, die 
Angebotsaufforderungen, Bestellungen bzw. Annahmeerklärungen des Nutzers und Vertragspartners beigefügt sind.
<br><br>
(3) Diese AGB finden ferner Anwendung auf alle zukünftigen Bestellungen, Aufträge und sonstigen Vereinbarungen 
der Parteien, selbst wenn sie nicht nochmals ausdrücklich vereinbart werden oder hierauf nicht nochmals hingewiesen 
wird, es sei denn, die Parteien vereinbaren schriftlich etwas anderes. 
<br><br>
<h4>2. Vertragsgegenstand</h4>
(1) Gegenstand dieser AGB ist die zeitlich befristete Bereitstellung und Nutzung der Reservierungssystemlösung
"CourtPicker" für den Nutzer sowie die zeitlich befristete Einräumung der für die Überlassung und Nutzung 
erforderlichen Rechte.
<br><br>
(2) CourtPicker stellt dem Nutzer neben Basisfunktionen auch kostenpflichtige, individuell buchbare 
Zusatzleistungen (zusammen "Features" genannt) zur Verfügung. Der konkrete Nutzungs- und Leistungsumfang 
sowie die technischen Details und Funktionalitäten von CourtPicker ergeben sich aus den jeweiligen Features, 
die der Nutzer buchen möchte oder sind der Website von CourtPicker (www.courtpicker.com) zu entnehmen.
<br><br>
(3) Der Vertrag mit dem Nutzer kommt durch Freischaltung und/oder Übermittlung der Zugangsdaten durch CourtPicker 
gegenüber dem Nutzer zustande, wobei der Kunde die Möglichkeit hat, sein CourtPicker-Reservierungssystem im Rahmen 
einer Testperiode für drei Monate (90 Tage nach Abschluss der Registrierung) kostenlos zu testen.
CourtPicker schickt dem Kunden nach Ablauf der Testperiode ein Mail, in dem der Kunde auf den Ablauf der Testperiode 
hingewiesen und aufgefordert wird, zu bestätigen, dass er das Reservierungssystem zu den monatlichen Kosten, die ebenfalls im Mail enthalten sind,
weiterbetreiben will.
<br><br>

<h4>3. Umfang und Inhalt von Nutzungsrechten</h4>
(1) Der Nutzer erhält mit Freischaltung, der Übermittlung der Zugangsdaten und/oder mit Zahlung der 
vereinbarten Vergütung ein einfaches, nicht ausschließliches, nicht unterlizenzierbares und nicht übertragbares, 
auf die Laufzeit des Vertrages beschränkte Nutzungsrecht (Lizenz) an der Reservierungssystemlösung "CourtPicker".
<br><br>
(2) Der Nutzer ist nicht berechtigt, Änderungen an der Software durchzuführen. Sofern CourtPicker während
der Laufzeit des jeweiligen Vertrages neue Versionen, Updates, Upgrades oder andere Neulieferungen im
Hinblick auf die Software vornimmt, gelten die Regelungen dieser Geschäftsbedingungen auch für diese.
(3) Der Nutzer ist nicht berechtigt, die Software über die vereinbarte Nutzung oder Dauer hinaus zu nutzen, von
Dritten nutzen zu lassen oder die Software Dritten zugänglich zu machen. Insbesondere ist es nicht gestattet, 
die Software zu vervielfältigen, zu veräußern oder zeitlich begrenzt zu überlassen, insbesondere nicht zu
vermieten oder zu verleihen. 
<br><br>
<h4>4. Laufzeit, Kündigung</h4>
(1) Der Vertrag beginnt mit Freischaltung und/oder Bereitstellung der Software und der gewählten Zusatzfunktionen 
gegenüber dem Nutzer. Der Vertrag wird auf unbestimmte Zeit geschlossen.
<br><br>
(2) Die Parteien haben das Recht, den jeweiligen Vertrag mit einer Kündigungsfrist von einem Tag zum Ablauf
des jeweiligen Buchungszeitraums zu kündigen. Kündigt der Nutzer den Vertrag nicht, dann verlängert sich
die Buchungsdauer um den ursprünglichen Zeitraum, beim 1-Monats-Abo um jeweils einen Monat, bei einem
12-Monats-Abo um weitere 12 Monate.
<br><br>
(3) Die Kündigung der kostenpflichtigen Features erfolgt durch Deaktivieren des Feature-Schalters im Bereich "Features" in
der WebApp bis zum Ablauf des letzten Tages des aktuellen Buchungszeitraumes. Es erfolgt keine 
"Kündigungsaufforderung" durch CourtPicker.
<br><br>
(4) Das Recht der Parteien, den Vertrag wegen eines wichtigen Grundes außerordentlich, fristlos zu kündigen,
bleibt unberührt, wenn ihnen die Fortsetzung des Vertragsverhältnisses nicht weiter zuzumuten ist. Ein 
wichtiger Grund liegt insbesondere in folgenden Fällen vor:
<ul>
<li>a) Der Nutzer ist mit fälligen Zahlungen mit mehr als zwei (2) Monaten in Verzug;
</li>
<li>b) CourtPicker stellt fest, dass die Angaben über die Bankverbindung des Nutzers falsch sind und deshalb 
keine Abbuchung möglich ist;
</li>
<li>c) Eine der Parteien gerät in Vermögensverfall oder sonstige Umstände lassen bei vernünftiger Wertung
die Zahlungsunfähigkeit befürchten. Hiervon ist insbesondere auszugehen, wenn für eine Partei ein
Insolvenzverfahren beantragt oder mangels Masse abgelehnt worden ist oder es ist eine Löschung
oder Liquidation im Handelsregister beantragt oder eingetragen worden;
</li>
<li>d) Eine der Vertragsparteien verstößt auch nach vorheriger schriftlicher Abmahnung erneut gegen 
elementare Pflichten des Vertrages.
</li></ul>
(5) Alle Kündigungen von entgeltlichen Leistungen bedürfen der Schriftform. 
<br><br>
<h4>5. Pflichten der Nutzer</h4>
(1) Der Nutzer hat bei der Nutzung der Reservierungssystemlösung und der sonstigen bereitgestellten Leitungen und
Funktionen die anwendbaren österreichischen Gesetze und Rechtsvorschriften zu beachten. Insbesondere ist es
dem Nutzern untersagt, die bereitgestellten Leistungen von CourtPicker nicht missbräuchlich zu nutzen, Daten
und Inhalte einzustellen, zu nutzen oder zu speichern, die gegen Rechtsvorschriften verstoßen, fremde
Schutz- oder Urheberrechte oder sonstige Rechte Dritter verletzen. Der Nutzer stellt CourtPicker von sämtlichen 
Ansprüchen Dritter frei, die auf einer rechtswidrigen Verwendung durch den Nutzer beruhen.
<br><br>
(2) Soweit der Nutzer im Rahmen der Nutzung der Reservierungssystemlösung personenbezogene Daten erhebt
oder verarbeitet, hat er selbst für die Einhaltung der datenschutzrechtlichen Bestimmungen zu sorgen.
<br><br>
(3) Der Nutzer ist verpflichtet, die Zugangsdaten (insbesondere Benutzernamen und Passwörter) gegenüber
unbefugten Dritten vertraulich zu behandeln. Der Nutzer ist nicht berechtigt, diese Zugangsdaten unbefugten
Dritten weiterzugeben, zugänglich zu machen oder aufandere Weise unbefugten Dritten, die nicht Vertragspartei sind, 
die Nutzung der Onlinedienste und/oder der beauftragten Komponenten zu ermöglichen. 
<br><br>
<h4>6. Vergütung (Miete)</h4>
(1) Die vertragsgegenständlichen Leistungen werden gegen Zahlung einer monatlichen Miete bereitgestellt, 
deren Höhe vom Umfang der gewählten Funktionen abhängt.
<br><br>
(2) Im Falle einer entgeltlichen Nutzung wird die Miete automatisch von dem angegebenen Konto abgebucht,
frühestens jedoch drei (3) Tage nach Rechnungsdatum. Weist das Konto keine Deckung auf, hat der Nutzer die
zusätzlichen Kosten zu tragen.
<br><br>
(3) Leistet der Nutzer nicht innerhalb von 10 Tagen nach dem ausgewiesenen Rechnungsdatum bzw. nicht innerhalb 
der in der Rechnung ausgewiesenen Zahlungsfrist oder ist keine Abbuchung von dessen Konto möglich, 
gerät er ohne weitere Mahnung in Verzug.
<br><br>
(4) Alle Preise gelten zuzüglich der gesetzlichen Mehrwertsteuer in der jeweils am Tag der Rechnungsstellung 
gültigen Höhe.
<br><br>
(5) Kommt der Nutzer für zwei aufeinanderfolgende Monate mit der Bezahlung der vereinbarten Vergütung in
Verzug oder ist eine Abbuchung vom Vertragskonto nicht möglich, so kann CourtPicker das Vertragsverhältnis 
ohne Einhaltung einer Frist kündigen oder den Zugriff auf die Leistungen von CourtPicker bis zum Ausgleich der Zahlung sperren.
<br><br>
<h4>7. Gewährleistung und Haftung</h4>
(1) CourtPicker leistet Gewähr gemäß den gesetzlichen Regelungen. Der verschuldensunabhängige 
Schadensersatzanspruch wird ausgeschlossen.
<br><br>
(2) Die Vertragspartner haften einander nach den allgemeinen gesetzlichen Vorschriften, soweit sich aus den
nachfolgenden Regelungen nicht etwas anderes ergibt. Diese Bestimmungen gelten für alle Schadensersatzansprüche 
und Ansprüche auf Ersatz vergeblicher Aufwendungen, gleich aus welchem Rechtsgrund, soweit nicht anderweitig 
schriftlich geregelt. Die Parteien haften einander stets
<ul>
<li>a) für selbst, sowie von den gesetzlichen Vertretern oder Erfüllungsgehilfen vorsätzlich oder grob fahrlässig 
verursachte Schäden, sowie
</li>
<li>b) nach dem Produkthaftungsgesetz und 
</li>
<li>c) bei Verletzung von Leben, Körper oder Gesundheit, die eine Partei, deren gesetzliche Vertreter oder
Erfüllungsgehilfen zu vertreten haben oder
</li>
<li>d) bei Arglist oder einer zugesicherten Eigenschaft.
</li>
</ul>
(3) CourtPicker, deren gesetzliche Vertreter und Erfüllungsgehilfen haften nicht bei leichter Fahrlässigkeit. 
Dies gilt nur dann nicht, wenn es sich um eine schuldhafte Verletzung von wesentlichen Vertragspflichten handelt.
Wesentliche Vertragspflichten sind Pflichten von CourtPicker, deren Erfüllung die ordnungsgemäße Durchführung 
des jeweiligen Vertrages überhaupt erst ermöglicht und auf deren Einhaltung der Nutzer im Rahmen der
Erbringung der jeweiligen vertragsgegenständlichen Leistungen regelmäßig vertrauen darf, mithin also
Pflichten, deren Verletzung die Erreichung des Vertragszwecks gefährden würde. In diesem Fall ist die
Haftung von CourtPicker jedoch der Höhe nach auf den vertragstypischen und vorhersehbaren Schaden begrenzt. 
Der Höhe nach ist der Schadensersatzanspruch auf die Summe der jährlichen Vergütung begrenzt.
<br><br>
(4) Eine weitergehende Haftung von CourtPicker besteht nicht. Die vorgenannten Bestimmungen gelten auch für
entgangenen Gewinn, ausgebliebene Einsparungen oder für sonstige Folgeschäden.
<br><br>
(5) Die Haftung von CourtPicker im Falle von Datenverlust oder Datenwiederherstellung ist in jedem Fall der Höhe nach 
begrenzt und zwar auf den Schaden, der auch bei regelmäßiger und sachgemäßer Datensicherung durch den Nutzer 
eingetreten wäre. Die vorstehenden Haftungsbeschränkungen gelten auch für die persönliche Haftung der Mitarbeiter, 
Vertreter und Organe von CourtPicker.
<br><br>
(6) Der Nutzer ist verantwortlich für die Sicherung seiner Daten.
<br><br>
(7) Für Ereignisse höherer Gewalt, die CourtPicker die vertragliche Leistung wesentlich erschweren, die 
ordnungsgemäße Durchführung des Vertrages zeitweilig behindern oder unmöglich machen, haftet CourtPicker
nicht. Als höhere Gewalt gelten alle vom Willen und Einfluss der Vertragsparteien unabhängigen Umstände,
insbesondere bei Stromausfällen bei Lieferanten von CourtPicker oder Einschränkungen in der Verfügbarkeiten, 
die im Einfluss von Dritten stehen, mithin Umstände, die unvorhersehbar, schwerwiegend und durch die
Vertragsparteien unverschuldet sind und nach Abschluss dieses Vertrages eintreten.
<br><br>
<h4>8. Datenschutz und Datensicherheit</h4>
(1) Die Parteien sind verpflichtet, hinsichtlich des Schutzes personenbezogener Daten die Bestimmungen des 
Datenschutzgesetzes zu beachten.
<br><br>
(2) CourtPicker wird darüber hinaus personenbezogene Daten nur in dem Umfang und zu dem Zweck erheben
und verarbeiten, wie es die Durchführung dieses Vertrages erfordert. Einzelheiten sind der Datenschutzerklärung 
zu entnehmen. 
<br><br>
<h4>9. Allgemeine Bestimmungen</h4>
(1) Diese AGB unterliegen dem Österreichischen Recht. Das UN-Kaufrecht ist ausgeschlossen.
<br><br>
(2) Gerichtsstand ist Wien.
<br><br>
(3) Sollten sich einzelne Bestimmungen dieser Vertrags bedingungen einschließlich aller hierauf Bezug genommenen 
Anlagen oder Bestandteile als unwirksam oder undurchführbar erweisen, so wird dadurch die
Gültigkeit der übrigen Regelungen dieser Vertragsbedingungen nicht berührt. In einem solchen Fall ist die
ungültige oder unwirksame Bestimmung durch eine Neuregelung zu ersetzen, die dem gewollten Zweck
entspricht und von Beginn der Unwirksamkeit an gilt.
<br><br>
(4) Soweit es sich um Bestimmungen handelt, die wesentlich sind oder sonst ohne Gefährdung des Vertragszwecks 
nicht wegfallen können, verpflichten sich die Vertragsparteien, den Vertrag unter Berücksichtigung
des verfolgten Zwecks der unwirksamen Regelung so auszulegen, zu berichtigen oder durch eine andere,
wirksame und durchführbare Regelung zu ersetzen, dass sein wirtschaftlicher und rechtlicher Zweck möglichst erreicht wird.
	
  <c:if test="${empty param.textonly}">    
      
      <!-- FOOTER -->
      <hr class="divider">
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2014 CourtPicker &middot; <a href="agb.htm">Impressum & AGB</a> &middot; <a href="datasecuritystatement.htm">Datenschutzerklärung</a></p>
      </footer>
            
    </div><!-- /.container -->
    
  </c:if>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
