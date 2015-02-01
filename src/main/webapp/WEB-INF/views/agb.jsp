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
    
  </c:if>
  
        <h1>Impressum</h1> 
        <hr class="divider">
        <b>Eigent�mer und Urheber:</b><br>
        CourtPicker GesbR<br>
        Pilotengasse 9/19<br>
        1220 Wien<br>
        �sterreich<br>
        <br>
        <b>Gesellschafter:</b><br>
        Markus Hamm <br>
        Matthias Heindl<br>
        <br>
    
    	<h1>Allgemeine Gesch�ftsbedingungen</h1> 
    	<hr class="divider">Stand: 26. Oktober 2014<br><br>

<h4>1. Geltung der Gesch�ftsbedingungen</h4>
(1) Die nachfolgenden Gesch�ftsbedingungen (nachfolgend AGB) gelten f�r alle Rechtsgesch�fte und 
Vertr�ge zwischen der CourtPicker GesbR, Pilotengasse 9/19, 1220 Wien (nachfolgend "CourtPicker") und dem
Nutzer der Reservierungssysteml�sung "CourtPicker", der CourtPicker als Dienstleister f�r seine Kunden 
bereitstellt. 
<br><br>
(2) Von diesen AGB abweichende Vertragsbedingungen werden nur dann zum Gegenstand einer vertraglichen
Vereinbarung zwischen dem Nutzer und CourtPicker, wenn CourtPicker diese zuvor anerkannt hat. Dies gilt
auch, wenn CourtPicker abweichenden Gesch�ftsbedingungen nicht ausdr�cklich widerspricht, die 
Angebotsaufforderungen, Bestellungen bzw. Annahmeerkl�rungen des Nutzers und Vertragspartners beigef�gt sind.
<br><br>
(3) Diese AGB finden ferner Anwendung auf alle zuk�nftigen Bestellungen, Auftr�ge und sonstigen Vereinbarungen 
der Parteien, selbst wenn sie nicht nochmals ausdr�cklich vereinbart werden oder hierauf nicht nochmals hingewiesen 
wird, es sei denn, die Parteien vereinbaren schriftlich etwas anderes. 
<br><br>
<h4>2. Vertragsgegenstand</h4>
(1) Gegenstand dieser AGB ist die zeitlich befristete Bereitstellung und Nutzung der Reservierungssysteml�sung
"CourtPicker" f�r den Nutzer sowie die zeitlich befristete Einr�umung der f�r die �berlassung und Nutzung 
erforderlichen Rechte.
<br><br>
(2) CourtPicker stellt dem Nutzer neben Basisfunktionen auch kostenpflichtige, individuell buchbare 
Zusatzleistungen (zusammen "Features" genannt) zur Verf�gung. Der konkrete Nutzungs- und Leistungsumfang 
sowie die technischen Details und Funktionalit�ten von CourtPicker ergeben sich aus den jeweiligen Features, 
die der Nutzer buchen m�chte oder sind der Website von CourtPicker (www.courtpicker.com) zu entnehmen.
<br><br>
(3) Der Vertrag mit dem Nutzer kommt durch Freischaltung und/oder �bermittlung der Zugangsdaten durch CourtPicker 
gegen�ber dem Nutzer zustande, wobei der Kunde die M�glichkeit hat, sein CourtPicker-Reservierungssystem im Rahmen 
einer Testperiode f�r drei Monate (90 Tage nach Abschluss der Registrierung) kostenlos zu testen.
CourtPicker schickt dem Kunden nach Ablauf der Testperiode ein Mail, in dem der Kunde auf den Ablauf der Testperiode 
hingewiesen und aufgefordert wird, zu best�tigen, dass er das Reservierungssystem zu den monatlichen Kosten, die ebenfalls im Mail enthalten sind,
weiterbetreiben will.
<br><br>

<h4>3. Umfang und Inhalt von Nutzungsrechten</h4>
(1) Der Nutzer erh�lt mit Freischaltung, der �bermittlung der Zugangsdaten und/oder mit Zahlung der 
vereinbarten Verg�tung ein einfaches, nicht ausschlie�liches, nicht unterlizenzierbares und nicht �bertragbares, 
auf die Laufzeit des Vertrages beschr�nkte Nutzungsrecht (Lizenz) an der Reservierungssysteml�sung "CourtPicker".
<br><br>
(2) Der Nutzer ist nicht berechtigt, �nderungen an der Software durchzuf�hren. Sofern CourtPicker w�hrend
der Laufzeit des jeweiligen Vertrages neue Versionen, Updates, Upgrades oder andere Neulieferungen im
Hinblick auf die Software vornimmt, gelten die Regelungen dieser Gesch�ftsbedingungen auch f�r diese.
(3) Der Nutzer ist nicht berechtigt, die Software �ber die vereinbarte Nutzung oder Dauer hinaus zu nutzen, von
Dritten nutzen zu lassen oder die Software Dritten zug�nglich zu machen. Insbesondere ist es nicht gestattet, 
die Software zu vervielf�ltigen, zu ver�u�ern oder zeitlich begrenzt zu �berlassen, insbesondere nicht zu
vermieten oder zu verleihen. 
<br><br>
<h4>4. Laufzeit, K�ndigung</h4>
(1) Der Vertrag beginnt mit Freischaltung und/oder Bereitstellung der Software und der gew�hlten Zusatzfunktionen 
gegen�ber dem Nutzer. Der Vertrag wird auf unbestimmte Zeit geschlossen.
<br><br>
(2) Die Parteien haben das Recht, den jeweiligen Vertrag mit einer K�ndigungsfrist von einem Tag zum Ablauf
des jeweiligen Buchungszeitraums zu k�ndigen. K�ndigt der Nutzer den Vertrag nicht, dann verl�ngert sich
die Buchungsdauer um den urspr�nglichen Zeitraum, beim 1-Monats-Abo um jeweils einen Monat, bei einem
12-Monats-Abo um weitere 12 Monate.
<br><br>
(3) Die K�ndigung der kostenpflichtigen Features erfolgt durch Deaktivieren des Feature-Schalters im Bereich "Features" in
der WebApp bis zum Ablauf des letzten Tages des aktuellen Buchungszeitraumes. Es erfolgt keine 
"K�ndigungsaufforderung" durch CourtPicker.
<br><br>
(4) Das Recht der Parteien, den Vertrag wegen eines wichtigen Grundes au�erordentlich, fristlos zu k�ndigen,
bleibt unber�hrt, wenn ihnen die Fortsetzung des Vertragsverh�ltnisses nicht weiter zuzumuten ist. Ein 
wichtiger Grund liegt insbesondere in folgenden F�llen vor:
<ul>
<li>a) Der Nutzer ist mit f�lligen Zahlungen mit mehr als zwei (2) Monaten in Verzug;
</li>
<li>b) CourtPicker stellt fest, dass die Angaben �ber die Bankverbindung des Nutzers falsch sind und deshalb 
keine Abbuchung m�glich ist;
</li>
<li>c) Eine der Parteien ger�t in Verm�gensverfall oder sonstige Umst�nde lassen bei vern�nftiger Wertung
die Zahlungsunf�higkeit bef�rchten. Hiervon ist insbesondere auszugehen, wenn f�r eine Partei ein
Insolvenzverfahren beantragt oder mangels Masse abgelehnt worden ist oder es ist eine L�schung
oder Liquidation im Handelsregister beantragt oder eingetragen worden;
</li>
<li>d) Eine der Vertragsparteien verst��t auch nach vorheriger schriftlicher Abmahnung erneut gegen 
elementare Pflichten des Vertrages.
</li></ul>
(5) Alle K�ndigungen von entgeltlichen Leistungen bed�rfen der Schriftform. 
<br><br>
<h4>5. Pflichten der Nutzer</h4>
(1) Der Nutzer hat bei der Nutzung der Reservierungssysteml�sung und der sonstigen bereitgestellten Leitungen und
Funktionen die anwendbaren �sterreichischen Gesetze und Rechtsvorschriften zu beachten. Insbesondere ist es
dem Nutzern untersagt, die bereitgestellten Leistungen von CourtPicker nicht missbr�uchlich zu nutzen, Daten
und Inhalte einzustellen, zu nutzen oder zu speichern, die gegen Rechtsvorschriften versto�en, fremde
Schutz- oder Urheberrechte oder sonstige Rechte Dritter verletzen. Der Nutzer stellt CourtPicker von s�mtlichen 
Anspr�chen Dritter frei, die auf einer rechtswidrigen Verwendung durch den Nutzer beruhen.
<br><br>
(2) Soweit der Nutzer im Rahmen der Nutzung der Reservierungssysteml�sung personenbezogene Daten erhebt
oder verarbeitet, hat er selbst f�r die Einhaltung der datenschutzrechtlichen Bestimmungen zu sorgen.
<br><br>
(3) Der Nutzer ist verpflichtet, die Zugangsdaten (insbesondere Benutzernamen und Passw�rter) gegen�ber
unbefugten Dritten vertraulich zu behandeln. Der Nutzer ist nicht berechtigt, diese Zugangsdaten unbefugten
Dritten weiterzugeben, zug�nglich zu machen oder aufandere Weise unbefugten Dritten, die nicht Vertragspartei sind, 
die Nutzung der Onlinedienste und/oder der beauftragten Komponenten zu erm�glichen. 
<br><br>
<h4>6. Verg�tung (Miete)</h4>
(1) Die vertragsgegenst�ndlichen Leistungen werden gegen Zahlung einer monatlichen Miete bereitgestellt, 
deren H�he vom Umfang der gew�hlten Funktionen abh�ngt.
<br><br>
(2) Im Falle einer entgeltlichen Nutzung wird die Miete automatisch von dem angegebenen Konto abgebucht,
fr�hestens jedoch drei (3) Tage nach Rechnungsdatum. Weist das Konto keine Deckung auf, hat der Nutzer die
zus�tzlichen Kosten zu tragen.
<br><br>
(3) Leistet der Nutzer nicht innerhalb von 10 Tagen nach dem ausgewiesenen Rechnungsdatum bzw. nicht innerhalb 
der in der Rechnung ausgewiesenen Zahlungsfrist oder ist keine Abbuchung von dessen Konto m�glich, 
ger�t er ohne weitere Mahnung in Verzug.
<br><br>
(4) Alle Preise gelten zuz�glich der gesetzlichen Mehrwertsteuer in der jeweils am Tag der Rechnungsstellung 
g�ltigen H�he.
<br><br>
(5) Kommt der Nutzer f�r zwei aufeinanderfolgende Monate mit der Bezahlung der vereinbarten Verg�tung in
Verzug oder ist eine Abbuchung vom Vertragskonto nicht m�glich, so kann CourtPicker das Vertragsverh�ltnis 
ohne Einhaltung einer Frist k�ndigen oder den Zugriff auf die Leistungen von CourtPicker bis zum Ausgleich der Zahlung sperren.
<br><br>
<h4>7. Gew�hrleistung und Haftung</h4>
(1) CourtPicker leistet Gew�hr gem�� den gesetzlichen Regelungen. Der verschuldensunabh�ngige 
Schadensersatzanspruch wird ausgeschlossen.
<br><br>
(2) Die Vertragspartner haften einander nach den allgemeinen gesetzlichen Vorschriften, soweit sich aus den
nachfolgenden Regelungen nicht etwas anderes ergibt. Diese Bestimmungen gelten f�r alle Schadensersatzanspr�che 
und Anspr�che auf Ersatz vergeblicher Aufwendungen, gleich aus welchem Rechtsgrund, soweit nicht anderweitig 
schriftlich geregelt. Die Parteien haften einander stets
<ul>
<li>a) f�r selbst, sowie von den gesetzlichen Vertretern oder Erf�llungsgehilfen vors�tzlich oder grob fahrl�ssig 
verursachte Sch�den, sowie
</li>
<li>b) nach dem Produkthaftungsgesetz und 
</li>
<li>c) bei Verletzung von Leben, K�rper oder Gesundheit, die eine Partei, deren gesetzliche Vertreter oder
Erf�llungsgehilfen zu vertreten haben oder
</li>
<li>d) bei Arglist oder einer zugesicherten Eigenschaft.
</li>
</ul>
(3) CourtPicker, deren gesetzliche Vertreter und Erf�llungsgehilfen haften nicht bei leichter Fahrl�ssigkeit. 
Dies gilt nur dann nicht, wenn es sich um eine schuldhafte Verletzung von wesentlichen Vertragspflichten handelt.
Wesentliche Vertragspflichten sind Pflichten von CourtPicker, deren Erf�llung die ordnungsgem��e Durchf�hrung 
des jeweiligen Vertrages �berhaupt erst erm�glicht und auf deren Einhaltung der Nutzer im Rahmen der
Erbringung der jeweiligen vertragsgegenst�ndlichen Leistungen regelm��ig vertrauen darf, mithin also
Pflichten, deren Verletzung die Erreichung des Vertragszwecks gef�hrden w�rde. In diesem Fall ist die
Haftung von CourtPicker jedoch der H�he nach auf den vertragstypischen und vorhersehbaren Schaden begrenzt. 
Der H�he nach ist der Schadensersatzanspruch auf die Summe der j�hrlichen Verg�tung begrenzt.
<br><br>
(4) Eine weitergehende Haftung von CourtPicker besteht nicht. Die vorgenannten Bestimmungen gelten auch f�r
entgangenen Gewinn, ausgebliebene Einsparungen oder f�r sonstige Folgesch�den.
<br><br>
(5) Die Haftung von CourtPicker im Falle von Datenverlust oder Datenwiederherstellung ist in jedem Fall der H�he nach 
begrenzt und zwar auf den Schaden, der auch bei regelm��iger und sachgem��er Datensicherung durch den Nutzer 
eingetreten w�re. Die vorstehenden Haftungsbeschr�nkungen gelten auch f�r die pers�nliche Haftung der Mitarbeiter, 
Vertreter und Organe von CourtPicker.
<br><br>
(6) Der Nutzer ist verantwortlich f�r die Sicherung seiner Daten.
<br><br>
(7) F�r Ereignisse h�herer Gewalt, die CourtPicker die vertragliche Leistung wesentlich erschweren, die 
ordnungsgem��e Durchf�hrung des Vertrages zeitweilig behindern oder unm�glich machen, haftet CourtPicker
nicht. Als h�here Gewalt gelten alle vom Willen und Einfluss der Vertragsparteien unabh�ngigen Umst�nde,
insbesondere bei Stromausf�llen bei Lieferanten von CourtPicker oder Einschr�nkungen in der Verf�gbarkeiten, 
die im Einfluss von Dritten stehen, mithin Umst�nde, die unvorhersehbar, schwerwiegend und durch die
Vertragsparteien unverschuldet sind und nach Abschluss dieses Vertrages eintreten.
<br><br>
<h4>8. Datenschutz und Datensicherheit</h4>
(1) Die Parteien sind verpflichtet, hinsichtlich des Schutzes personenbezogener Daten die Bestimmungen des 
Datenschutzgesetzes zu beachten.
<br><br>
(2) CourtPicker wird dar�ber hinaus personenbezogene Daten nur in dem Umfang und zu dem Zweck erheben
und verarbeiten, wie es die Durchf�hrung dieses Vertrages erfordert. Einzelheiten sind der Datenschutzerkl�rung 
zu entnehmen. 
<br><br>
<h4>9. Allgemeine Bestimmungen</h4>
(1) Diese AGB unterliegen dem �sterreichischen Recht. Das UN-Kaufrecht ist ausgeschlossen.
<br><br>
(2) Gerichtsstand ist Wien.
<br><br>
(3) Sollten sich einzelne Bestimmungen dieser Vertrags bedingungen einschlie�lich aller hierauf Bezug genommenen 
Anlagen oder Bestandteile als unwirksam oder undurchf�hrbar erweisen, so wird dadurch die
G�ltigkeit der �brigen Regelungen dieser Vertragsbedingungen nicht ber�hrt. In einem solchen Fall ist die
ung�ltige oder unwirksame Bestimmung durch eine Neuregelung zu ersetzen, die dem gewollten Zweck
entspricht und von Beginn der Unwirksamkeit an gilt.
<br><br>
(4) Soweit es sich um Bestimmungen handelt, die wesentlich sind oder sonst ohne Gef�hrdung des Vertragszwecks 
nicht wegfallen k�nnen, verpflichten sich die Vertragsparteien, den Vertrag unter Ber�cksichtigung
des verfolgten Zwecks der unwirksamen Regelung so auszulegen, zu berichtigen oder durch eine andere,
wirksame und durchf�hrbare Regelung zu ersetzen, dass sein wirtschaftlicher und rechtlicher Zweck m�glichst erreicht wird.
	
  <c:if test="${empty param.textonly}">    
      
      <!-- FOOTER -->
      <hr class="divider">
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2014 CourtPicker &middot; <a href="agb.htm">Impressum & AGB</a> &middot; <a href="datasecuritystatement.htm">Datenschutzerkl�rung</a></p>
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
