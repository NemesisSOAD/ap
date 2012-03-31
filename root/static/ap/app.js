Ext.onReady(function() {
    Ext.BLANK_IMAGE_URL = '/static/images/s.gif';
    
    Ext.Loader.setConfig({
        enabled: true
    });
    
    Ext.Loader.setPath('Ext.ux', '/static/ext/examples/ux');
    
    Ext.application({
        name: 'AP',
        appFolder: 'static/ap/app',
        
        controllers: [ 'Acls', 'Urls', 'Groups', 'Users', 'Logs' ],
        
        init: function() {
            Ext.QuickTips.init();
        },
        
        autoCreateViewport: true
    });
});