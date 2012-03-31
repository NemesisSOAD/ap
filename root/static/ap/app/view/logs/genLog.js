Ext.define('AP.view.logs.genLog',{
    extend: 'Ext.window.Window',
    alias: 'widget.genlogs',
    
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
            text: 'Generate',
            iconCls: 'pdf',
            action: 'genpdf'
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
                xtype: 'datefield',
                name: 'dstart',
                fieldLabel: 'Start Date',
                format: 'Y-m-d',
                emptyText: 'Select Start Date',
                anchor: '100%',
                allowBlank: false
            },{
                xtype: 'datefield',
                name: 'dend',
                format: 'Y-m-d',
                fieldLabel: 'End Date',
                emptyText: 'Select End Date',
                anchor: '100%',
                allowBlank: false
            }]
        }],
        
        this.callParent(arguments)
    }
});