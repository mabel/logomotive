var storageFactory = require('magency').createFactory('cr')
var crypto = require('crypto')
var nodeUuid = require('node-uuid')

storageFactory.addModel('Users', {
	actions: {
		check: 'onCheck'
	},
	onCheck: function(payload){
		var login = payload.username
		var passwd = crypto.createHash('sha256').update(payload.password).digest('hex')
		var key = this.model.prefix + ':' + login
		this.getRedis().hget(key, 'password', function(err, val){
			if(err){
				console.log(err)
				payload.callback(false)
			}
			var uuid = nodeUuid.v4()
			payload.callback(val == passwd ? login : false, uuid)
		})
	}
})

module.exports = function(){
	this.flux = storageFactory.getFlux()
}
