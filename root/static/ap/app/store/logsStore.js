Ext.define('AP.store.logsStore', {
    extend : 'Ext.data.TreeStore',

    model: 'AP.model.logsModel',

    root: {
        expanded: false,
        text: 'Statistics',
        id: '0',
        nodeType: 'async'
    },

    proxy: {
        type: 'ajax',
        actionMethods: 'POST',
        url: 'admin/get_tree',
        reader: {
            type: 'json',
            id: 'id',
            root: 'data'
        }
    },

    autoLoad: false
});