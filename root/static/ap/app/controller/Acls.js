Ext.define('AP.controller.Acls', {
    extend: 'Ext.app.Controller',
    
    stores: [ 'aclsStore' ],
    models: [ 'aclsModel' ],
    
    views: [
        'acls.showAcl',
        'acls.addAcls',
        'acls.editAcls'
    ],
    
    init: function() {
        this.control({
            'aclsctl button[action=add]' : {
                click: this.addAcl
            }, 'aclsctl button[action=remove]' : {
                click: this.removeAcl
            }, 'aclsctl button[action=edit]' : {
                click: this.editAcl
            }, 'addacl button[action=create]' : {
                click: this.createAcl
            }, 'updacl button[action=update]' : {
                click: this.updateAcl
            }
        });
    },
    
    addAcl: function() {
        view = Ext.widget('addacl').show();
    },
    
    removeAcl: function() {
        Ext.Msg.show({
            title: 'Remove Acl List',
            msg: 'Are you sure you want to delete ' + aclRec.acl_name + '?',
            buttons: Ext.Msg.YESNO,
            icon: Ext.Msg.WARNING,
            fn: function(btn) {
                if (btn == 'yes' ) {
                    Ext.Ajax.request({
                        url: '/admin/del_acl',
                        actionMethod: 'POST',
                        params: { 'acl_id' : aclRec.id },
                        success: function(form, action) {
                            Ext.getStore('aclsStore').load();
                        },
                        failure: function(form,action) {
                        }
                    });
                }
            }
        });
    },
    
    editAcl: function() {
        view = Ext.widget('updacl').show();
    },
    
    createAcl: function(button) {
        var win = button.up('window');
        var form = win.down('form');
        if (form.getForm().isValid()) {
            form.submit({
                url: 'admin/add_acl',
                actionMethod: 'POST',
                success: function(form,action) {
                    win.close();
                    Ext.getStore('aclsStore').load();
                },
                falilure: function(form,action) {
                    
                }
            })
        }
    },
    
    updateAcl: function(button) {
        var win = button.up('window');
        var form = win.down('form');
        if (form.getForm().isValid()) {
            form.submit({
                url: 'admin/upd_acl',
                actionMethod: 'POST',
                success: function(form,action) {
                    win.close();
                    Ext.getStore('aclsStore').load();
                },
                falilure: function(form,action) {
                    
                }
            })
        }
    }
});