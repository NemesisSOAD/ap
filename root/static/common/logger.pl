#!/usr/bin/perl -w

use strict;
use warnings;
use DBI();

$0 = 'dark-logger';
$| = 1;

my $conf = {
    'host'      => 'localhost',
    'port'      => '3306',
    'base'      => 'squid',
    'user'      => 'squid',
    'pass'      => 'nzjyxy19',
    'log'       => '/var/log/squid/squid_backup.log',
};

# Connect to database
my $dbh = DBI->connect("dbi:mysql:dbname=$conf->{base};host=$conf->{host};port=$conf->{port}", $conf->{user}, $conf->{pass}, { AutoCommit=>1, RaiseError=>0, PrintError=>1 }) || &errorcon;

my $sth = {
    'insert'    => $dbh->prepare("insert into logs(date,time,elapsed,code,status,bytes,url,user_id,host) VALUES (?,?,?,?,?,?,?,?,?)"),
    'uid'       => $dbh->prepare("select id from clients where user_name = ?"),
    'tr_upd'    => $dbh->prepare("update clients set tr_limit = (tr_limit - ?) where id = ?")
};

open(BLOG,$conf->{log});

close(BLOG);

while(<>) {
    chomp;
    my @lines=split(' ');

    $lines[0]=~tr/./ /;
    my @_timestamp=split(' ',$lines[0]);
    my $cts=$_timestamp[0];


    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = gmtime($cts);
    $year=$year+1900;
    $mon=$mon+1;
    $hour=$hour+7;
    if ($hour>24) {
	$hour=$hour-24;
	$mday=$mday+1;
    }
    my $cdate="$year-$mon-$mday";
    my $ctime="$hour:$min:$sec";
    my $duration=$lines[1];
    my $remotehost=$lines[2];
    my $_code;

    my @codestatus=split('/',$lines[3]);
    if ($codestatus[0] eq "TCP_HIT") { $_code=0; }
    if ($codestatus[0] eq "TCP_MISS") { $_code=1; }
    if ($codestatus[0] eq "TCP_REFRESH_HIT") { $_code=2; }
    if ($codestatus[0] eq "TCP_REF_FAIL_HIT") { $_code=3; }
    if ($codestatus[0] eq "TCP_REFRESH_MISS") { $_code=4; }
    if ($codestatus[0] eq "TCP_CLIENT_REFRESH_MISS") { $_code=5; }
    if ($codestatus[0] eq "TCP_IMS_HIT") { $_code=6; }
    if ($codestatus[0] eq "TCP_SWAPFILE_MISS") { $_code=7; }
    if ($codestatus[0] eq "TCP_NEGATIVE_HIT") { $_code=8; }
    if ($codestatus[0] eq "TCP_MEM_HIT") { $_code=9; }
    if ($codestatus[0] eq "TCP_DENIED") { $_code=10; }
    if ($codestatus[0] eq "TCP_OFFLINE_HIT") { $_code=11; }
    if ($codestatus[0] eq "UDP_HIT") { $_code=12; }
    if ($codestatus[0] eq "UDP_MISS") { $_code=13; }
    if ($codestatus[0] eq "UDP_DENIED") { $_code=14; }
    if ($codestatus[0] eq "UDP_INVALID") { $_code=15; }
    if ($codestatus[0] eq "UDP_MISS_NOFETCH") { $_code=16; }
    if ($codestatus[0] eq "NONE") { $_code=17; }

    my $_status=$codestatus[1];
    my $objectsize=$lines[4];

    my @neighborhood = qw(.iss-atom\.ru .iss-atom\.int);

    my $URLlink=$lines[6];
    $objectsize=0 if grep $URLlink =~ m%$_%, @neighborhood;
    my $fetchmethod=$lines[5];
    my $username=$lines[7];
    my @peerstatus_host=split('/',$lines[8]);
    my $peerstatus=$peerstatus_host[0];
    my $peerhost=$peerstatus_host[1];
    my $objecttype=$lines[9];

    if (($_code) && ($_code ne "10") && ($username ne "-") && ($_status ne "404") && ($_status ne "400")) {
        $sth->{uid}->execute($username);
        my $row = $sth->{uid}->fetchrow_hashref();
        $sth->{insert}->execute($cdate,$ctime,$duration,$_code,$_status,$objectsize,$URLlink,$row->{id},$remotehost) || die "cannot transfer data";
        $sth->{tr_upd}->execute($objectsize,$row->{id});
    }
}

sub errorconn {
    while(<>) {
        open(BLOG,">>".$conf->{log});
        print BLOG $_;
        close(BLOG);
    }
    die "cannot log to MySQL -- data buffered";
}
