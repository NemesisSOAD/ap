Ext.define('AP.controller.Users', {
    extend: 'Ext.app.Controller',
    
    stores: [ 'usersStore' ],
    models: [ 'usersModel' ],
    
    views: [
        'users.showUsers',
        'users.addUsers',
        'users.editUsers'
    ],
    
    init: function() {
        this.control({
            'userctl button[action=add]' : {
                click: this.addUser
            }, 'userctl button[action=remove]' : {
                click: this.removeUser
            }, 'userctl button[action=edit]' : {
                click: this.editUser
            }, 'adduser button[action=create]' : {
                click: this.createUser
            }, 'upduser button[action=update]' : {
                click: this.updateUser
            }
        });
    },
    
    addUser: function() {
        view = Ext.widget('adduser').show();
    },
    
    editUser:function() {
        view = Ext.widget('upduser').show();
    },
    
    createUser: function(button) {
        var win = button.up('window');
        var form = win.down('form');
        if (form.getForm().isValid()) {
            form.submit({
                url: 'admin/add_user',
                actionMethod: 'POST',
                success: function(form,action) {
                    win.close();
                    Ext.getStore('usersStore').load({params: { 'group_id' : groupRec.id }});
                },
                falilure: function(form,action) {
                    
                }
            })
        }
    },
    
    removeUser: function() {
        Ext.Msg.show({
            title: 'Remove User',
            msg: 'Are you sure you want to delete user ' + userRec.user_name + '?',
            buttons: Ext.Msg.YESNO,
            icon: Ext.Msg.WARNING,
            fn: function(btn) {
                if (btn == 'yes' ) {
                    Ext.Ajax.request({
                        url: '/admin/del_user',
                        actionMethod: 'POST',
                        params: { 'user_id' : userRec.id },
                        success: function(form, action) {
                            Ext.getStore('usersStore').load({params: { 'group_id' : groupRec.id }});
                        },
                        failure: function(form,action) {
                        }
                    });
                }
            }
        });
    },
    
    updateUser: function(button) {
        var win = button.up('window');
        var form = win.down('form');
        if (form.getForm().isValid()) {
            form.submit({
                url: 'admin/upd_user',
                actionMethod: 'POST',
                success: function(form,action) {
                    win.close();
                    Ext.getStore('usersStore').load({params: { 'group_id' : groupRec.id }});
                },
                falilure: function(form,action) {
                    
                }
            })
        }
    }
});