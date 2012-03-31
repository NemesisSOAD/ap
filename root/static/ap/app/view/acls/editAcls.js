Ext.define('AP.view.acls.editAcls',{
    extend: 'Ext.window.Window',
    alias: 'widget.updacl',
    
    requires: [
        'Ext.form.Panel',
        'Ext.form.field.Hidden',
        'Ext.form.field.Checkbox'
    ],
    
    autoShow: false,
    width: 400,
    height: 175,
    layout: 'fit',
    title: 'Update ACL List',
    
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
                name: 'acl_name',
                fieldLabel: 'Acl name',
                anchor: '100%',
                value: aclRec.acl_name,
                allowBlank: false
            },{
                xtype: 'textfield',
                name: 'acl_desc',
                fieldLabel: 'Description',
                anchor: '100%',
                value: aclRec.acl_desc,
                allowBlank: false
            },{
                xtype: 'textfield',
                name: 'acl_redir',
                fieldLabel: 'Redirect url',
                anchor: '100%',
                value: aclRec.acl_redir,
                allowBlank: false
            },{
                xtype: 'hidden',
                name: 'acl_id',
                value: aclRec.id
            },{
                xtype: 'checkbox',
                name: 'act',
                fieldLabel: 'Active',
                checked: aclRec.active == 0 ? false : true,
                inputValue: '1',
                uncheckedValue: '0'
                
            }]
        }],
        
        this.callParent(arguments)
    }
});