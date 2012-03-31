Ext.define('AP.view.groups.showGrants', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.grantctl',

    requires: [
        'Ext.toolbar.Toolbar',
        'Ext.ux.CheckColumn',
        'Ext.selection.CellModel',
        'Ext.grid.column.Column'
    ],
    
    border: true,
    title: 'Group Grants',
    
    autoScroll: true,
    margins: '3 3 3 0',
    
    listeners: {},
    
    initComponent: function() {
        
        var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 1
        });
        
        Ext.apply(this, {
            store: 'grantsStore',
            selModel: {
                selType: 'cellmodel'
            },
            
            plugins: [cellEditing],
            
            columns: [{
                text: 'Acl name',
                dataIndex: 'acl_name',
                flex: 1
            },{
                text: 'Descrition',
                dataIndex: 'acl_desc',
                flex: 1
            },{
                xtype: 'checkcolumn',
                text: 'Grant',
                dataIndex: 'selected',
                width: 55,
                editor: {
                    xtype: 'checkbox',
                    cls: 'x-grid-checkheader-editor'
                }
            }],
            
            dockedItems: [{
                dock: 'top',
                xtype: 'toolbar',
                border: false,
                items: [{}]
            }]
        });
        
        this.callParent(arguments);
    }
});