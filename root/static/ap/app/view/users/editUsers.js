Ext.define('AP.view.users.editUsers',{
    extend: 'Ext.window.Window',
    alias: 'widget.upduser',
    
    requires: [
        'Ext.form.Panel',
        'Ext.form.field.ComboBox',
        'Ext.form.field.Checkbox'
    ],
    
    autoShow: false,
    width: 400,
    height: 205,
    layout: 'fit',
    title: 'Edit User',
    
    initComponent: function() {
        this.buttons = [{
            text: 'Update',
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
                name: 'user_name',
                fieldLabel: 'User Name',
                anchor: '100%',
                disabled: true,
                value: userRec.user_name,
                allowBlank: false
            },{
                xtype: 'textfield',
                name: 'fio',
                fieldLabel: 'First/Last Name',
                anchor: '100%',
                value: userRec.fio,
                allowBlank: false
            },{
                xtype: 'textfield',
                name: 'tr_limit',
                fieldLabel: 'Traffic Limit',
                anchor: '100%',
                value: userRec.tr_limit,
                allowBlank: false
            },{
                xtype: 'combobox',
                store: 'groupsStore',
                queryMode: 'local',
                displayField: 'group_name',
                valueField: 'id',
                name: 'group_id',
                fieldLabel: 'User Group',
                emptyText: 'Select User Group....',
                anchor: '100%',
                value: userRec.group_id,
                allowBlank: false
            },{
                xtype: 'checkbox',
                name: 'act',
                fieldLabel: 'Active',
                checked: userRec.active == 0 ? false : true,
                inputValue: '1',
                uncheckedValue: '0'
            },{
                xtype: 'hidden',
                name: 'user_id',
                value: userRec.id
            }]
        }],
        
        this.callParent(arguments)
    }
});