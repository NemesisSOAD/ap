Ext.define('AP.store.statsStore', {
    extend : 'Ext.data.Store',

    model: 'AP.model.statsModel',
    sortes: [ 'url', 'mib' ],

    proxy: {
        type: 'ajax',
        actionMethods: 'POST',
        url: 'admin/get_stats',
        reader: {
            type: 'json',
            root: 'data'
        }
    },

    autoLoad: false
});
