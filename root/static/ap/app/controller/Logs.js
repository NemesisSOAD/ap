Ext.define('AP.controller.Logs', {
    extend: 'Ext.app.Controller',
    
    stores: [ 'logsStore', 'statsStore' ],
    models: [ 'logsModel', 'statsModel' ],
    
    
    views: [
        'logs.showLogs',
        'logs.showStats',
        'logs.genLog'
    ],
    
    init: function() {
        this.control({
            'logsctl button[action=remove]' : {
                click: this.removeLogs
            },'logsctl button[action=reload]' : {
                click: this.reloadLogs
            },'statsctl button[action=exportpdf]' : {
                click: this.genLog
            },'genlogs button[action=genpdf]' : {
                click: this.createPdf
            }
        });
    },
    
    reloadLogs: function() {
        Ext.getStore('logsStore').load();
    },
    
    genLog: function() {
        view = Ext.widget('genlogs').show();
    },
    
    createPdf: function(button) {
        var win = button.up('window');
        var form = win.down('form');
        window.location = '/admin/export_topdf/' + form.getForm().findField('dstart').getRawValue() + '/' + form.getForm().findField('dend').getRawValue() + '/' + logRec.user_id;
        win.close();
    },    
    
    removeLogs: function() {
        Ext.Msg.show({
            title: 'Remove Logs',
            msg: 'Are you sure you want to delete Logs from ' + logRec.text + '?',
            buttons: Ext.Msg.YESNO,
            icon: Ext.Msg.WARNING,
            fn: function(btn) {
                if (btn == 'yes' ) {
                    Ext.Ajax.request({
                        url: '/admin/del_logs',
                        actionMethod: 'POST',
                        params: { 'date_log' : logRec.text },
                        success: function(form, action) {
                            //Ext.getStore('groupsStore').load();
                        },
                        failure: function(form,action) {
                        }
                    });
                }
            }
        });
    }
    
});