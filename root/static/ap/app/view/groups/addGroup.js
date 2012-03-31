Ext.define('AP.view.groups.addGroup',{
    extend: 'Ext.window.Window',
    alias: 'widget.addgroup',
    
    requires: [
        'Ext.form.Panel'
    ],
    
    autoShow: false,
    width: 400,
    height: 150,
    layout: 'fit',
    title: 'Add Group',
    
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
                name: 'group_name',
                fieldLabel: 'Group name',
                anchor: '100%',
                allowBlank: false
            },{
                xtype: 'checkbox',
                name: 'policy',
                fieldLabel: 'Policy',
                checked: true,
                inputValue: '1',
                uncheckedValue: '0'
            },{
                xtype: 'checkbox',
                name: 'strict',
                fieldLabel: 'Beheavor',
                checked: false,
                inputValue: '1',
                uncheckedValue: '0'
            }]
        }],
        
        this.callParent(arguments)
    }
});