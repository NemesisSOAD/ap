Ext.define('AP.store.aclsStore', {
    extend : 'Ext.data.Store',

    model: 'AP.model.aclsModel',

    proxy: {
        type: 'ajax',
        actionMethods: 'POST',
        url: 'admin/get_acls',
        reader: {
            type: 'json',
            id: 'id',
            root: 'data'
        }
    },

    autoLoad: true
});
