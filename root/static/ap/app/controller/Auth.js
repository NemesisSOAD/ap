Ext.define('AP.controller.Auth', {
    extend: 'Ext.app.Controller',
    
    views: [
        'auth.Login'
    ],
    
    init: function() {
        this.control({
            'authctl button[action=auth]': {
                click: this.userAuth
            }
        });
    },
    
    userAuth: function(button) {
        var win = button.up('window');
        var form = win.down('form');
        if (form.getForm().isValid()) {
            form.submit({
                url: '/admin/user_login',
                actionMethod: 'POST',
                success: function(form, action) {
                    window.location = '/admin';
                },
                failure: function(form,action) {
                    window.location = '/admin';
                }
            });
        }
    }
})