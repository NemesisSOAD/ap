Ext.define('AP.view.groups.showGroups', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.groupctl',

    requires: [
        'Ext.toolbar.Toolbar'
    ],
    
    border: true,
    title: 'Acls',
    
    autoScroll: true,
    margins: '3 3 3 3',
    
    listeners: {
        itemclick: function(view, record, item, e) {
            groupRec = record.data;
            Ext.getStore('grantsStore').load({params: { 'group_id' : groupRec.id }});
            Ext.getStore('usersStore').load({params: { 'group_id' : groupRec.id }});
        }
    },
    
    initComponent: function() {
        Ext.apply(this, {
            store: 'groupsStore',
            viewConfig: {
                singleSelection: true
            },
            
            columns: [{
                text: 'Group name',
                dataIndex: 'group_name',
                flex: 1
            },{
                text: 'Policy',
                dataIndex: 'policy',
                width: 90
            },{
                text: 'Beheavor',
                dataIndex: 'strict',
                width: 90
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
                    tooltip: 'Add Group'
                },{
                    iconCls: 'remove',
                    action: 'remove',
                    tooltip: 'Remove Group'
                },{
                    iconCls: 'edit',
                    action: 'edit',
                    tooltip: 'Edit Group'
                }]
            }]
        });
        
        this.callParent(arguments);
    }
});