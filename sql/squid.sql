/*
create sequence "urltype_id_seq" increment 1 start 1;
go

create table "urltype" (
"id"                            smallint not null primary key default nextval('urltype_id_seq')
,"type_name"                    character varying(32) not null
,"active"                       smallint not null default '1' 
,unique("type_name")
,check("active" in ('0','1'))
);
go

comment on column "urltype"."type_name" is 'Наименование сущности проверки [ip|domain|url|expr]';
go

insert into "urltype" ("type_name") values ('ip');
go
insert into "urltype" ("type_name") values ('domain');
go
insert into "urltype" ("type_name") values ('url');
go
insert into "urltype" ("type_name") values ('expr');
go

create sequence "acl_id_seq" increment 1 start 1;
go

create table "acl" (
"id"                            integer not null primary key default nextval('acl_id_seq')
,"acl_name"                     character varying(64) not null
,"acl_desc"                     text
,"acl_redir"                    character varying(255) not null default '/squid/redir.pl'
,"active"                       smallint not null default 1
,unique("acl_name")
,check("active" in ('0','1'))
);
go

comment on column "acl"."acl_name" is 'Наименование ACL';
go
comment on column "acl"."acl_desc" is 'Описание ACL';
go
comment on column "acl"."acl_redir" is 'Используемое перенаправление ACL';
go
comment on column "acl"."active" is 'Включение выключение ACL';
go

create sequence "url_id_seq" increment 1 start 1;
go

create table "url" (
"id"                            integer not null primary key default nextval('url_id_seq')
,"type_id"                      smallint not null references "urltype" ("id") on delete restrict on update cascade
,"acl_id"                       integer not null references "acl" ("id") on delete cascade on update cascade
,"url_name"                     character varying(255) not null
,unique("acl_id","url_name")
);

comment on column "url"."type_id" is 'Привязка к сущьности URL';
go
comment on column "url"."acl_id" is 'Привязка к листу доступа';
go
comment on column "url"."url_name" is 'URL, Domain, World, IP для блокировки';
go

create index "url_typeid_idx" on "url" using btree("type_id");
go
create index "url_aclid_idx" on "url" using btree("acl_id");
go
create index "url_acltypeid_idx" on "url" using btree("type_id","acl_id");
go
*/
