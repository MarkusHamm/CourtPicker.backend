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
<!--                <li><a href="pricelist.htm">Preise</a></li>-->
<!--                <li><a href="http://localhost:8080/app/cp.html#/configureCourts?createNew">Try now!</a></li>-->
<!--                <li><a href="ueberuns.htm">Über Uns</a></li>-->
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
			 <div class="col-md-6"><h1>Funktionalitäten von CourtPicker</h1>
			 </div>
			 <div class="col-md-6"><span class="pull-right"><br><a class="btn btn-success" href="/configurator" role="button">Meinen CourtPicker jetzt ausprobieren &raquo;</a></span>
			 </div>
		</div>  	
    	<hr class="divider">	
		<h2>Online-Konfiguration</h2>
		<hr class="divider">	
		
		<div class="row featurette">
	    	<a name="courtconfig"></a>
	    		<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/1-Platzkonfigurator.png" alt="courtconfig">
    			</div>
    			<div class="col-md-6 text-justify">
    				<h2 class="featurette-heading">Plätze Deiner Anlage konfigurieren.<br> <span class="text-muted">Erfüllt Deine Anforderungen.</span></h2>
		          	<p class="lead">Für jede Sportanlage eine Lösung. Plätze aller Art. Soviele Plätze du willst.</p>
		          	<h3>Platzkategorien festlegen</h3>
				  	<p>Viele Sportanlagen haben verschiedene Platzkategorien mit unterschiedliche Tarifen und Reservierungseinheiten. 
				  	So haben z.B. Hallen-Tennisplätze andere Preise als Freiluftplätze. Und Tennisplätze sind meistens in Stundeneinheiten zu reservieren, 
				  	während Badminton- oder Squashplätze in 30-Minuten- bzw. 15-Minuten-Einheiten reserviert werden können.
				    </p>
				    <p>Mit CourtPicker kannst Du <b>Plätze aller Art verwalten</b>, d.h. nicht nur Plätze für <b>Fussball, Tennis, Squash, Badminton oder Golfkojen</b>, 
				    sondern z.B. <b>auch Billiardtische oder Bowlingbahnen</b>. 
				    </p>
				    <p>Für jede Platzkategorie kannst Du den <b>Namen</b> und die <b>Einheitsgröße</b> definieren, z.B. Tennis: 60 min, Badminton: 30 min, Sqash: 15 min.
				    </p>
				    <h3>Plätze anlegen</h3>
				    <p>Für jede angelegte Platzkategorie kannst Du dann Plätze anlegen, für die Du den <b>Namen</b> angeben kannst. Ausserdem kannst Du für jeden Platz <b>die Reservierbarkeit festlegen</b>, d.h. einstellen, ob der Platz reservierbar sein soll oder nicht.
				    </p>
				    <p>Diese Settings kannst Du jederzeit anpassen. Es kann ja vorkommen, dass manche Plätze nicht reservierbar sind, weil sie z.B. erst instand gesetzt werden müssen oder aufgrund der Witterung nicht bespielbar sind.
				    z.B. 5 Tennisplätze und 3 Squashplätze
				    Die definierten Plätze sind dann über Ihren CourtPicker reservierbar und verwaltbar
				  	</p>
    			</div>
      		</div>
      	<p class="pull-right"><a href="#">Nach oben</a></p><br>
      	<hr class="featurette-divider">
      	
<!--      	<div class="row featurette">-->
<!--	    	<a name="reservationconfig"></a>-->
<!--	    		<div class="col-md-5">-->
<!--    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/startpage.gif" alt="image">-->
<!--    			</div>-->
<!--    			<div class="col-md-7 text-justify">-->
<!--    				<h2 class="featurette-heading">Deine eigenen Reservierungskategorien.<br> <span class="text-muted">Schnell erkennbare Reservierungstypen.</span></h2>-->
<!--		          	<p class="lead">Markiere Deine Reservierungen als Meisterschaftstermin, Wintercup, Instandsetzung o.a.</p>-->
<!--				  	<p>Im CourtPicker-Konfigurator kannst Du beliebige Reservierungskategorien definieren. Damit kannst Du festlegen, -->
<!--				  	welchen Namen jede Kategorie haben soll und in welcher Farbe unterschiedliche Reservierungskategorien in den Reservierungsansichten angezeigt werden sollen. -->
<!--				  	</p>-->
<!--				  	<p>-->
<!--				  	So kannst Du und Deine Kunden schnell erkennen was der Reservierungszweck jeder Reservierung ist.  -->
<!--				    </p>-->
<!--    			</div>-->
<!--      		</div>-->
<!--      	<p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--      	<hr class="featurette-divider">-->
      	
      	<div class="row featurette">
	    	<a name="priceconfig"></a>
    			<div class="col-md-6 text-justify" >
    				<h2 class="featurette-heading">Tarife je Platzart festlegen.<br> <span class="text-muted">Jeden Platz zu seinem Preis.</span></h2>
		          	<p class="lead">Preise für jede Platzkategorie je nach Saison, Wochentag, Uhrzeit und Benutzergruppe.</p>
				  	<p>Du kannst <b>für jede Platzkategorie eigene Tarife festlegen</b>. Ein Tennisplatz hat ja zum Beispiel einen anderen Preis als ein Squash- oder Badmintonplatz. 
				  	Dabei hast Du folgende Möglichkeiten Tarife für jede Patzkategorie zu definieren.
				  		<h3>Einzeltarif vs. Abotarif</h3>
				  		<p>Prinzipiell kann man Reservierungen in Einzelreservierung und Aboreservierung einteilen. Eine Einzelreservierung ist eine einmalige Reservierung, 
				  		während eine Abostunde eine periodische Reservierung ist, z.B. jeden Montag in der Wintersaison von 18-20 Uhr.
				  		Die Preisgestaltung für beide Reservierungsarten ist unterschiedlich und kann mit CourtPicker entsprechend abgebildet werden.</p>
						<h3>Tarif je Kundengruppe</h3>
						<p>Viele Sportvereine bzw. Sportanlagen haben für Mitglieder andere Tarife als für Nicht-Mitglieder. 
						Oder aber auch unterschiedliche Tarife für Studenten oder Pensionisten. 
						Mit CourtPicker kannst Du eigene Kundengruppen festlegen und dann eigene Tarife je Kundengruppe definieren.</p>
					  	<h3>Tarif je Saison</h3>
					  	<p>Abhängig von der Jahreszeit variieren die Preise. So kostet ein Hallen-Tennisplatz z.B. in der Wintersaison üblicherweise mehr als in der Sommersaison. 
					  	Mit CourtPicker kannst Du eigene Saisonen definieren und ihnen dann Tarife zuordnen.</p>
					  	<h3>Tarif je Wochentag</h3>
					  	<p>In vielen Vereinen oder Sportanlagen gibt es für das Wochenende andere Preise als für normale Arbeitstage. 
					  	Mit CourtPicker kannst Du für jeden Wochentage eigene Tarife definieren.</p>
					  	<h3>Tarif je Uhrzeit</h3>
						<p>Ein und derselbe Platz kostet vielleicht am Abend mehr als am Vormittag. Mit CourtPicker können Sie, Tageszeitbereiche definieren und ihnen dann Tarife zuordnen.</p>
						<br>
						<p>Die oben angegebenen Parameter sind miteinander kombinierbar, 
						d.h. Du kannst z.B. einen Einzelstundentarif für eine bestimmte Kundengruppe festlegen und dabei noch unterscheiden, 
						welcher Preis zu welcher Jahreszeit, an welchem Tag und zu welcher Uhrzeit gelten soll.</p>
						<p><b>Wichtig:</b> Obwohl die konfigurierten Tarife automatisch errechnet und verwendet werden, wenn Deine Kunden eine Reservierung durchführen, 
						kannst Du den errechneten Tarif mit ensprechender Berechtigung, z.B. als Admin, jeder Zeit überschreiben. Damit bietet CourtPicker auch die notwendige Flexibilität.
						</p>
    			</div>
    			<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/2-Tarifkonfigurator.png" alt="tarifkonfig">
    			</div>
      		</div>
      	<p class="pull-right"><a href="#">Nach oben</a></p><br>
      	<hr class="featurette-divider">
      	
      	<div class="row featurette">
	    	<a name="layoutconfig"></a>
	    		<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/3-Designkonfigurator.png" alt="designkonfig">
    			</div>
    			<div class="col-md-6 text-justify">
    				<h2 class="featurette-heading text-justify">Eigenes Design für Deinen CourtPicker.<br> <span class="text-muted">Unverwechselbar.</span></h2>
		          	<p class="lead">Dein CourtPicker im Vereins- bzw. Firmenlayout.</p>
				  	<p>Im CourtPicker-Konfigurator, kannst Du Dein eigenes Logo hochladen und dann das Look and Feel Deines CourtPickers gestalten, 
				  	indem Du die Schriftfarben und die Farben aller angezeigten Elemente festlegen kannst.
				  	</p>
				  	<p>Wenn Dir das Design nicht mehr gefällt, kannst Du es jederzeit ändern.
				  	</p>
    			</div>
      		</div>
      	<p class="pull-right"><a href="#">Nach oben</a></p><br>
      	<hr class="featurette-divider">
      	
      	
      	<h2>Reservierungsfunktionalitäten</h2>
		<hr class="divider">	
		
		<div class="row featurette">
	    	<a name="combinedweekview"></a>
    			<div class="col-md-6 text-justify">
    				<h2 class="featurette-heading">Kombinierte Wochenansicht.<br> <span class="text-muted">Für den kompletten Überblick.</span></h2>
		          	<p class="lead">Kein Scrollen zur Seite oder nach unten. Komplette Übersicht auf einer Bildschirmseite.</p>
				  	
				  	<h3>Intelligente Wochenansicht (Kapazitätsansicht)</h3>
				  	<p> Die CourtPicker-Wochen-Schnellansicht bietet eine rasche Übersicht über die aktuelle Woche:</p>
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
				    <p>
				    Durch Klick auf eine teilweise reservierte oder freie Zeit kann ein Platz reserviert werden.
				    Sowohl wochenweises Blättern als auch die Auswahl eines bestimmten Datums ist möglich.
				    </p>
				    <p>Durch die kombinierte Wochenansicht musst Du nicht mehr Scrollen um Dir einen Überblick über die Platzkapazitäten der ausgewählten Woche zu verschaffen. 
				    </p>
				    <h3>Wochenansicht für einen einzelnen Platz</h3>
					<p>Falls der schnelle Überblick in der kombinierten Wochenansicht nicht genügt, kannst Du dort einen bestimmten Platz auswählen, 
					um die Wochendetailansicht für diesen Platz zu sehen. Dort werden auch die Reservierungskategorien und die Reservierungsnamen (optional) angezeigt.
				  	</p>
    			</div>
    			<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/4-kombinierte-Wochenansicht.png" alt="weekview">
    			</div>
      		</div>
      	<p class="pull-right"><a href="#">Nach oben</a></p><br>
      	<hr class="featurette-divider">
      	
      	<div class="row featurette">
	    	<a name="dayview"></a>
	    		<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/5-dayview.png" alt="image">
    			</div>
    			<div class="col-md-6 text-justify">
    				<h2 class="featurette-heading">Tagesansicht.<br> <span class="text-muted">Für Reservierungsdetails.</span></h2>
		          	<p class="lead">Alle Plätze für den gewählten Tag anzeigen.</p>
				  	<p>Die Tages-Mehrplatzansicht ist eine Tagesansicht und erlaubt Dir, die Belegung einzelner Plätze anzusehen.
				    Tageweises Blättern oder Auswahl eines bestimmten Datums ist möglich.
				    </p>
				    <p>
				    Du kannst selbst auswählen, 
				    welche Plätze angezeigt/ausgeblendet werden sollen. Durch Klick auf eine freie Stunde kannst Du einen freien Platz reservieren.
				    </p>
    			</div>
      		</div>
      	<p class="pull-right"><a href="#">Nach oben</a></p><br>
      	<hr class="featurette-divider">
      	
      	<div class="row featurette">
	    	<a name="reservation"></a>
	    		<div class="col-md-6 text-justify">
    				<h2 class="featurette-heading">Einzel- und Aboreservierungen.<br> <span class="text-muted">Schnell und einfach reservieren.</span></h2>
		          	<p class="lead">Für einmalige oder periodische Reservierungen.</p>
				  	<p>CourtPicker erlaubt nicht nur das Reservieren von Einzelstunden, sondern auch Reservierungen von Abostunden.
				  	</p>
				  	<p>Abhängig davon, welche Saisonen Du in Deinem CourtPicker konfiguriert hast, kannst Du Abos für diese Saisonen reservieren.
				  	D.h. bei einer Aboreservierung wir die Stunde an dem Tag, z.B. Montag 15:00, in jeder Woche der Saison reserviert.
				  	</p>
				  	<p>Falls Du eine Reservierung doch nicht einhalten kannst, kannst Du diese Reservierungen auch ganz einfach wieder stornieren.
				  	</p>
    			</div>
    			<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/7-abobooking.png" alt="abo">
    			</div>
      		</div>
      	<p class="pull-right"><a href="#">Nach oben</a></p><br>
      	<hr class="featurette-divider">
      	
<!--      	<div class="row featurette">-->
<!--	    	<a name="emails"></a>-->
<!--    			<div class="col-md-8 text-justify">-->
<!--    				<h2 class="featurette-heading">Email-Bestätigungen.<br> <span class="text-muted">Als Nachweis der erfolreichen Reservierung.</span></h2>-->
<!--		          	<p class="lead">Zur Sicherheit.</p>-->
<!--				  	<p>Jede Reservierung bzw. Stornierung einer Reservierung wir mit einer Email-Bestätigung an den reservierenden/stornierenden Benutzer abgeschlossen.-->
<!--				  	</p>-->
<!--    			</div>-->
<!--    			<div class="col-md-5">-->
<!--    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/startpage.gif" alt="image">-->
<!--    			</div>-->
<!--      		</div>-->
<!--      	<p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--      	<hr class="featurette-divider">-->
      	
      	<div class="row featurette">
	    	<a name="customerarea"></a>
	    		<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/6-userarea.png" alt="userarea">
    			</div>
    			<div class="col-md-6 text-justify">
    				<h2 class="featurette-heading">Eigener Benutzerbereich für Deine Kunden.<br> <span class="text-muted">Zur Verwaltung der getätigten Reservierungen.</span></h2>
		          	<p class="lead">Behalte die Übersicht über Deine Reservierungen.</p>
				  	<p>CourtPicker bietet jedem registrierten Benutzer einen eigenen Bereich,
				  	in dem er seine Reservierungen und Stornieren verwalten kann und wo er auch seine
				  	Benutzerprofildaten anpassen kann.
				  	</p>
    			</div>
      		</div>
      	<p class="pull-right"><a href="#">Nach oben</a></p><br>
      	<hr class="featurette-divider">
      	
      	<h2>Administrationsfunktionalitäten</h2>
		<hr class="divider">
		
		<div class="row featurette">
	    	<a name="userconfig"></a>
    			<div class="col-md-6 text-justify">
    				<h2 class="featurette-heading">Mehrstufiges Berechtigungskonzept.<br> <span class="text-muted">Nutzer sind unterschiedlich.</span></h2>
		          	<p class="lead">Bestimmte CourtPicker-Funktionalitäten dürfen nur von speziell dafür berechtigten Benutzern verwendet werden.</p>
				  	<p>CourtPicker unterstützt folgende Berechtigungsgruppen: </p>
				  	<h3>Normale Nutzer</h3>
				  	<p>Normale CourtPicker-Benutzer können folgende Aktionen durchführen:
				  	<ul>
				  		<li>Reservierungen für sich selbst durchführen 
				  		</li>
				  		<li>Reservierungen stornieren
				  		</li>
				  		<li>Eigenes Benutzerprofil verwalten
				  		</li>
				  	</ul>
				  	<h3>RezeptionistInnen</h3> 
				  	<p>RezeptionistInnen haben mehr Optionen als normale Benutzer, z.B. können Sie:</p>
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
					  	</ul>
					<h3>Administratoren</h3> 
				  	<p>haben alle Rechte im System und können zusätzlich zu oben genannten Aktivitäten z.B.</p>
					  	<ul>
					  		<li>Konfigurationseinstellungen ändern
					  		</li>
					  		<li>Benutzer anlegen, ändern, oder löschen
					  		</li>
					  	</ul>
    			</div>
    			<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/10-privileges.png" alt="privileges">
    			</div>
      		</div>
      	<p class="pull-right"><a href="#">Nach oben</a></p><br>
      	<hr class="featurette-divider">
		
		<div class="row featurette">
	    	<a name="payment"></a>
	    		<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/8-paymentstatus.png" alt="payment">
    			</div>
    			<div class="col-md-6 text-justify">
    				<h2 class="featurette-heading">Bezahlstatus von Reservierungen verwalten.<br> <span class="text-muted">Einfache Kontrolle.</span></h2>
		          	<p class="lead">Finde blitzschnell noch nicht bezahlte Reservierungen.</p>
				  	<p>Berechtigte Benutzer (RezeptionistInnen oder Admins) können den Bezahlstatus einzelner Reservierungen setzen.
				  	Dabei kann er unterschiedliche Bezahlweisen auswählen, z.B. "Bar bezahlt", "Mit Bankomat bezahlt" oder eben "Noch nicht bezahlt".
				  	</p>
    			</div>
      		</div>
      	<p class="pull-right"><a href="#">Nach oben</a></p><br>
      	<hr class="featurette-divider">
      	
      	<div class="row featurette">
	    	<a name="closure"></a>
    			<div class="col-md-6 text-justify">
    				<h2 class="featurette-heading">Tagesabschluss auf Knopfdruck.<br> <span class="text-muted">Schnelle Abrechnung des aktuellen Tages.</span></h2>
		          	<p class="lead">Kassasturz am Ende des Tages.</p>
				  	<p>In manchen Sportanlagen, muss am Ende des Tages abgerechnet werden, wieviele Stunden reserviert worden sind und wieviele Stunden davon bereits bezahlt und
				  	wieviele noch nicht bezahlt sind. CourtPicker liefert so einen Tagesabschluss auf Knopfdruck.
				  	</p>
    			</div>
    			<div class="col-md-6">
    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/9-dailyclosing.png" alt="dailyclosing">
    			</div>
      		</div>
<!--      	<p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--      	<hr class="featurette-divider">-->
      	
<!--      	<div class="row featurette">-->
<!--	    	<a name="statistics"></a>-->
<!--	    		<div class="col-md-5">-->
<!--    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/statistics.gif" alt="image">-->
<!--    			</div>-->
<!--    			<div class="col-md-8 text-justify">-->
<!--    				<h2 class="featurette-heading">Statistiken.<br> <span class="text-muted">Reservierungsverhalten auswerten.</span></h2>-->
<!--		          	<p class="lead">Analyse von Platzauslastung und Kundenvorlieben.</p>-->
<!--				  	<p>CourtPicker bietet Dir eine Menge an Statistiken, die Du nutzen kannst,-->
<!--				  	um die Platzauslastung zu analysieren.-->
<!--				  	</p>-->
<!--				  	<p>Weitere Statistiken geben Dir die Möglichkeit, die Reservierungsvorlieben Deiner Kunden zu analysieren,-->
<!--				  	z.B. wieviel im Vorhinein typischerweise Stunden reserviert werden uvm.-->
<!--				  	</p>-->
<!--				  	<p>Diese Statistiken ermöglichen Dir einen guten Einblick in die Reservierungen Deiner Plätze und geben Dir die Möglichkeit-->
<!--				  	Tarifoptimierungen vorzunehmen und z.B. spezielle Aktionen durchzuführen, um die Platzauslastung zu bestimmten Zeiten zu erhöhen.-->
<!--				  	</p>-->
<!--    			</div>-->
<!--      		</div>-->
<!--      	<p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--      	<hr class="featurette-divider">-->
      	
<!--      	<div class="row featurette">-->
<!--	    	<a name="search"></a>-->
<!--	    		<div class="col-md-5">-->
<!--    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/adminview.gif" alt="image">-->
<!--    			</div>-->
<!--    			<div class="col-md-8 text-justify">-->
<!--    				<h2 class="featurette-heading">Reservierungssuche und Excel-Export.<br> <span class="text-muted">Einfache Verwaltung Deiner Reservierungen.</span></h2>-->
<!--		          	<p class="lead">Schnelle Suche und Editierung Deiner Reservierungen.</p>-->
<!--				  	<h3>Suchen und Filtern</h3>-->
<!--				  	<p>Wenn Du als berechtigter Benutzer Reservierungen suchen und editieren willst, kannst Du diese anhand mehrerer Kriterien suchen und danach editieren.-->
<!--				  	</p>-->
<!--				  	<h3>Reservierungen nach Excel exportieren</h3>-->
<!--				  	<p>Die gefilterten Reservierungen kannst Du in eine Excel-Datei exportieren, falls Du die Reservierungsdaten auch ausserhalb von CourtPicker nutzen willst.-->
<!--				  	</p>-->
<!--    			</div>-->
<!--      		</div>-->
<!--      	<p class="pull-right"><a href="#">Nach oben</a></p><br>-->
<!--      	<hr class="featurette-divider">-->
      	
<!--      	<div class="row featurette">-->
<!--	    	<a name="settings"></a>-->
<!--	    		<div class="col-md-5">-->
<!--    				<img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/startpage.gif" alt="image">-->
<!--    			</div>-->
<!--    			<div class="col-md-8 text-justify">-->
<!--    				<h2 class="featurette-heading">Hilfreiche Settings.<br> <span class="text-muted">Individuelle Einstellungen.</span></h2>-->
<!--		          	<p class="lead">Stelle die korrekte Verwendung Deines CourtPickers sicher.</p>-->
<!--				  	<h3>Reservierungslimit</h3>-->
<!--				  	<p>Du kannst festlegen wie weit in die Zukunft Reservierungen getätigt werden können. Es macht z.B. wahrscheinlich keinen Sinn, Reservierungen für 2030 zu erlauben.-->
<!--				  	Mit diesem Setting kannst ein Datumslimit setzen, über das hinausgehend man nicht mehr reservieren kann.-->
<!--				  	</p>-->
<!--				  	<h3>Stornierungsfrist</h3>-->
<!--				  	<p>Es kann vorkommen, dass Kunden Ihre Reservierung wieder stornieren wollen. Dafür kannst Du ein Limit in Minuten setzen, das angibt wie weit im Voraus man eine Reservierung-->
<!--				  	noch löschen kann. Wenn Du diesen Parameter z.B. auf 30 setzt bedeutet das, dass man bis zu einer halben Stunde vor Spielbeginn noch stornieren kann, danach allerdings nicht mehr.-->
<!--				  	Das kann dann nur mehr der Admin oder RezeptionistInnen.-->
<!--				  	</p>-->
<!--				  	<h3>Email-Weiterleitung</h3>-->
<!--				  	<p>Wenn du diesen Parameter aktivierst, kannst Du eine oder mehrere Email-Adressen angeben, die bei Reservierung durch einen Kunden ebenfall eine Emailbestätigung erhalten.-->
<!--				  	Damit kannst Du per Email über getätigte Reservierungen informiert werden.-->
<!--				  	</p>-->
<!--    			</div>-->
<!--      		</div>-->
	
      <!-- FOOTER -->
	      <hr class="divider">
      <footer>
        <p class="pull-right"><a href="#">Nach oben</a></p>
        <p>&copy; 2014 CourtPicker &middot; 
<!--        <a href="agb.htm">AGB</a> &middot; <a href="datasecuritystatement.htm">Datenschutzerklärung</a> &middot; <a href="contact.htm">Kontakt</a>-->
        </p>
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
