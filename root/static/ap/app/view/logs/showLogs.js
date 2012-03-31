Ext.define('AP.view.logs.showLogs', {
    extend: 'Ext.tree.Panel',
    alias: 'widget.logsctl',

    requires: [
        'Ext.toolbar.Toolbar'
    ],

    title: 'Statistics',
    collapsible: true,
    animCollapse: true,
    border: true,
    margins: '3 3 3 3',
    rootVisible: true,
    store: 'logsStore',
    autoScroll: true,
    listeners: {
        itemclick: function(view, record, item, index, event) {
            logRec = record.data;
            if (logRec.text.match(/(\d{4})-(\d{2})-(\d{2}).*/g)) {    
                Ext.getStore('statsStore').load({params: { 'date' : logRec.text, 'user_id' : logRec.user_id }});
            }
            
        }
    },

    dockedItems: [{
        dock: 'top',
        xtype: 'toolbar',
        border: false,
        items: [{
            iconCls: 'remove',
            action: 'remove',
            tooltip: 'Remove Logs'
        },{
            iconCls: 'reload',
            action: 'reload',
            tooltip: 'Reload tree'
        }]
    }],

    initComponet: function() {
        this.callParent(arguments);
    }
});
