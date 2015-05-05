var Controller = require("locomotive").Controller
var winston = require('winston');
var config  = require("../")
var errCodes = require("../errors")
var logDir = __dirname + '/../../../../../_log'

var logger = new (winston.Logger)({
	transports: [
		new (winston.transports.Console)(),
		new (winston.transports.DailyRotateFile)({ filename: logDir + config.prefix + '.log' })
	]
});

module.exports = function() {

	this.errCodes = errCodes
	this.logger = logger

	Controller.prototype.getLogDir = function(err){ 
        return logDir
    }

	Controller.prototype.fail = function(err){ 
		var userAgent = this.req.headers['user-agent']
		var ip = this.req.headers['x-real-ip']
		var errCode = 999
		if(!err) err = 'Unknown error'
		if(err && /^[A-Z_]+$/.test(err) && errCodes[err]){
		   	errCode = errCodes[err].code
		   	err = errCodes[err].message
		}
		logger.warn('Error = ' + err + ', IP = %s, UserAgent = %s, path = %s', ip, userAgent, this.req.path)
		this.res.json(errCode); 
	}
}
