var validator = require('validator')

module.exports = function(){
	Controller.prototype.getCtrlId = function(){
		return this.__id
	}
	Controller.prototype.getValidator = function(){
		return validator
	}
	Controller.prototype.getFlux = function(){
		return this.flux
	}
	Controller.prototype.getModel = function(id){
		return this.flux.store(this.getCtrlId()).getInstance(id)
	}
	Controller.prototype.getStore = function(){
		return this.flux.store(this.getCtrlId())
	}
	Controller.prototype.getId = this.getCtrlId
	Controller.prototype.getControllerId = this.getCtrlId
	Controller.prototype.getInstance = this.getModel
}
