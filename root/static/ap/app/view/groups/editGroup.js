Ext.define('AP.view.groups.editGroup',{
    extend: 'Ext.window.Window',
    alias: 'widget.updgroup',
    
    requires: [
        'Ext.form.Panel'
    ],
    
    autoShow: false,
    width: 400,
    height: 170,
    layout: 'fit',
    title: 'Edit Group',
    
    initComponent: function() {
        this.buttons = [{
            text: 'Edit',
            iconCls: 'edit',
            action: 'update'
        },{
            text: 'Cancel',
            scope: this,
            iconCls: 'cancel',
            handler: this.close
        }],
        
        this.items = [{
            xtype: 'form',
            border: true,
            frame: true,
            plain: false,
            items: [{
                xtype: 'textfield',
                name: 'group_name',
                fieldLabel: 'Group name',
                anchor: '100%',
                value: groupRec.group_name,
                allowBlank: false
            },{
                xtype: 'checkbox',
                name: 'policy',
                fieldLabel: 'Policy',
                checked: groupRec.policy == 0 ? false : true,
                inputValue: '1',
                uncheckedValue: '0'
            },{
                xtype: 'checkbox',
                name: 'strict',
                fieldLabel: 'Beheavor',
                checked: groupRec.strict == 0 ? false : true,
                inputValue: '1',
                uncheckedValue: '0'
            },{
                xtype: 'checkbox',
                name: 'act',
                fieldLabel: 'Active',
                checked: groupRec.active == 0 ? false : true,
                inputValue: '1',
                uncheckedValue: '0'
            },{
                xtype: 'hidden',
                name: 'group_id',
                value: groupRec.id
            }]
        }],
        
        this.callParent(arguments)
    }
});