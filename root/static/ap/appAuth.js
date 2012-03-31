Ext.application({
    name : 'AP',
    appFolder : 'static/ap/app',

    controllers: [
        'Auth'
    ],

    launch: function() {
        Ext.create('Ext.container.Viewport', {
            layout: 'fit',
            items: [{
                xtype: 'box',
                height: 45,
                html: '<div id="header"></div>' +
                      '<div id="header_title">Administrative Panel</div>' +
                      '<div id="header_power"></div>',
                border: false
            },{
                region: 'center',
                xtype: 'authctl'
            }]
        });
    }
});
