var locomotive = require('locomotive')
  , Controller = locomotive.Controller;

var authController = new Controller();

authController.before('login', function(next){
	var validate = this.getValidator()
	validate(this.req, this.res, next)
})

authController.login = function() {
	var flux = this.__app.flux
	var req = this.req
	var res = this.res
	var username = this.param('username') 
	var password = this.param('password') 
	if(!username || !password){
		res.redirect('/nologon')
		return
	}
	var payload = {username: username, password: password, callback: function(user, uuid){
		if(user){
		   	req.session.uuid = uuid
			flux.dispatcher.dispatch({type: 'load', payload: {id: user, uuid: uuid, changed: false, timestamp: new Date().getTime(), inuse: true, callback: function(data){
				res.redirect('/user')
			}}})
			return
		}
		res.redirect('/nologin')
	}}	
	flux.dispatcher.dispatch({type: 'check', payload: payload})
}

authController.logout = function() {
	this.req.session.uuid = null
	this.render()
}

module.exports = authController;
