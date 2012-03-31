Ext.define('AP.view.logs.showStats', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.statsctl',

    requires: [
        'Ext.toolbar.Toolbar',
        'Ext.grid.*'
    ],
    
    border: true,
    title: 'Urls',
    
    autoScroll: true,
    margins: '3 3 3 0',
    
    /* listeners: {
        itemclick: function(view, record, item, e) {
            urlRec = record.data;
        }
    },*/
    
    initComponent: function() {
        
        Ext.apply(this, {
            store: 'statsStore',
            viewConfig: {
                singleSelection: true
            },
            
            columns: [{
                text: 'Traffic MiB',
                dataIndex: 'mib',
                width: 70 
            },{
                text: 'URL',
                dataIndex: 'url',
                flex: 1 
            }],
            
            dockedItems: [{
                dock: 'top',
                xtype: 'toolbar',
                border: false,
                items: [{
                    iconCls: 'pdf',
                    action: 'exportpdf',
                    tooltip: 'Export To PDF'
                }]
            }]
        });
        
        this.callParent(arguments);
    }
});