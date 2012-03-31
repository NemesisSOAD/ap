Ext.define('AP.store.typesStore', {
    extend : 'Ext.data.Store',

    model: 'AP.model.typesModel',

    proxy: {
        type: 'ajax',
        actionMethods: 'POST',
        url: 'admin/get_types',
        reader: {
            type: 'json',
            id: 'id',
            root: 'data'
        }
    },

    autoLoad: true
});
