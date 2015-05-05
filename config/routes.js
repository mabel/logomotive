module.exports = function routes() {
    this.match('/admin/goods/upload',  'admin#goodsUpload', {via: 'POST'});
    this.match('/admin/goods/set',     'admin#goodsSet',    {via: 'POST'});
    this.match('/admin/goods/get',     'admin#goodsGet');
    this.match('/admin/goods/del/:id', 'admin#goodsDel');
}
