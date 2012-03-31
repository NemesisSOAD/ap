Ext.define('AP.controller.Urls', {
    extend: 'Ext.app.Controller',
    
    stores: [ 'urlsStore', 'typesStore'],
    models: [ 'urlsModel', 'typesModel'],
    
    views: [
        'urls.showUrl',
        'urls.addUrls'
    ],
    
    init: function() {
        this.control({
            'urlsctl button[action=add]' : {
                click: this.addUrl
            }, 'urlsctl button[action=remove]' : {
                click: this.removeUrl
            }, 'urlsctl button[action=edit]' : {
                click: this.editUrl
            }, 'addurl button[action=create]' : {
                click: this.createUrl
            }    
        })
    },
    
    addUrl: function() {
        view = Ext.widget('addurl').show();
    },
    
    removeUrl: function() {
        Ext.Msg.show({
            title: 'Remove Acl List',
            msg: 'Are you sure you want to delete ' + urlRec.url + '?',
            buttons: Ext.Msg.YESNO,
            icon: Ext.Msg.WARNING,
            fn: function(btn) {
                if (btn == 'yes' ) {
                    Ext.Ajax.request({
                        url: '/admin/del_url',
                        actionMethod: 'POST',
                        params: { 'url_id' : urlRec.id },
                        success: function(form, action) {
                            Ext.getStore('urlsStore').load({params: { 'acl_id' : aclRec.id }});
                        },
                        failure: function(form,action) {
                        }
                    });
                }
            }
        });
    },
    
    createUrl: function(button) {
        var win = button.up('window');
        var form = win.down('form');
        if (form.getForm().isValid()) {
            form.submit({
                url: 'admin/add_url',
                actionMethod: 'POST',
                success: function(form,action) {
                    win.close();
                    Ext.getStore('urlsStore').load({params: { 'acl_id' : aclRec.id }});
                },
                falilure: function(form,action) {
                    
                }
            })
        }
    }
    
});