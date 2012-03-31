Ext.define('AP.store.groupsStore', {
    extend : 'Ext.data.Store',

    model: 'AP.model.groupsModel',

    proxy: {
        type: 'ajax',
        actionMethods: 'POST',
        url: 'admin/get_groups',
        reader: {
            type: 'json',
            id: 'id',
            root: 'data'
        }
    },

    autoLoad: false
});
