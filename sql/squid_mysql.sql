/*
create table `roles` (
`id`                    integer primary key not null auto_increment
,`role_name`            varchar(128) not null
,`role_desc`            varchar(255) not null
,unique(`role_name`)
) ENGINE=INNODB;
go

create table `users` (
`id`                    integer not null primary key auto_increment
,`role_id`              integer not null
,`login`                varchar(32) not null
,`passwd`               varchar(128) not null
,`cdate`                datetime not null
,`mdate`                datetime not null
,`active`               enum('0','1') not null default '1'
,unique(`login`)
,foreign key (`role_id`) references `roles` (`id`)
) ENGINE=INNODB;
go

insert into `roles` (`role_name`,`role_desc`) values ('Admin','Main System Administrator');
go

create table `acls` (
`id`                    integer not null primary key auto_increment
,`acl_name`             varchar(32) not null
,`acl_desc`             varchar(255) not null
,`acl_redir`            varchar(255) not null
,`cdate`                datetime not null
,`mdate`                datetime not null
,`active`               enum('0','1') not null default '1'
,unique(`acl_name`)
) ENGINE=INNODB;
go

insert into `acls` (`acl_name`,`acl_desc`,`acl_redir`,`cdate`,`mdate`) values ('white','White List Access','ok',now(),now());
go
insert into `acls` (`acl_name`,`acl_desc`,`acl_redir`,`cdate`,`mdate`) values ('social','Social List Access','http://deny.iss-atom.int/social',now(),now());
go

create table `types` (
`id`                    smallint not null primary key auto_increment
,`type_name`            varchar(32) not null
) ENGINE=INNODB;
go

insert into `types` (`type_name`) values ('ip');
go
insert into `types` (`type_name`) values ('domain');
go
insert into `types` (`type_name`) values ('url');
go
insert into `types` (`type_name`) values ('expression');
go

create table `urls` (
`id`                    integer not null primary key auto_increment
,`acl_id`               integer not null 
,`url`                  varchar(255) not null
,`type`                 smallint not null 
,unique(`acl_id`,`url``type`)
,key(`acl_id`,`type`)
,foreign key (`acl_id`) references `acls` (`id`)
,foreign key (`type`) references `types` (`id`)
) ENGINE=INNODB;
go

create table `groups` (
`id`                    integer not null primary key auto_increment
,`group_name`           varchar(128) not null
,`policy`               enum('0','1') not null default '1'
,`strict`               enum('0','1') not null default '0'
,`cdate`                datetime not null
,`mdate`                datetime not null
,`active`               enum('0','1') not null default '1'
,unique(`group_name`)
) ENGINE=INNODB;
go

create table `clients` (
`id`                    integer not null primary key auto_increment
,`group_id`             integer not null 
,`user_name`            varchar(128) not null
,`fio`                  varchar(255)
,`cdate`                datetime not null
,`mdate`                datetime not null
,`active`               enum('0','1') not null default '1'
,unique(`user_name`)
,foreign key (`group_id`) references `groups` (`id`) on delete restrict
) ENGINE=INNODB;
go

create table `group_acls` (
`id`                    integer not null primary key auto_increment
,`group_id`             integer not null
,`acl_id`               integer not null
,unique(`group_id`,`acl_id`)
,foreign key (`group_id`) references `groups` (`id`) on delete cascade
,foreign key (`acl_id`) references `acls` (`id`) on delete cascade
) ENGINE=INNODB;
go

create table `logs` (
`date`                  date default null
,`time`                 time default null
,`elapsed`              decimal(10,0) default null
,`code`                 tinyint(3) unsigned not null default '0'
,`status`               decimal(3,0) default null
,`bytes`                double default null
,`url`                  char(255) default null
,`user_id`              int not null 
,`host`                 char(15) default null
,foreign key (`user_id`) references `clients` (`id`) on delete cascade
) ENGINE=INNODB;
*/
