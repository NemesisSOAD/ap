Ext.define('AP.view.users.showUsers', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.userctl',
    
    requires: [
        'Ext.toolbar.Toolbar'
    ],
    
    border: true,
    title: 'Users',
    
    autoScroll: true,
    margins: '3 3 3 0',
    
    listeners: {
        itemclick: function(view, record, item, e) {
            userRec = record.data;
        }
    },
    
    initComponent: function() {
        Ext.apply(this, {
            store: 'usersStore',
            
            viewConfig: {
                singleSelection: true
            },
            
            columns: [{
                text: 'Login',
                sortable: true,
                dataIndex: 'user_name',
                width: 100
            },{
                text: 'First/Last name',
                sortable: false,
                dataIndex: 'fio',
                flex: 1 
            },{
                text: 'Created',
                sortable: false,
                dataIndex: 'cdate',
                width: 120
            },{
                text: 'Modified',
                sortable: false,
                dataIndex: 'mdate',
                width: 120
            },{
                text: 'Fraffic Limit',
                sortable: false,
                dataIndex: 'tr_limit',
                format: '0.000',
                width: 75
            },{
                text: 'Active',
                sortable: false,
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
                    tooltip: 'Add user'
                },{
                    iconCls: 'remove',
                    action: 'remove',
                    tooltip: 'Remove user'
                },{
                    iconCls: 'edit',
                    action: 'edit',
                    tooltip: 'Edit user'
                }]
            }]
        });
        
        this.callParent(arguments);
    }
});