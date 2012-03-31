Ext.define('AP.view.tabPanel', {
    extend: 'Ext.tab.Panel',
    alias: 'widget.mainctl',
    
    activeItem: 0,
    border: true,
    listeners: {
        tabchange: function(tab) {
            if (tab.activeTab.id == 'acls-tab') {
                Ext.getStore('aclsStore').load();
            };
            if (tab.activeTab.id == 'groups-tab') {
                Ext.getStore('groupsStore').load();
            };
        }
    },
    
    initComponent: function() {
        Ext.apply(this,{
            items: [{
                id: 'acls-tab',
                layout: 'border',
                title: 'Acls/Urls',
                items: [{
                    region: 'west',
                    width: 650,
                    layot: 'fit',
                    xtype: 'aclsctl'
                },{
                    region: 'center',
                    layout: 'fit',
                    xtype: 'urlsctl'
                }]
            },{
                id: 'groups-tab',
                layout: 'border',
                title: 'Users/Groups/Grants',
                items: [{
                    region: 'west',
                    width: 600,
                    layot: 'fit',
                    xtype: 'groupctl'
                },{
                    region: 'center',
                    layout: 'fit',
                    xtype: 'grantctl'   
                },{
                    region: 'east',
                    width: 600,
                    layout: 'fit',
                    xtype: 'userctl'
                }]
            },{
                id: 'logs-tab',
                layout: 'border',
                title: 'logs',
                items: [{
                    region: 'west',
                    width: 400,
                    layout: 'fit',
                    xtype: 'logsctl'
                },{
                    region: 'center',
                    layout: 'fit',
                    xtype: 'statsctl'
                }]
            }]
        }),
        this.callParent(arguments);
    }
})
