Ext.define('AP.view.auth.Login', {
    extend: 'Ext.window.Window',
    alias: 'widget.authctl',
    
    autoShow: true,
    width: 400,
    height: 125,
    layout: 'fit',
    title: 'Защищенная Зона',

    requires: ['Ext.form.Panel'],
    
    initComponent: function() {
        this.buttons= [{
            text: 'Войти',
            action: 'auth'
        }],
        
        this.items = [{
            xtype: 'form',
            frame: true,
            border: false,
            plain: false,
            items: [{
                xtype: 'textfield',
                name: 'user_login',
                anchor: '100%',
                fieldLabel: 'Имя',
                allowBlank: false
            },{
                xtype: 'textfield',
                name: 'user_pass',
                anchor: '100%',
                fieldLabel: 'Пароль',
                inputType: 'password',
                allowBlank: false
            }]
        }]
        
        this.callParent(arguments);
    }
});