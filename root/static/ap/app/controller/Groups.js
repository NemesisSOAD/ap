Ext.define('AP.controller.Groups', {
    extend: 'Ext.app.Controller',
    
    stores: [ 'groupsStore', 'grantsStore' ],
    models: [ 'groupsModel', 'grantsModel' ],
    
    
    views: [
        'groups.showGroups',
        'groups.showGrants',
        'groups.addGroup',
        'groups.editGroup',
    ],
    
    init: function() {
        this.control({
            'groupctl button[action=add]' : {
                click: this.addGroup
            }, 'groupctl button[action=remove]' : {
                click: this.removeGroup
            }, 'groupctl button[action=edit]' : {
                click: this.editGroup
            }, 'addgroup button[action=create]' : {
                click: this.createGroup
            }, 'updgroup button[action=update]' : {
                click: this.updateGroup
            }, 'grantctl checkcolumn': {
                checkchange: this.checkboxChanged
            }
        });
    },
    
    // { "success" : "true", "data" : [
    //    {"id" : "5", "acl_name" : "ads", "acl_desc" : "ADS List Access", "grant_id" : "0", "selected" : "0"},
    //    {"id" : "3", "acl_name" : "porno", "acl_desc" : "Porno List Access", "grant_id" : "0", "selected" : "0"},
    //    {"id" : "2", "acl_name" : "social", "acl_desc" : "Social List Access", "grant_id" : "3", "selected" : "1"},
    //    {"id" : "1", "acl_name" : "white", "acl_desc" : "White List Access", "grant_id" : "0", "selected" : "0"}
    //  ]}
    
    checkboxChanged: function(column,rowIndex,checked) {
        var acl_id = Ext.getStore('grantsStore').getAt(rowIndex).raw.id;
        var grant_id = Ext.getStore('grantsStore').getAt(rowIndex).raw.grant_id;
        if (grant_id == 0) {
            Ext.Ajax.request({
                url: '/admin/add_grant',
                actionMethod: 'POST',
                params: { 'group_id' : groupRec.id, 'acl_id' : acl_id },
                success: function(form, action) {
                    Ext.getStore('grantsStore').load({params: { 'group_id' : groupRec.id }});
                },
                failure: function(form,action) {
                }
            });
        } else {
            Ext.Ajax.request({
                url: '/admin/del_grant',
                actionMethod: 'POST',
                params: {'grant_id' : grant_id },
                success: function(form, action) {
                    Ext.getStore('grantsStore').load({params: { 'group_id' : groupRec.id }});
                },
                failure: function(form,action) {
                }
            });
        }
    },
    
    addGroup: function() {
        view = Ext.widget('addgroup').show();
    },
    
    editGroup:function() {
        view = Ext.widget('updgroup').show();
    },
    
    createGroup: function(button) {
        var win = button.up('window');
        var form = win.down('form');
        if (form.getForm().isValid()) {
            form.submit({
                url: 'admin/add_group',
                actionMethod: 'POST',
                success: function(form,action) {
                    win.close();
                    Ext.getStore('groupsStore').load();
                },
                falilure: function(form,action) {
                    
                }
            })
        }
    },
    
    removeGroup: function() {
        Ext.Msg.show({
            title: 'Remove Group',
            msg: 'Are you sure you want to delete group ' + groupRec.group_name + '?',
            buttons: Ext.Msg.YESNO,
            icon: Ext.Msg.WARNING,
            fn: function(btn) {
                if (btn == 'yes' ) {
                    Ext.Ajax.request({
                        url: '/admin/del_group',
                        actionMethod: 'POST',
                        params: { 'group_id' : groupRec.id },
                        success: function(form, action) {
                            Ext.getStore('groupsStore').load();
                        },
                        failure: function(form,action) {
                        }
                    });
                }
            }
        });
    },
    
    updateGroup: function(button) {
        var win = button.up('window');
        var form = win.down('form');
        if (form.getForm().isValid()) {
            form.submit({
                url: 'admin/upd_group',
                actionMethod: 'POST',
                success: function(form,action) {
                    win.close();
                    Ext.getStore('groupsStore').load();
                },
                falilure: function(form,action) {
                    
                }
            })
        }
    }
    
});