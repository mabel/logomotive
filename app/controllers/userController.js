var locomotive = require('locomotive')
  , Controller = locomotive.Controller;

var userController = new Controller();

userController.about = function() {
	var req = this.req
	var res = this.res
	var flux = this.__app.flux
	var store = flux.store('Users')
	var uuid = req.session.uuid
	var inst = store.getInstance(uuid)
	console.log(inst)
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

