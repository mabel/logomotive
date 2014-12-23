var fs   = require('fs')
var gulp = require('gulp')
var xslt = require('node_xslt')

gulp.task('default', function(){
	var stylesheet = xslt.readXsltFile('client.xsl')
	var document = xslt.readXmlFile('rpc.xml');
	var transformedString = xslt.transform(stylesheet, document, []);
	fs.writeFile('../public/js/09_validate.js', transformedString)
	stylesheet = xslt.readXsltFile('server.xsl')
	transformedString = xslt.transform(stylesheet, document, []);
	fs.writeFile('../node_modules/validator/index.js', transformedString)
})
