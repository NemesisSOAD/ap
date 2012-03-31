Ext.define('AP.model.grantsModel', {
    extend: 'Ext.data.Model',

    fields: [
        {name: 'id', type: 'integer'},
        {name: 'acl_name', type: 'string'},
        {name: 'acl_desc', type: 'string'},
        {name: 'grant_id', type: 'integer'},
        {name: 'selected', type: 'bool'}]
});
