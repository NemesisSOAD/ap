Ext.define('AP.view.acls.addAcls',{
    extend: 'Ext.window.Window',
    alias: 'widget.addacl',
    
    requires: [
        'Ext.form.Panel'
    ],
    
    autoShow: false,
    width: 400,
    height: 150,
    layout: 'fit',
    title: 'Add ACL List',
    
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
                name: 'acl_name',
                fieldLabel: 'Acl name',
                anchor: '100%',
                allowBlank: false
            },{
                xtype: 'textfield',
                name: 'acl_desc',
                fieldLabel: 'Description',
                anchor: '100%',
                allowBlank: false
            },{
                xtype: 'textfield',
                name: 'acl_redir',
                fieldLabel: 'Redirect url',
                anchor: '100%',
                allowBlank: false
            }]
        }],
        
        this.callParent(arguments)
    }
});