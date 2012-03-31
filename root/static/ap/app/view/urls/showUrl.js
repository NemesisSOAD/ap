Ext.define('AP.view.urls.showUrl', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.urlsctl',

    requires: [
        'Ext.toolbar.Toolbar',
        'Ext.grid.*'
    ],
    
    border: true,
    title: 'Urls',
    
    autoScroll: true,
    margins: '3 3 3 0',
    
    listeners: {
        itemclick: function(view, record, item, e) {
            urlRec = record.data;
        }
    },
    
    initComponent: function() {
        var groupingFeature = Ext.create('Ext.grid.feature.Grouping', {
            groupHeaderTpl: 'Type: {name} ({rows.length} Record{[values.rows.length > 1 ? "s" : ""]})'
        });
        
        Ext.apply(this, {
            store: 'urlsStore',
            features: [groupingFeature],
            viewConfig: {
                singleSelection: true
            },
            
            columns: [{
                text: 'IP/Url/Domain/Expression',
                dataIndex: 'url',
                flex: 1
            },{
                text: 'URL Type',
                dataIndex: 'type_name',
                width: 70 
            }],
            
            dockedItems: [{
                dock: 'top',
                xtype: 'toolbar',
                border: false,
                items: [{
                    iconCls: 'add',
                    action: 'add',
                    tooltip: 'Add IP/Url/Domain/Expression'
                },{
                    iconCls: 'remove',
                    action: 'remove',
                    tooltip: 'Remove IP/Url/Domain/Expression'
                }]
            }]
        });
        
        this.callParent(arguments);
    }
});