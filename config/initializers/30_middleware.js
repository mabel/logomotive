var express = require('express')
  , poweredBy = require('connect-powered-by')
  , methodOverride = require('method-override')
  , bodyParser = require('body-parser')
  //, multer = require('multer')

module.exports = function() {
	if ('development' == this.env) {
		this.use(express.logger());
	}
	this.use(poweredBy('Locomotive'));
	this.use(express.favicon());
	this.use(express.static(__dirname + '/../../public'));
	this.use(bodyParser.json());
	this.use(bodyParser.urlencoded({extended: true}));
	this.use(express.session({ secret: 'nash parovoz vpered leti' }));
	this.use(methodOverride());
	this.use(this.router);
	this.use(express.errorHandler());
	this.use(this.passport.initialize());
	this.use(this.passport.session());
    /*
    this.use(multer({ dest: __dirname + '/../../public/img',
        rename: function (fieldname, filename) {
                 return filename+Date.now();
        },
        onFileUploadStart: function (file) {
              console.log(file.originalname + ' is starting ...')
        },
        onFileUploadComplete: function (file) {
              console.log(file.fieldname + ' uploaded to  ' + file.path)
              done=true;
        },
        onError: function(err, next){
            console.log(err)
            next()
        }
    }));
    */
    //this.post('/admin/upload/goods',function(req,res){
    //    if(done==true){
    //        console.log(req.files);
    //        res.end("File uploaded.");
    //    }
    //});
}
