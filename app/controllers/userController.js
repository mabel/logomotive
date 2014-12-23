var validator  = require('validator')
var locomotive = require('locomotive')
  , Controller = locomotive.Controller;

var userController = new Controller();

//userController.before('*', function(next){
//	validator(this.req, this.res, next)
//})

userController.about = function() {
	var req = this.req
	var res = this.res
	var flux = this.__app.flux
	var store = flux.store('Users')
	var uuid = req.session.uuid
	var inst = store.getInstance(uuid)
	if(!uuid || !inst){
		res.redirect('/nologin')
		return
	}
	delete inst.timestamp
	delete inst.inuse
	delete inst.changed
	delete inst.password
	res.json(inst)
}

module.exports = userController;

