 <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <c:set  var="contextPath" value="${pageContext.request.contextPath}" scope="request" />
<div style="background-color:#FFFFFF;width:1024px;height:600px;">
	<div id = "title" style="width:1024px;height:90px;border-top: solid 1px #afafaf;text-align:center;">
		<h1>CourtPicker - <spring:message code="label.menubuttonprices"/></h1>
	</div>
	<div style="border-top-width:1px;border-top-style:solid;border-top-color:#afafaf;">
		<div class="placeholder50">
		</div>
		<div>
			<div style="float:left;width:200px;">
			</div>
			<div style="float:right;width:100px;">
			</div>
			<div style="margin:0 200px;font-size:11px;color:#afafaf;">
				<img alt="priceListImage" src="${contextPath}/resources/css/images/preise2.gif" style="width:600px;" />
			</div>
		</div>
		<!--<table align="center">
			<tr>
				<td class="pricelist-header">Basis-Konfiguration
				</td>
				<td class="pricelist-header" colspan=6>Wieviele Plätze willst Du reservieren können?
				</td>
			</tr>
			<tr>
				<th style="width:320px;text-align:left;">
				</th>
				<td class="pricelist-title-cell">1-2 Plätze
				</td>
				<td class="pricelist-title-cell">3-4 Plätze
				</td>
				<td class="pricelist-title-cell">5-6 Plätze
				</td>
				<td class="pricelist-title-cell">7-8 Plätze
				</td>
				<td class="pricelist-title-cell">9-10 Plätze
				</td>
				<td class="pricelist-title-cell">>10 Plätze
				</td>
			</tr>
			<tr>
				<th style="text-align:left;color:grey;">Basispreis / Monat <font style="font-size:10px;text-decoration:none;">(inkludiert alle Basisfeatures)</font>
				</th>
				<td class="pricelist-cell">25 EUR
				</td>
				<td class="pricelist-cell">29 EUR
				</td>
				<td class="pricelist-cell">34 EUR
				</td>
				<td class="pricelist-cell">39 EUR
				</td>
				<td class="pricelist-cell">44 EUR
				</td>
				<td class="pricelist-cell">50 EUR
				</td>
			</tr>
			<tr style="height:30px;">
			</tr>
			<tr>
				<td class="pricelist-header">Optionale Zusatzfeatures <font style="font-size:10px;text-decoration:none;">(einzeln wählbar)</font>
				</td>
				<td class="pricelist-header" colspan=6>Feature-Preise
				</td>
			</tr>
			<tr>
				<td style="text-align:left;color:grey;">Integration in das CourtPicker Portal (optional)
				</td>
				<td class="pricelist-cell price-optional">9 EUR
				</td>
				<td class="pricelist-cell price-optional">9 EUR
				</td>
				<td class="pricelist-cell price-optional">9 EUR
				</td>
				<td class="pricelist-cell price-optional">9 EUR
				</td>
				<td class="pricelist-cell price-optional">9 EUR
				</td>
				<td class="pricelist-cell price-optional">9 EUR
				</td>
			</tr>
			<tr>
				<td style="text-align:left;color:grey;">Zusätzliche Statistiken (optional)
				</td>
				<td class="pricelist-cell price-optional">5 EUR
				</td>
				<td class="pricelist-cell price-optional">5 EUR
				</td>
				<td class="pricelist-cell price-optional">5 EUR
				</td>
				<td class="pricelist-cell price-optional">5 EUR
				</td>
				<td class="pricelist-cell price-optional">5 EUR
				</td>
				<td class="pricelist-cell price-optional">5 EUR
				</td>
			</tr>
			<tr style="height:20px;">
			</tr>
			<tr>
				<th style="text-align:left;">Maximalpreis / Monat <font style="font-size:10px;text-decoration:none;">(inkludiert alle Zusatzfeatures)</font>
				</th>
				<th class="pricelist-result-cell">39 EUR
				</th>
				<th class="pricelist-result-cell">43 EUR
				</th>
				<th class="pricelist-result-cell">48 EUR
				</th>
				<th class="pricelist-result-cell">53 EUR
				</th>
				<th class="pricelist-result-cell">58 EUR
				</th>
				<th class="pricelist-result-cell">64 EUR
				</th>
			</tr>
			<tr style="height:30px;">
			</tr>
			<tr>
				<th valign=top style="text-align:left;">Inkludierter Leistungsumfang
				</th>
				<td valign=top colspan=6 style="text-align:justify;height:150px;">CourtPicker-Buchungssysteme werden zentral in einem Rechenzentrum gehostet. Dieses Hosting ist in Bezug auf Performance, Verfügbarkeit, Verschlüsselung, Datensicherheit und Daten-Backup ein "Sorglos-Paket" für unsere Kunden und in den oben angegebenen monatlichen Gebühren inkludiert.
				</td>
			</tr>
		</table>
	--></div>
	

</div>