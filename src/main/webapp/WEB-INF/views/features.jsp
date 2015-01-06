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
				<li><a href="benefits.htm">Vorteile</a></li>
                <li class="dropdown active">
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
             <div class="col-md-6"><h1>CourtPicker Funktionen</h1>
             </div>
             <div class="col-md-6"><span class="pull-right"><br><a class="btn btn-primary" href="/configurator" role="button">Meinen CourtPicker ausprobieren &raquo;</a></span>
             </div>
        </div>      
        <hr class="divider">    
        <h2>Online-Konfiguration</h2>
        <hr class="divider">    
        
        <div class="row featurette">
            <a name="courtconfig"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/1-Platzkonfigurator.png" alt="courtconfig">
                </div>
                <div class="col-md-8 text-justify">
                    <h3 class="featurette-heading">CourtPicker an Deine Anlage anpassen.<br> <span class="text-muted"></span></h3>
                    <p class="lead">Verwalte soviele Plätze du willst. <br>Egal welche Platzart.</p>
                    <ul>
                        <li>Für jede Platzart kannst Du <b>Reservierungszeiten definieren</b>, also von wann bis wann Plätze reservierbar sein sollen.
                        </li>
                        <br>
                        <li>Außerdem kannst Du für jede Platzart die <b>Reservierungseinheit definieren</b>, z.B. Tennis: 60 min, Badminton: 30 min, Sqash: 15 min.
                        </li>
                    </ul>
                </div>
            </div>
        <p class="pull-right"><a href="#">Nach oben</a></p><br>
        <hr class="featurette-divider">
        
<!--        <div class="row featurette">-->
<!--            <a name="reservationconfig"></a>-->
<!--                <div class="col-md-5">-->
<!--                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/startpage.gif" alt="image">-->
<!--                </div>-->
<!--                <div class="col-md-7 text-justify">-->
<!--                    <h2 class="featurette-heading">Deine eigenen Reservierungskategorien.<br> <span class="text-muted">Schnell erkennbare Reservierungstypen.</span></h2>-->
<!--                    <p class="lead">Markiere Deine Reservierungen als Meisterschaftstermin, Wintercup, Instandsetzung o.a.</p>-->
<!--                    <p>Im CourtPicker-Konfigurator kannst Du beliebige Reservierungskategorien definieren. Damit kannst Du festlegen, -->
<!--                    welchen Namen jede Kategorie haben soll und in welcher Farbe unterschiedliche Reservierungskategorien in den Reservierungsansichten angezeigt werden sollen. -->
<!--                    </p>-->
<!--                    <p>-->
<!--                    So kannst Du und Deine Kunden schnell erkennen was der Reservierungszweck jeder Reservierung ist.  -->
<!--                    </p>-->
<!--                </div>-->
<!--            </div>-->
<!--        <p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--        <hr class="featurette-divider">-->
        
        <div class="row featurette">
            <a name="priceconfig"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/2-Tarifkonfigurator.png" alt="tarifkonfig">
                </div>
                <div class="col-md-8 text-justify" >
                    <h3 class="featurette-heading">Verschiedene Tarife definieren.</h3>
                    <p class="lead">Eigene Tarife für jede Platzart je nach Saison, Wochentag, Uhrzeit und Benutzergruppe.</p>
                    <p>Du kannst sowohl Einzelstunden- als auch Abostundentarife definieren.
                        <ul>
                            <li><b>Tarife je Wochentag und Uhrzeit</b>: z.B. Montagstunden am Nachmittag haben einen anderen Preis als Dienstagstunden
                            </li>
                            <br>
                            <li><b>Tarife je nach Saison</b>: z.B. Sommertarife vs. Wintertarife.
                            </li>
                            <br>
                            <li><b>Tarife je Kundengruppe</b>: z.B. Tarife für Clubmitglieder vs. Tarife für Nicht-Mitglieder.
                            </li>
                        </ul>
                        <p><b>Wichtig:</b> Obwohl die konfigurierten Tarife automatisch errechnet und verwendet werden, 
                        können Benutzer mit ensprechender Berechtigung, Tarife von getätigten Reservierungen jeder Zeit überschreiben. 
                        Damit bietet CourtPicker Flexibilität bei der Abrechnung.
                        </p>
                </div>
            </div>
        <p class="pull-right"><a href="#">Nach oben</a></p><br>
        <hr class="featurette-divider">
        
        <div class="row featurette">
            <a name="layoutconfig"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/EigenesLayout.gif" alt="designkonfig">
                </div>
                <div class="col-md-8 text-justify">
                    <h3 class="featurette-heading text-justify">Dein eigenes Layout.</h3>
                    <p class="lead">Dein CourtPicker im Vereins- bzw. Firmenlayout.</p>
                    <ul>
                        <li>
                        Im CourtPicker-Konfigurator, kannst Du Dein <b>eigenes Logo hochladen</b> 
                        </li>
                        <br>
                        <li>Du kannst das <b>Look and Feel Deines CourtPickers gestalten</b> 
                        </li>
                        <br>
                        <li>Wenn Dir das Design nicht mehr gefällt, kannst Du es <b>jederzeit ändern</b>
                        </li>
                    </ul>
                </div>
            </div>
        <p class="pull-right"><a href="#">Nach oben</a></p><br>
        <hr class="featurette-divider">
        
        
        <h2>Reservierungsfunktionalitäten</h2>
        <hr class="divider">    
        
        <div class="row featurette">
            <a name="combinedweekview"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/4-kombinierte-Wochenansicht.png" alt="weekview">
                </div>
                <div class="col-md-8 text-justify">
                    <h3 class="featurette-heading">Kombinierte Wochenansicht.</h3>
                    <p class="lead">Kein Scrollen zur Seite oder nach unten. Komplette Übersicht auf einer Bildschirmseite.</p>
                    <p> 
                    <ul>
                        <li>Die <b>CourtPicker-Wochen-Schnellansicht</b> bietet eine rasche Übersicht über die aktuelle Woche:</p>
                            <ul>
                                <li>Alle Zeiten, zu denen alle Plätze ausreserviert sind, werden als "voll reserviert" (rot) angezeigt.
                                </li>
                                <li>Alle Zeiten, zu denen ein Drittel aller Plätze ausreserviert ist, werden als "teilweise belegt" (hellgelb) angezeigt.
                                </li>
                                <li>Alle Zeiten, zu denen zwei Drittel aller Plätze ausreserviert ist, werden als "fast vollständig belegt" (dunkelgelb) angezeigt.
                                </li>
                                <li>Alle Zeiten, zu denen noch gar kein Platz reserviert ist, werden als "frei" angezeigt.
                                </li>
                            </ul>
                        </li>
                        <li><b>Platzreservierung durch Klick</b> auf eine teilweise reservierte oder freie Zeit.
                        </li>
                        <li>Sowohl <b>wochenweises Blättern</b> als auch die Auswahl eines bestimmten Datums ist möglich.
                        </li>
                        <li>Du kannst <b>einen einzelnen Platz auswählen</b>, um die Wochendetailansicht für diesen Platz zu sehen. 
                        </li>
                    </ul>
                </div>
            </div>
        <p class="pull-right"><a href="#">Nach oben</a></p><br>
        <hr class="featurette-divider">
        
        <div class="row featurette">
            <a name="dayview"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/5-dayview.png" alt="image">
                </div>
                <div class="col-md-8 text-justify">
                    <h3 class="featurette-heading">Tagesansicht für Reservierungsdetails.</h3>
                    <p class="lead">Alle Plätze für den gewählten Tag anzeigen.</p>
                    <ul>
                        <li><b>Tageweises Blättern</b> oder Auswahl eines bestimmten Datums ist möglich.
                        </li>
                        <li>Du kannst <b>Plätze ein- oder ausblenden</b>. 
                        </li>
                        <li>Durch Klick auf eine freie Stunde kannst Du einen <b>freien Platz reservieren</b>.
                        </li>
                    </ul>
                </div>
            </div>
        <p class="pull-right"><a href="#">Nach oben</a></p><br>
        <hr class="featurette-divider">
        
        <div class="row featurette">
            <a name="reservation"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/7-abobooking.png" alt="abo">
                </div>
                <div class="col-md-8 text-justify">
                    <h3 class="featurette-heading">Einzel- und Aboreservierungen durchführen.</h3>
                    <p class="lead">Für einmalige oder periodische Reservierungen.</p>
                    <ul>
                        <li><b>Abos für vordefinierte Saisonen</b>. D.h. bei einer Aboreservierung wir die Stunde an dem Tag, z.B. Montag 15:00, in jeder Woche der Saison reserviert.
                        </li>
                        <li>Falls Du eine Reservierung doch nicht einhalten kannst, kannst Du diese <b>Reservierungen einfach stornieren</b>.
                        </li>
                    </ul>
                </div>
            </div>
        <p class="pull-right"><a href="#">Nach oben</a></p><br>
        <hr class="featurette-divider">
        
<!--        <div class="row featurette">-->
<!--            <a name="emails"></a>-->
<!--                <div class="col-md-8 text-justify">-->
<!--                    <h2 class="featurette-heading">Email-Bestätigungen.<br> <span class="text-muted">Als Nachweis der erfolreichen Reservierung.</span></h2>-->
<!--                    <p class="lead">Zur Sicherheit.</p>-->
<!--                    <p>Jede Reservierung bzw. Stornierung einer Reservierung wir mit einer Email-Bestätigung an den reservierenden/stornierenden Benutzer abgeschlossen.-->
<!--                    </p>-->
<!--                </div>-->
<!--                <div class="col-md-5">-->
<!--                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/startpage.gif" alt="image">-->
<!--                </div>-->
<!--            </div>-->
<!--        <p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--        <hr class="featurette-divider">-->
        
        <div class="row featurette">
            <a name="customerarea"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/6-userarea.png" alt="userarea">
                </div>
                <div class="col-md-8 text-justify">
                    <h3 class="featurette-heading">Eigener Benutzerbereich für Deine Kunden.</h3>
                    <p class="lead">Behalte die Übersicht über Deine Reservierungen.</p>
                    <ul>
                        <li>Eigenen Bereich für jeden Kunden, in dem er seine <b>Reservierungen und Stornierungen verwalten</b> und
                        </li>
                        <li>seine <b>Benutzerprofildaten anpassen</b> kann.
                        </li>
                    </ul>
                </div>
            </div>
        <p class="pull-right"><a href="#">Nach oben</a></p><br>
        <hr class="featurette-divider">
        
        <h2>Administrationsfunktionalitäten</h2>
        <hr class="divider">
        
        <div class="row featurette">
            <a name="userconfig"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/10-privileges.png" alt="privileges">
                </div>
                <div class="col-md-8 text-justify">
                    <h3 class="featurette-heading">Mehrstufiges Berechtigungskonzept.</h3>
                    <p class="lead">Bestimmte Funktionalitäten dürfen nur von berechtigten Benutzern verwendet werden.</p>
                    <p>CourtPicker unterstützt folgende Benutzergruppen mit den folgenden Berechtigungen: </p>
                    <ul>
                        <li><b>Normale Nutzer</b>
                            <ul>
                                <li>Reservierungen für sich selbst durchführen 
                                </li>
                                <li>Reservierungen stornieren
                                </li>
                                <li>Eigenes Benutzerprofil verwalten
                                </li>
                            </ul>
                        </li>
                        <li><b>Administratoren</b>
                            <ul>
                                <li>Reservierungen für andere Benutzer durchführen 
                                </li>
                                <li>Bezahlstatus von Reservierungen einsehen und ändern
                                </li>
                                <li>Reservierungen suchen, filtern, editieren oder löschen
                                </li>
                                <li>Tagesabschlüsse durchführen
                                </li>
                                <li>Kunden anlegen und Kundendaten editieren
                                </li>
                                <li>Konfigurationseinstellungen ändern
                                </li>
                                <li>Benutzer anlegen, ändern, oder löschen
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        <p class="pull-right"><a href="#">Nach oben</a></p><br>
        <hr class="featurette-divider">
        
        <div class="row featurette">
            <a name="payment"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/8-paymentstatus.png" alt="payment">
                </div>
                <div class="col-md-8 text-justify">
                    <h3 class="featurette-heading">Bezahlstatus von Reservierungen verwalten.</h3>
                    <p class="lead">Blitzschnell noch nicht bezahlte Reservierungen finden.</p>
                    <ul>
                        <li>Administratoren können den <b>Bezahlstatus einzelner Reservierungen setzen</b>.
                        </li>
                        <li>Dabei kann er <b>unterschiedliche Bezahlarten auswählen</b>, z.B. "Bar bezahlt", "Mit Bankomat bezahlt" oder eben "Noch nicht bezahlt".
                        </li>
                    </ul>
                </div>
            </div>
        <p class="pull-right"><a href="#">Nach oben</a></p><br>
        <hr class="featurette-divider">
        
        <div class="row featurette">
            <a name="closure"></a>
                <div class="col-md-4">
                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/9-dailyclosing.png" alt="dailyclosing">
                </div>
                <div class="col-md-8 text-justify">
                    <h3 class="featurette-heading">Tagesabschluss auf Knopfdruck.</h3>
                    <p class="lead">Kassasturz am Ende des Tages.</p>
                    <ul>
                        <li><b>Überblick auf Knopfdruck</b> über reservierte Stunden und wieviele davon bereits bezahlt bzw. noch nicht bezahlt sind.
                        </li>
                    </ul>
                </div>
                
            </div>
<!--        <p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--        <hr class="featurette-divider">-->
        
<!--        <div class="row featurette">-->
<!--            <a name="statistics"></a>-->
<!--                <div class="col-md-5">-->
<!--                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/statistics.gif" alt="image">-->
<!--                </div>-->
<!--                <div class="col-md-8 text-justify">-->
<!--                    <h2 class="featurette-heading">Statistiken.<br> <span class="text-muted">Reservierungsverhalten auswerten.</span></h2>-->
<!--                    <p class="lead">Analyse von Platzauslastung und Kundenvorlieben.</p>-->
<!--                    <p>CourtPicker bietet Dir eine Menge an Statistiken, die Du nutzen kannst,-->
<!--                    um die Platzauslastung zu analysieren.-->
<!--                    </p>-->
<!--                    <p>Weitere Statistiken geben Dir die Möglichkeit, die Reservierungsvorlieben Deiner Kunden zu analysieren,-->
<!--                    z.B. wieviel im Vorhinein typischerweise Stunden reserviert werden uvm.-->
<!--                    </p>-->
<!--                    <p>Diese Statistiken ermöglichen Dir einen guten Einblick in die Reservierungen Deiner Plätze und geben Dir die Möglichkeit-->
<!--                    Tarifoptimierungen vorzunehmen und z.B. spezielle Aktionen durchzuführen, um die Platzauslastung zu bestimmten Zeiten zu erhöhen.-->
<!--                    </p>-->
<!--                </div>-->
<!--            </div>-->
<!--        <p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--        <hr class="featurette-divider">-->
        
<!--        <div class="row featurette">-->
<!--            <a name="search"></a>-->
<!--                <div class="col-md-5">-->
<!--                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/adminview.gif" alt="image">-->
<!--                </div>-->
<!--                <div class="col-md-8 text-justify">-->
<!--                    <h2 class="featurette-heading">Reservierungssuche und Excel-Export.<br> <span class="text-muted">Einfache Verwaltung Deiner Reservierungen.</span></h2>-->
<!--                    <p class="lead">Schnelle Suche und Editierung Deiner Reservierungen.</p>-->
<!--                    <h3>Suchen und Filtern</h3>-->
<!--                    <p>Wenn Du als berechtigter Benutzer Reservierungen suchen und editieren willst, kannst Du diese anhand mehrerer Kriterien suchen und danach editieren.-->
<!--                    </p>-->
<!--                    <h3>Reservierungen nach Excel exportieren</h3>-->
<!--                    <p>Die gefilterten Reservierungen kannst Du in eine Excel-Datei exportieren, falls Du die Reservierungsdaten auch ausserhalb von CourtPicker nutzen willst.-->
<!--                    </p>-->
<!--                </div>-->
<!--            </div>-->
<!--        <p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--        <hr class="featurette-divider">-->
        
<!--        <div class="row featurette">-->
<!--            <a name="settings"></a>-->
<!--                <div class="col-md-5">-->
<!--                    <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/startpage.gif" alt="image">-->
<!--                </div>-->
<!--                <div class="col-md-8 text-justify">-->
<!--                    <h2 class="featurette-heading">Hilfreiche Settings.<br> <span class="text-muted">Individuelle Einstellungen.</span></h2>-->
<!--                    <p class="lead">Stelle die korrekte Verwendung Deines CourtPickers sicher.</p>-->
<!--                    <h3>Reservierungslimit</h3>-->
<!--                    <p>Du kannst festlegen wie weit in die Zukunft Reservierungen getätigt werden können. Es macht z.B. wahrscheinlich keinen Sinn, Reservierungen für 2030 zu erlauben.-->
<!--                    Mit diesem Setting kannst ein Datumslimit setzen, über das hinausgehend man nicht mehr reservieren kann.-->
<!--                    </p>-->
<!--                    <h3>Stornierungsfrist</h3>-->
<!--                    <p>Es kann vorkommen, dass Kunden Ihre Reservierung wieder stornieren wollen. Dafür kannst Du ein Limit in Minuten setzen, das angibt wie weit im Voraus man eine Reservierung-->
<!--                    noch löschen kann. Wenn Du diesen Parameter z.B. auf 30 setzt bedeutet das, dass man bis zu einer halben Stunde vor Spielbeginn noch stornieren kann, danach allerdings nicht mehr.-->
<!--                    Das kann dann nur mehr der Admin oder RezeptionistInnen.-->
<!--                    </p>-->
<!--                    <h3>Email-Weiterleitung</h3>-->
<!--                    <p>Wenn du diesen Parameter aktivierst, kannst Du eine oder mehrere Email-Adressen angeben, die bei Reservierung durch einen Kunden ebenfall eine Emailbestätigung erhalten.-->
<!--                    Damit kannst Du per Email über getätigte Reservierungen informiert werden.-->
<!--                    </p>-->
<!--                </div>-->
<!--            </div>-->
	
      <!-- FOOTER -->
	      <hr class="divider">
      <footer>
        <p class="pull-right"><a href="#">Nach oben</a></p>
        <p>&copy; 2014 CourtPicker &middot; <a href="agb.htm">Impressum & AGB</a> &middot; <a href="datasecuritystatement.htm">Datenschutzerklärung</a></p>
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
