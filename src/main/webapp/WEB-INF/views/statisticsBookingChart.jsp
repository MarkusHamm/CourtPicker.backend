<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="authz" uri="http://acegisecurity.org/authz" %>
<c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />

<script type="text/javascript">
	$.jqplot('statisticsBookingChart',  
			${statistic.getJqPlotData()}, 
			{
				seriesColors: ["#d0e5f5"], 
				animate: false,
				title: '${statistic.title}',
				seriesDefaults: {
                    renderer: $.jqplot.BarRenderer,
                    rendererOptions: {
                       barDirection: 'vertical',
                       animation: {
                    	   speed: 2000
                       }
                   }, 
                   pointLabels: { show: true }
				},
			 	axes: {
			 		xaxis: {
			 			label: '${statistic.keyName}', 
			 			renderer: $.jqplot.CategoryAxisRenderer,
			 			ticks: ${statistic.getJqPlotTicks()}
		 			},
		 			yaxis: {
		 				label: '${statistic.valueName}',
		 				labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
		 				labelOptions: {
		 					angle: 270
		 				}
	 				}
	 			},
				highlighter: {
					sizeAdjust: 7.5
				},
				cursor: {
					show: true
				},
				grid: {
			        
			        background: '#ffffff'      // CSS color spec for background color of grid.
			    }
				
		 	});
</script>


<div id="statisticsBookingChart" style="height: 400px; width: 980px;" />
