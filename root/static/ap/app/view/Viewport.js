Ext.define('AP.view.Viewport', {
    extend: 'Ext.container.Viewport',
    
    requires: [
        'Ext.tree.*',
        'Ext.data.*',
        'AP.view.tabPanel',
        'Ext.layout.container.Border'
    ],
    
    initComponent: function() {
        Ext.apply(this, {
            layout: 'border',
            items: [{
                xtype: 'box',
                region: 'north',
                height: 45,
                html: '<div id="header"></div>' +
                      '<div id="header_title">Server - Administrative Panel</div>' +
                      '<div id="header_power"></div>',
                border: false
            },{
                xtype: 'mainctl',
                region: 'center'
            }]
        });
        
        this.callParent(arguments);
    }
});
