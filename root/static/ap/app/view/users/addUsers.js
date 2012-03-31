Ext.define('AP.view.users.addUsers',{
    extend: 'Ext.window.Window',
    alias: 'widget.adduser',
    
    requires: [
        'Ext.form.Panel'
    ],
    
    autoShow: false,
    width: 400,
    height: 180,
    layout: 'fit',
    title: 'Add User',
    
    initComponent: function() {
        this.buttons = [{
            text: 'Add',
            iconCls: 'add',
            action: 'create'
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
                allowBlank: false
            },{
                xtype: 'textfield',
                name: 'fio',
                fieldLabel: 'First/Last Name',
                anchor: '100%',
                allowBlank: false
            },{
                xtype: 'textfield',
                name: 'tr_limit',
                fieldLabel: 'Traffic Limit',
                anchor: '100%',
                allowBlank: false
            },{
                xtype: 'hidden',
                name: 'group_id',
                value: groupRec.id
            }]
        }],
        
        this.callParent(arguments)
    }
});