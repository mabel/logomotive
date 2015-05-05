var Controller = require("locomotive").Controller
var config  = require("../")

module.exports = function() {

  var app = this

  Controller.prototype.getPrefix = function(){return config.prefix + ":"}
  Controller.prototype.getRedis  = function(){return app.redis}

}
