package ap::Model::Adm;

use strict;
use warnings;
use DBI();
use URI::Escape;

use parent 'Catalyst::Model::DBI';

__PACKAGE__->config(
    dsn             => 'dbi:mysql:dbname=squid;port=3306;host=212.34.61.30',
    user            => 'squid',
    password        => 'nzjyxy19',
    options         => {AutoCommit => 1},
);

sub user_login {
    my ($self) = shift;
    my ($login,$passwd) = @_;
    my $sth = $self->dbh->prepare("select id,role_id,login,passwd,encrypt(?,substring(passwd,1,12)) as cpasswd from users where login = ?");
    $sth->execute($passwd,$login);
    my $row = $sth->fetchrow_hashref();
    if ($row) {
        if ($row->{passwd} ne $row->{cpasswd}) {
            return '{"failure" : "true", "data" : [{"status" : "Error", "message" : "Something wrong"}]}';
        } else {
            return '{"success" : "true", "data" : [{"status" : "Ok", "message" : "User Authorzed", "id" : "'. $row->{id} .'", "role_id" : "'. $row->{role_id} .'"}]}';
        }
    } else {
        return '{"failure" : "true", "data" : [{"status" : "Error", "message" : "Something wrong"}]}';
    }
}

sub get_acls {
    my ($self) = shift;
    my ($rid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("select * from acls;");
        $sth->execute();
        my $string = '{ "success" : "true", "data" : [';
        while (my $row = $sth->fetchrow_hashref()) {
            $string .= '{"id" : "'.$row->{id}.'", "acl_name" : "'.$row->{acl_name}.'", "acl_desc" : "'.$row->{acl_desc}.'", "acl_redir": "'.$row->{acl_redir}.'", "cdate" : "'.$row->{cdate}.'", "mdate" : "'.$row->{mdate}.'", "active" : "'.$row->{"active"}.'"},';
        }
        $string .= ']}';
        $string=~s/}\,]}/}]}/;
        return $string;
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub add_acl {
    my ($self) = shift;
    my ($rid,$aname,$adesc,$aredir) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("insert into acls (`acl_name`,`acl_desc`,`acl_redir`,`cdate`,`mdate`) values (?,?,?,now(),now())");
        $sth->execute($aname,$adesc,$aredir);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "Acl list added" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub upd_acl {
    my ($self) = shift;
    my ($rid,$aid,$aname,$adesc,$aredir,$atc) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("update `acls` set `acl_name` =?, `acl_desc` =?, `acl_redir` = ?, `active` = ?, `mdate` = now() where id = ?");
        $sth->execute($aname,$adesc,$aredir,$atc,$aid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "Acl list updated" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub del_acl {
    my ($self) = shift;
    my ($rid,$aid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("delete from `acls` where `id` = ?");
        $sth->execute($aid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "Acl list deleted" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub get_urls {
    my ($self) = shift;
    my ($rid,$aid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("select u.`id`,u.`acl_id`,u.`url`,u.`type`,t.`type_name` from `urls` u join `types` t on u.`type` = t.`id` where u.`acl_id` = ?");
        $sth->execute($aid);
        my $string = '{ "success" : "true", "data" : [';
        while (my $row = $sth->fetchrow_hashref()) {
            $string .= '{"id" : "'.$row->{id}.'", "acl_id" : "'.$row->{acl_id}.'", "url" : "'.$row->{url}.'", "type" : "'.$row->{type}.'", "type_name": "'.$row->{type_name}.'"},';
        }
        $string .= ']}';
        $string=~s/}\,]}/}]}/;
        return $string;
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub get_types {
    my ($self) = shift;
    my ($rid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("select * from `types`");
        $sth->execute();
        my $string = '{ "success" : "true", "data" : [';
        while (my $row = $sth->fetchrow_hashref()) {
            $string .= '{"id" : "'.$row->{id}.'", "type_name" : "'.$row->{type_name}.'"},';
        }
        $string .= ']}';
        $string=~s/}\,]}/}]}/;
        return $string;
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub add_url {
    my ($self) = shift;
    my ($rid,$aid,$uname,$tid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("insert into `urls` (`acl_id`,`url`,`type`) values (?,?,?)");
        $sth->execute($aid,$uname,$tid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "URL Added to list" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub del_url {
    my ($self) = shift;
    my ($rid,$uid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("delete from `urls` where `id` = ?");
        $sth->execute($uid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "URL deleted from list" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub get_groups {
    my ($self) = shift;
    my ($rid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("select * from `groups`");
        $sth->execute();
        my $string = '{ "success" : "true", "data" : [';
        while (my $row = $sth->fetchrow_hashref()) {
            $string .= '{"id" : "'.$row->{id}.'", "group_name" : "'.$row->{group_name}.'", "policy" : "'.$row->{policy}.'", "strict" : "'.$row->{strict}.'", "cdate": "'.$row->{cdate}.'", "mdate": "'.$row->{mdate}.'", "active": "'.$row->{active}.'"},';
        }
        $string .= ']}';
        $string=~s/}\,]}/}]}/;
        return $string;
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub get_grants {
    my ($self) = shift;
    my ($rid,$gid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("select a.id,a.acl_name,a.acl_desc,coalesce(ga.id,0) as grant_id, case when ga.id >= 1 then '1' else '0' end  as selected from groups g cross join acls a left join group_acls ga on g.id = ga.group_id and ga.acl_id = a.id where g.id = ? order by a.acl_name asc");
        $sth->execute($gid);
        my $string = '{ "success" : "true", "data" : [';
        while (my $row = $sth->fetchrow_hashref()) {
            $string .= '{"id" : "'.$row->{id}.'", "acl_name" : "'.$row->{acl_name}.'", "acl_desc" : "'.$row->{acl_desc}.'", "grant_id" : "'.$row->{grant_id}.'", "selected" : "'.$row->{selected}.'"},';
        }
        $string .= ']}';
        $string=~s/}\,]}/}]}/;
        return $string;
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub get_users {
    my ($self) = shift;
    my ($rid,$gid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("select * from clients where group_id = ? order by user_name asc");
        $sth->execute($gid);
        my $string = '{ "success" : "true", "data" : [';
        while (my $row = $sth->fetchrow_hashref()) {
            $string .= '{"id" : "'.$row->{id}.'", "group_id" : "'.$row->{group_id}.'", "user_name" : "'.$row->{user_name}.'", "fio" : "'.$row->{fio}.'", "cdate" : "'.$row->{cdate}.'", "mdate" : "'.$row->{mdate}.'", "tr_limit" : "'.($row->{tr_limit}/1024/1024).'", "active" : "'.$row->{active}.'"},';
        }
        $string .= ']}';
        $string=~s/}\,]}/}]}/;
        return $string;
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub add_user {
    my ($self) = shift;
    my ($rid,$gid,$uname,$fio,$trlimit) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("insert into `clients` (`group_id`,`user_name`,`fio`,`cdate`,`mdate`,`tr_limit`) values (?,?,?,now(),now(),?)");
        $sth->execute($gid,$uname,$fio,($trlimit*1024*1024));
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "User Added to group" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub upd_user {
    my ($self) = shift;
    my ($rid,$gid,$uid,$fio,$trlimit,$act) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("update `clients` set `group_id` = ?, `fio` = ?, `tr_limit` = ?, `active` = ?, `mdate` = now() where `id` = ?");
        $sth->execute($gid,$fio,($trlimit*1024*1024),$act,$uid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "User Info Updated" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub del_user {
    my ($self) = shift;
    my ($rid,$uid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("delete from `clients` where `id` = ?");
        $sth->execute($uid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "URL deleted from list" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub upd_group {
    my ($self) = shift;
    my ($rid,$gid,$gname,$policy,$strict,$act) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("update `groups` set `group_name` = ?, `policy` = ?, `strict` = ?, `active` = ?, `mdate` = now() where `id` = ?");
        $sth->execute($gname,$policy,$strict,$act,$gid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "Group Info Updated" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub add_group {
    my ($self) = shift;
    my ($rid,$gname,$policy,$strict) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("insert into `groups` (`group_name`,`policy`,`strict`,`cdate`,`mdate`) values (?,?,?,now(),now())");
        $sth->execute($gname,$policy,$strict);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "Group Added" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub del_group {
    my ($self) = shift;
    my ($rid,$gid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("delete from `groups` where `id` = ?");
        $sth->execute($gid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "URL deleted from list" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub get_tree {
    my ($self) = shift;
    my ($rid,$nid) = @_;
    if ($rid eq 1) {
        my $string = '{ "success" : "true", "data" : [';
        if ($nid eq 0) {
            my $sth = $self->dbh->prepare("select id,fio from clients order by user_name asc");
            $sth->execute();
            while (my $row = $sth->fetchrow_hashref()) {
                $string .= '{"id" : "'.$row->{id}.'", "text" : "'.$row->{fio}.'", "leaf" : false },';
            }
        } else {
            my $sth = $self->dbh->prepare("select distinct date from logs where user_id = ? order by date asc");
            $sth->execute($nid);
            while (my $row = $sth->fetchrow_hashref()) {
                my $sth1 = $self->dbh->prepare("select round(sum(bytes)/1024/1024,2) as summ from logs where date = ? and user_id = ?");
                $sth1->execute($row->{date},$nid);
                my $row1 = $sth1->fetchrow_hashref();
                $string .= '{"text" : "'.$row->{date}.' | '.$row1->{summ}.' Mb", "user_id" : "'.$nid.'", "leaf" : true },';
                $sth1->finish();
            }
        }
        $string .= ']}';
        $string=~s/}\,]}/}]}/;
        return $string;
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub get_stats {
    my ($self) = shift;
    my ($rid,$nid,$date) = @_;
    if ($rid eq 1) {
        my $string = '{ "success" : "true", "data" : [';
        my ($ndate,$traff)=split(' | ', $date);
        my $sth = $self->dbh->prepare("select elapsed,code,status,round((sum(bytes)/1024/1024),3) as mib,substring_index((substring_index(url,'/',3)),'/',-1) as url from logs where date = ? and user_id = ? group by 5 order by 4 desc");
        $sth->execute($ndate,$nid);
        while (my $row = $sth->fetchrow_hashref()) {
            $string .= '{"elapsed" : "'.$row->{elapsed}.'", "code" : "'.$row->{code}.'", "status" : "'.$row->{status}.'", "mib" : "'.$row->{mib}.'", "url" : "'.$row->{url}.'"},';
        }
        $string .= ']}';
        $string=~s/}\,]}/}]}/;
        return $string;
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
    
}

sub get_stat {
    my ($self) = shift;
    my ($rid,$sdate,$edate,$uid) = @_;
    my $data;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("select code,round((sum(bytes)/1024/1024),2) as mib,substring_index(substring_index((substring_index(url,'/',3)),'/',-1),'.',-2) as url from logs where date between ? and ? and user_id = ? group by 1,3 order by 2 desc");
        $sth->execute($sdate,$edate,$uid);
        while (my $row = $sth->fetchrow_hashref()) {
            $data->{$row->{url}}->{$row->{code}} = $row->{mib};
        }
        return $data;
    } else  {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub add_grant {
    my ($self) = shift;
    my ($rid,$aid,$gid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("insert into `group_acls` (`group_id`,`acl_id`) values (?,?)");
        $sth->execute($gid,$aid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "acl added to group" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

sub del_grant {
    my ($self) = shift;
    my ($rid,$gid) = @_;
    if ($rid eq 1) {
        my $sth = $self->dbh->prepare("delete from `group_acls` where id = ?");
        $sth->execute($gid);
        return '{"success" : "true", "data" : [{ "status" : "Ok", "message" : "acl deleted into group" }]}';
    } else {
        return '{"failure" : "true", "data" : [{ "status" : "Error", "message" : "You are not Main Administrator" }]}';
    }
}

1;
