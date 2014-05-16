function CPAPI() {}

//---------- CourtCategory ----------

CPAPI.getCourtCategories_async = function(cpInstanceId, callbackFunction) {
	$.getJSON('api/getCourtCategories?cpInstanceId=' + cpInstanceId, callbackFunction);
};

CPAPI.getCourtCategories_sync = function(cpInstanceId) {
	var cc = null;
	
	$.ajax({
		type: "GET",
		url: "api/getCourtCategories?cpInstanceId=" + cpInstanceId,
		contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    async: false,
	    success: function(data) {
	    	cc = data;
	    },
	    failure: function(errMsg) {
	        alert(errMsg);
	    }
	});
	
	return cc;
};

//---------- Rate ----------

CPAPI.getRates_async = function(courtCategoryId, callbackFunction) {
	$.getJSON('api/getRates?courtCategoryId=' + courtCategoryId, callbackFunction);
};

CPAPI.getRates_sync = function(courtCategoryId) {
	var r = null;
	
	$.ajax({
		type: "GET",
		url: "api/getRates?courtCategoryId=" + courtCategoryId,
		contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    async: false,
	    success: function(data) {
	    	r = data;
	    },
	    failure: function(errMsg) {
	        alert(errMsg);
	    }
	});
	
	return r;
};

CPAPI.saveRate_sync = function(rate) {
	var r = null;
	
	$.ajax({
		type: "POST",
		url: "api/saveRate",
		data: JSON.stringify(rate),
		contentType: "application/json; charset=utf-8",
	    dataType: "json",
	    async: false,
	    success: function(data) {
	    	r = data;
	    },
	    failure: function(errMsg) {
	        alert(errMsg);
	    }
	});
	
	return r;
};

CPAPI.deleteRate_sync = function (id) {
	$.ajax({
		type: "POST",
		url: "api/deleteRate?id=" + id,
	    async: false,
	    success: function(data) { },
	    failure: function(errMsg) {
	        alert(errMsg);
	    }
	});
};
