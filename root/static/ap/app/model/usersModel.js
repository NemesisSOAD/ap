Ext.define('AP.model.usersModel', {
    extend: 'Ext.data.Model',

    fields: [
        {name: 'id', type: 'indeger'},
        {name: 'group_id', type: 'indeger'},
        {name: 'user_name', type: 'string'},
        {name: 'fio', type: 'string'},
        {name: 'cdate'},
        {name: 'mdate'},
        {name: 'tr_limit', type: 'float'},
        {name: 'active', type: 'indeger'}
    ]
});
