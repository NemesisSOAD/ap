Ext.define('AP.store.grantsStore', {
    extend : 'Ext.data.Store',

    model: 'AP.model.grantsModel',

    proxy: {
        type: 'ajax',
        actionMethods: 'POST',
        url: 'admin/get_grants',
        reader: {
            type: 'json',
            id: 'acl_id',
            root: 'data'
        }
    },

    autoLoad: false
});
