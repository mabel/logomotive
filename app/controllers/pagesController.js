var locomotive = require('locomotive')
  , Controller = locomotive.Controller;

var pagesController = new Controller();

pagesController.main = function() {
	this.res.redirect('/nologin')
}

module.exports = pagesController;
