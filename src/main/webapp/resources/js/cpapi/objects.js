function CourtCategory(id, cpInstanceId, orderNr, name) {
	this.id = id;
	this.cpInstanceId = cpInstanceId;
	this.orderNr = orderNr;
	this.name = name;
}

function Rate(id, courtCategoryId, name, active, price, orderNr, dateFrom, dateTo, timeFrom, timeTo, weekDays, userGroupIds) {
	this.id = id;
	this.courtCategoryId = courtCategoryId;
	this.name = name;
	this.active = active;
	this.price = price;
	this.orderNr = orderNr;
	this.dateFrom = dateFrom;
	this.dateTo = dateTo;
	this.timeFrom = timeFrom;
	this.timeTo = timeTo;
	this.weekDays = weekDays;
	this.userGroupIds = userGroupIds;
}

Rate.prototype.foo = function() {
	
};