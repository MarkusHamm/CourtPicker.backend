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
	<link href="${contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" >
  </head>
<!-- NAVBAR
================================================== -->
  <body>
  	<div id="fb-root"></div>
		<script>(function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.src = "//connect.facebook.net/de_DE/all.js#xfbml=1";
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));</script>
<!--  	<div style="position:absolute;z-index:99999;left:980px;top:-30px;">-->
<!--			<img src="${contextPath}/resources/images/courtpickerAnkuendigung.gif" alt="ankuendigung" width="200px;">-->
<!--	</div>-->
    <div class="navbar-wrapper">
      <div class="navbar navbar-inverse navbar-static-top" role="navigation" style="margin-bottom:0px!important;">
        <div class="container" style="margin-bottom:0px!important;">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand active" href="index.htm"><font color="white"><spring:message code="menubar.courtPicker"/></font></a>
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
<!--			  <div class="navbar-right">-->
<!--		         <div class="btn-group">-->
<!--					  <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">-->
<!--					    <spring:message code="languageSelection"/> <span class="caret"></span>-->
<!--					  </button>-->
<!--					  <ul class="dropdown-menu" role="menu">-->
<!--					    <li><a href="?lang=de"><img src="${contextPath}/resources/css/images/flaggermanaustrian.gif" width="20px;"> Deutsch</a></li>-->
<!--					    <li><a href="?lang=en"><img src="${contextPath}/resources/css/images/englishflag.gif" width="20px;"> English</a></li>-->
<!--					  </ul>-->
<!--				 </div>-->
<!--			</div>-->
          </div>
        </div>       
      </div>
    </div>
	<!-- Carousel
    ================================================== -->
	<div class="container" style="margin-top:0px!important;">
		<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
	      <ol class="carousel-indicators">
	        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	        <li data-target="#carousel-example-generic" data-slide-to="3"></li>
	      </ol>
	      <div class="carousel-inner">
	      	<div class="item active">
	          <img src="${contextPath}/resources/images/de/courtpickercarousel1newwithlogo.gif" alt="First slide">
	          <div class="carousel-caption">
<!--	          	<h2><spring:message code="carousel.slide1.header"/></h2>-->
<!--	     		<p class="lead"><spring:message code="carousel.slide1"/></p>-->
	          </div>	
	        </div>
	        <div class="item">
	          <img src="${contextPath}/resources/images/de/courtpickercarousel4new.gif" alt="First slide">
	          <div class="carousel-caption">
<!--	     		<p class="lead"><spring:message code="carousel.slide2"/></p>-->
	          </div>	
	        </div>
	        <div class="item">
	          <img src="${contextPath}/resources/images/de/courtpickercarousel3new.gif" alt="Second slide">
	          <div class="carousel-caption">
<!--	          	<p class="lead"><spring:message code="carousel.slide3"/></p>-->
	          </div>
	        </div>
	        <div class="item">
	          <img src="${contextPath}/resources/images/de/courtpickercarousel2new.gif" alt="Third slide">
	          <div class="carousel-caption">
<!--	          	<p class="lead"><spring:message code="carousel.slide4"/></p>-->
	          </div>
	        </div>
	      </div>
	      <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
	        <span class="icon-prev"></span>
	      </a>
	      <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
	        <span class="icon-next"></span>
	      </a>
	    </div>
	  <hr class="featurette-divider" style="margin-top:0px!important;">
	  </div>
    <!-- Marketing messaging and featurettes
    ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->

    <div class="container marketing">

      <!-- Three columns of text below the carousel -->
	  <div class="row">
        <div class="col-lg-4">
<!--          <img class="img-circle" src="${contextPath}/resources/css/images/questionmark.png" width="50" height="50" alt="Generic placeholder image">-->
          <h2><spring:message code="index.advantages.header"/></h2>
          <p><spring:message code="index.advantages.text"/></p>
          <p><a class="btn btn-default" href="benefits.htm" role="button"><spring:message code="index.advantages.button"/> &raquo;</a>
          </p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
<!--          <img class="img-circle" src="${contextPath}/resources/css/images/preisschild.png" width="50" height="50" alt="Generic placeholder image">-->
          <h2><spring:message code="index.prices.header"/></h2>
          <p><spring:message code="index.prices.text"/></p>
          <p><a class="btn btn-default" href="pricelist.htm" role="button"><spring:message code="index.prices.button"/> &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
<!--          <img class="img-circle" src="${contextPath}/resources/css/images/zahnrad.png" width="50" height="50" alt="Generic placeholder image">-->
          <h2><spring:message code="index.tryOut.header"/></h2>
          <p><spring:message code="index.tryOut.text"/></p>
          <p><a class="btn btn-primary" href="/configurator" role="button"><spring:message code="index.tryOut.button"/> &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
      </div>


<!--       START THE FEATURETTES -->
<!---->
<!--      <hr class="featurette-divider">-->
<!---->
<!--      <div class="row featurette">-->
<!--        <div class="col-md-7">-->
<!--          <h2 class="featurette-heading"><spring:message code="label.featureconfigurability"/> <span class="text-muted">It'll blow your mind.</span></h2>-->
<!--          <p class="lead"><spring:message code="label.featureconfigurabilitytext"/></p>-->
<!--        </div>-->
<!--        <div class="col-md-5">-->
<!--          <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/startpage.gif"" alt="Generic placeholder image">-->
<!--        </div>-->
<!--      </div>-->
<!---->
<!--      <hr class="featurette-divider">-->
<!---->
<!--      <div class="row featurette">-->
<!--        <div class="col-md-5">-->
<!--          <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/views.png" alt="Generic placeholder image">-->
<!--        </div>-->
<!--        <div class="col-md-7">-->
<!--          <h2 class="featurette-heading"><spring:message code="label.featureview"/> <span class="text-muted">See for yourself.</span></h2>-->
<!--          <p class="lead"><spring:message code="label.featureviewtext"/></p>-->
<!--        </div>-->
<!--      </div>-->
<!---->
<!--      <hr class="featurette-divider">-->
<!---->
<!--      <div class="row featurette">-->
<!--        <div class="col-md-7">-->
<!--          <h2 class="featurette-heading"><spring:message code="label.featureadministration"/> <span class="text-muted">Checkmate.</span></h2>-->
<!--          <p class="lead"><spring:message code="label.featureadministrationtext"/></p>-->
<!--        </div>-->
<!--        <div class="col-md-5">-->
<!--          <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/views.png" alt="Generic placeholder image">-->
<!--        </div>-->
<!--      </div>-->
<!---->
<!--      <hr class="featurette-divider">-->
<!--      -->
<!--      <div class="row featurette">-->
<!--        <div class="col-md-5">-->
<!--          <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/statistics.gif" alt="Generic placeholder image">-->
<!--        </div>-->
<!--        <div class="col-md-7">-->
<!--          <h2 class="featurette-heading"><spring:message code="label.featurestatistics"/><span class="text-muted">See for yourself.</span></h2>-->
<!--          <p class="lead"><spring:message code="label.featurestatisticstext"/></p>-->
<!--        </div>-->
<!--      </div>-->
<!--      -->
<!--      <hr class="featurette-divider">-->
<!--      -->
<!--      <div class="row featurette">-->
<!--        <div class="col-md-7">-->
<!--          <h2 class="featurette-heading"><spring:message code="label.featuremanymore"/><span class="text-muted">Checkmate.</span></h2>-->
<!--          <p class="lead"><spring:message code="label.featuremanymoretext"/></p>-->
<!--        </div>-->
<!--        <div class="col-md-5">-->
<!--          <img class="featurette-image img-responsive" src="${contextPath}/resources/css/images/views.png" alt="Generic placeholder image">-->
<!--        </div>-->
<!--      </div>-->

 <!-- /END THE FEATURETTES -->


      <!-- FOOTER -->
      <hr class="divider">
      <footer>
      	<div class="row">
			 <div class="col-md-10">
			 	<p>&copy; 2014 CourtPicker &middot; <a href="agb.htm">AGB</a> &middot; <a href="datasecuritystatement.htm">Datenschutzerklärung</a></p>
			 </div>
			 <div class="fb-like col-md-2" data-href="https://www.facebook.com/courtpicker" data-layout="button_count" data-action="like" data-show-faces="false" data-share="false" style="align:right;">
			 </div>
		</div>            
      </footer>

    </div><!-- /.container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
<!--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>-->
    <script src="${contextPath}/resources/js/jquery-1.8.2.js"></script>
	<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.js"></script>
	<script src="${contextPath}/resources/js/jquery-ui-1.9.1.custom.min.js"></script>
    <script src="${contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
  </body>
</html>
