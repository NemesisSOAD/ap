Ext.define('AP.view.urls.addUrls',{
    extend: 'Ext.window.Window',
    alias: 'widget.addurl',
    
    requires: [
        'Ext.form.Panel',
        'Ext.form.field.ComboBox'
    ],
    
    autoShow: false,
    width: 400,
    height: 125,
    layout: 'fit',
    title: 'Add IP/Url/Domain/Expression',
    
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
                name: 'url',
                fieldLabel: 'URL',
                anchor: '100%',
                allowBlank: false
            },{
                xtype: 'combobox',
                store: 'typesStore',
                queryMode: 'local',
                displayField: 'type_name',
                valueField: 'id',
                name: 'type_id',
                fieldLabel: 'URL Type',
                emptyText: 'Select Url Type....',
                anchor: '100%',
                allowBlank: false
            },{
                xtype: 'hidden',
                name: 'acl_id',
                value: aclRec.id
            }]
        }],
        
        this.callParent(arguments)
    }
});