Ext.define('AP.store.urlsStore', {
    extend : 'Ext.data.Store',

    model: 'AP.model.urlsModel',
    sortes: [ 'url', 'type_name' ],
    groupField: 'type_name',

    proxy: {
        type: 'ajax',
        actionMethods: 'POST',
        url: 'admin/get_urls',
        reader: {
            type: 'json',
            id: 'id',
            root: 'data'
        }
    },

    autoLoad: false
});
