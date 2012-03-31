Ext.define('AP.view.acls.showAcl', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.aclsctl',

    requires: [
        'Ext.toolbar.Toolbar'
    ],
    
    border: true,
    title: 'Acls',
    
    autoScroll: true,
    margins: '3 3 3 3',
    
    listeners: {
        itemclick: function(view, record, item, e) {
            aclRec = record.data;
            Ext.getStore('urlsStore').load({params: { 'acl_id' : aclRec.id }});
        }
    },
    
    initComponent: function() {
        Ext.apply(this, {
            store: 'aclsStore',
            viewConfig: {
                singleSelection: true
            },
            
            columns: [{
                text: 'Acl name',
                dataIndex: 'acl_name',
                width: 60
            },{
                text: 'Description',
                dataIndex: 'acl_desc',
                width: 115
            },{
                text: 'Redirect',
                dataIndex: 'acl_redir',
                flex: 1
            },{
                text: 'Create',
                dataIndex: 'cdate',
                width: 120
            },{
                text: 'Modified',
                dataIndex: 'mdate',
                width: 120
            },{
                text: 'Active',
                dataIndex: 'active',
                width: 45
            }],
            
            dockedItems: [{
                dock: 'top',
                xtype: 'toolbar',
                border: false,
                items: [{
                    iconCls: 'add',
                    action: 'add',
                    tooltip: 'Add acl'
                },{
                    iconCls: 'remove',
                    action: 'remove',
                    tooltip: 'Remove acl'
                },{
                    iconCls: 'edit',
                    action: 'edit',
                    tooltip: 'Edit acl'
                }]
            }]
        });
        
        this.callParent(arguments);
    }
});