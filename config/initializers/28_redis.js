var _ = require("underscore")
var Promise = require('es6-promise').Promise;
var redis = require("redis").createClient()
var Controller = require("locomotive").Controller
var config = require('../')

module.exports = function() {

    var app = this
	this.redis = redis
   
	Controller.prototype.set = function(key, subkey, value){
		return new Promise(function(yo, no){
            if(!value && subkey){value = subkey; subkey = null}
			if(subkey){
                redis.hset(key, subkey, value, function(err){
				    yo()
			    })
                return
            }
			if(_.isArray(value)){
                redis.sadd(key, value, function(err){
				    yo()
			    })
                return
            }
			if(_.isObject(value)){
                redis.hmset(key, value, function(err){
				    yo()
			    })
                return
            }
            redis.set(key, value, function(err){
                yo()
            })
		})
    }

	Controller.prototype.keys = function(patt){
		return new Promise(function(yo, no){
			redis.keys(patt, function(err, arr){
                if(err && config.debug) console.log(err)
				yo(arr)
			})
		})
	}

	Controller.prototype.mobj = function(keys){
		return new Promise(function(yo, no){
            var arr = []
            if(!keys.length){yo(arr); return}
            keys.forEach(function(el){
                redis.hgetall(el, function(err, obj){
                    obj.id = el.match(/[^\:]+$/)[0]
                    arr.push(obj)
                    if(arr.length == keys.length){yo(arr)}
                })
            })
		})
	}


/*

	Controller.prototype.multyObj = function(patt){
		var objs = {}
		var ctrl = this
		return new Promise(function(yo, no){		
			ctrl.keys(patt)
				.then(function(arr){
					_.each(arr, function(key){
						ctrl.get(key)
							.then(function(val){
								objs[key] = val
								if(_.size(objs) == _.size(arr)) yo(objs) 
							})
					})
			}).catch(no)
		})
	}

	Controller.prototype.checkNoKey = function(key){
		return new Promise(function(yo, no){
			redis.exists(key, function(err, yes){
				if(yes){ no('KEY_ALREADY_EXISTS'); return }
				yo(key)
			})
		})
	}

	Controller.prototype.checkSimpleKey = function(key, val){
		return new Promise(function(yo, no){
			redis.get(key, function(err, dat){
				if(!dat || (val && val != dat)) {no('WRONG_VALUE_AT_KEY'); return}
				yo(key, val)
			})
		})
	}

	Controller.prototype.setWithExpire = function(key, val, expir){
		return new Promise(function(yo, no){
			redis.set(key, val, function(err){
				if(expir) redis.expire(key, expir)
				yo(key, val)
			})
		})
	}

	Controller.prototype.get = function(key, subkey){
		return new Promise(function(yo, no){
			if(subkey){
				redis.hget(key, subkey, function(err, obj){
					yo(obj)
				})
				return
			}
			redis.type(key, function(err, type){
				switch(type){
					case 'string': 
						redis.get(key, function(err, obj){
							yo(obj)
						})
						break
					case 'list': 
						redis.lmembers(key, function(err, obj){
							yo(obj)
						})
						break
					case 'set': 
						redis.smembers(key, function(err, obj){
							yo(obj)
						})
						break
					case 'zset': 
						redis.zsmembers(key, function(err, obj){
							yo(obj)
						})
						break
					case 'hash': 
						redis.hgetall(key, function(err, obj){
							yo(obj)
						})
						break
					default: 
						no('NO_SUCH_KEY'); 
						return
				}
			})
		})
	}
*/
}
