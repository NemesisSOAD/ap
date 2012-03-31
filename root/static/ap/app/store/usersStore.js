Ext.define('AP.store.usersStore', {
    extend : 'Ext.data.Store',

    model: 'AP.model.usersModel',

    proxy: {
        type: 'ajax',
        actionMethods: 'POST',
        url: 'admin/get_users',
        reader: {
            type: 'json',
            id: 'id',
            root: 'data'
        }
    },

    autoLoad: false
});
