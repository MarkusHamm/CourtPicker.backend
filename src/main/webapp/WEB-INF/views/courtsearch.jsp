 <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div style="background-color:#FFFFFF;width:1024px;height:500px;">
	<div id = "title" style="width:1024px;height:90px;border-top: solid 1px #afafaf;text-align:center;"">
		<h1>CourtPicker - <spring:message code="label.menubuttoncourtsearch"/></h1>
	</div>
	<div style="border-top-width:1px;border-top-style:solid;border-top-color:#afafaf;">
		<div style="margin:0 auto;background-color:#306EFF;height:150px;width:700px;color:white;
		-webkit-border-bottom-left-radius: 10px;
	-khtml-border-radius-bottomleft: 10px;	
	-moz-border-radius-bottomleft: 10px;
	border-bottom-left-radius: 10px;
	-webkit-border-bottom-right-radius: 10px;
	-khtml-border-radius-bottomright: 10px;	
	-moz-border-radius-bottomright: 10px;
	border-bottom-right-radius: 10px;" id = "courtsearch">
					<div style="float:left;margin:10px;width:500px;">
						<div style="font-size:12pt;width:200px;float:left;">Wo willst Du spielen?
						</div>		
						<div style="font-size:12pt;">
							<input type = 'text' style="width:200px;color:grey;" value="Verein, Ort, Plz, Land"/>
						</div>
						<div style="font-family: Verdana;font-size:12pt;width:200px;float:left;">Wann?
						</div>		
						<div style="font-size:112pt;">
							<input type = 'text' style="width:100px;color:grey;" value="dd.mm.yyyy"/>
						</div>
						<div style="font-size:12pt;width:200px;float:left;">um
						</div>
						<div>
							<select id="timesearch" size="1" style="width:100px;height:25px;">
							      <option value="">06:00</option>
							      <option value="">07:00</option>
							      <option value="">08:00</option>
							      <option value="">09:00</option>
							      <option value="">10:00</option>
							      <option value="">11:00</option>
							      <option value="">12:00</option>
							      <option value="">13:00</option>
							      <option value="">14:00</option>
							      <option value="">15:00</option>
							      <option value="">16:00</option>
							      <option value="">17:00</option>
							      <option value="">18:00</option>
							      <option value="">19:00</option>
							      <option value="">20:00</option>
							      <option value="">21:00</option>
							      <option value="">22:00</option>
							      <option value="">23:00</option>
							      <option value="">24:00</option>
						    </select>
						</div>
						<div style="font-size:12pt;width:200px;float:left;">Platztyp?
						</div>
						<div>
							<select name="typesearch" size="1" style="width:110px;">
						        <option>Tennis</option>
						        <option>Badminton</option>
						        <option>Squash</option>
							</select>
						</div>
					</div>
					<div style="font-size:18px;width:120px;float:left;">
						<button style="width:120px;height:100px;margin-top: 20px;">Suchen</button>
					</div>
			</div>
	</div>
</div>