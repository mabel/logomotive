var Controller = require("locomotive").Controller
var multiparty = require('multiparty')

var _ = require('underscore')
var exec = require('child_process').exec;

module.exports = function() {
    var app = this

    Controller.prototype.getUploadDir = function(){return __dirname + '/../../../public/upload/'}
	Controller.prototype.getImagesDir = function(){return __dirname + '/../../../public/img/'}

    Controller.prototype.upload = function(dir){
        if(!dir) dir = this.getUploadDir()
        if(!/\/$/.test(dir)) dir += '/'
        var req = this.req;
        var res = this.res;
        new multiparty.Form({saveFiles: true}).parse(req, function(err, fields, files){
            var val = files[0]
            var ext = val.path.match(/\.[a-z]+$/)[0]
            var newPath = dir + val.fieldName + ext
            console.log(newPath)
            exec(['mv', val.path, newPath].join(' '), function(error, stdout, stderr) {
                if (error !== null) {
                    console.log('exec error: ' + error);
                }
            });
        })
        res.json('')
    }
}
