var _ = require('underscore')
var locomotive = require('locomotive')
  , Controller = locomotive.Controller;

var adminController = new Controller();

adminController.goodsGet = function() {
    var ctrl = this
    var keyPatt = ctrl.getPrefix() + 'gds:*'
    ctrl.keys(keyPatt)
        .then(function(keys){return ctrl.mobj(keys)})
        .then(function(arr){
            arr.forEach(function(el){
                el.prev = 1 
                el.edit = 1 
            })
            ctrl.res.json(arr)
        })
        .catch(function(err){ctrl.fail(err)})
}

adminController.goodsSet = function() {
    var ctrl = this
    var obj = _.clone(ctrl.req.body)
    var id = obj.id
    delete obj.id
    var key = ctrl.getPrefix() + 'gds:' + id
    ctrl.set(key, obj)
    ctrl.res.json('')
}

adminController.goodsDel = function() {
    var ctrl = this
    var id = ctrl.param('id')
    var key = ctrl.getPrefix() + 'gds:' + id
    ctrl.getRedis().del(key)
    ctrl.res.json('')
}

adminController.goodsUpload = function() {
    var ctrl = this
    this.upload(ctrl.getImagesDir() + 'goods')
}

module.exports = adminController;
