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
	                    <li class="dropdown-header"><spring:message code="menubar.features.submenu.section.onlineConfig"/></li>
	                    <li><a href="features.htm#courtconfig"><spring:message code="menubar.features.submenu.courts"/></a></li>
	                    <li><a href="features.htm#reservationconfig"><spring:message code="menubar.features.submenu.reservationCategories"/></a></li>
	                    <li><a href="features.htm#priceconfig"><spring:message code="menubar.features.submenu.tarifs"/></a></li>
	                    <li><a href="features.htm#layoutconfig"><spring:message code="menubar.features.submenu.layout"/></a></li>
	                    <li><a href="features.htm#userconfig"><spring:message code="menubar.features.submenu.authorization"/></a></li>
	<!--                    <li><a href="features.htm#integration">Integration in Deine Homepage</a></li>-->
	                    <li class="divider"></li>
	                    <li class="dropdown-header"><spring:message code="menubar.features.submenu.section.reservationFeatures"/></li>
	                    <li><a href="features.htm#combinedweekview"><spring:message code="menubar.features.submenu.weekView"/></a></li>
	                    <li><a href="features.htm#dayview"><spring:message code="menubar.features.submenu.dayView"/></a></li>
	                    <li><a href="features.htm#reservation"><spring:message code="menubar.features.submenu.singleAndAboReservation"/></a></li>
	                    <li><a href="features.htm#emails"><spring:message code="menubar.features.submenu.email"/></a></li>
	                    <li><a href="features.htm#customerarea"><spring:message code="menubar.features.submenu.userArea"/></a></li>
	                    <li class="divider"></li>
	                    <li class="dropdown-header"><spring:message code="menubar.features.submenu.section.adminFeatures"/></li>
	                    <li><a href="features.htm#payment"><spring:message code="menubar.features.submenu.paymentStatus"/></a></li>
	                    <li><a href="features.htm#closure"><spring:message code="menubar.features.submenu.dayClosure"/></a></li>
	                    <li><a href="features.htm#statistics"><spring:message code="menubar.features.submenu.statistics"/></a></li>
	                    <li><a href="features.htm#search"><spring:message code="menubar.features.submenu.searchAndExcelExport"/></a></li>
	                    <li><a href="features.htm#settings"><spring:message code="menubar.features.submenu.settings"/></a></li>
	<!--                    <li class="divider"></li>-->
	                  </ul>
	                </li>
	                <li><a href="pricelist.htm"><spring:message code="menubar.prices"/></a></li>
	<!--                <li><a href="http://localhost:8080/app/cp.html#/configureCourts?createNew">Try now!</a></li>-->
	                <li><a href="ueberuns.htm"><spring:message code="menubar.about"/></a></li>
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
	          <img src="${contextPath}/resources/css/images/img/de/courtpickercarousel1.gif" alt="First slide">
	          <div class="carousel-caption">
	          	<h2><spring:message code="carousel.slide1.header"/></h2>
	     		<p class="lead"><spring:message code="carousel.slide1"/></p>
	          </div>	
	        </div>
	        <div class="item">
	          <img src="${contextPath}/resources/css/images/img/de/courtpickercarousel2.gif" alt="First slide">
	          <div class="carousel-caption">
	     		<p class="lead"><spring:message code="carousel.slide2"/></p>
	          </div>	
	        </div>
	        <div class="item">
	          <img src="${contextPath}/resources/css/images/img/de/courtpickercarousel3.gif" alt="Second slide">
	          <div class="carousel-caption">
	          	<p class="lead"><spring:message code="carousel.slide3"/></p>
	          </div>
	        </div>
	        <div class="item">
	          <img src="${contextPath}/resources/css/images/img/de/courtpickercarousel4.gif" alt="Third slide">
	          <div class="carousel-caption">
	          	<p class="lead"><spring:message code="carousel.slide4"/></p>
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
          <p><a class="btn btn-success" href="/configurator" role="button"><spring:message code="index.tryOut.button"/> &raquo;</a></p>
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
        <p class="pull-right"><a href="#"><spring:message code="footer.backToTop"/></a></p>
        <p>&copy; 2014 CourtPicker &middot; <a href="agb.htm"><spring:message code="footer.agb"/></a> &middot; <a href="datasecuritystatement.htm"><spring:message code="footer.dataSecurity"/></a> &middot; <a href="contact.htm"><spring:message code="footer.contact"/></a></p>
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
