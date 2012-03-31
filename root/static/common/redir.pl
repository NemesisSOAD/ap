#!/usr/bin/perl -w

##########################################################################################################
# Initialize modules
##########################################################################################################

use strict;
use warnings;
use DBI();
use DBD::mysql;
use Data::Dumper;

##########################################################################################################
# Global variables
##########################################################################################################

$0 = 'dark-redir';
$| = 1;

my $conf = {
    'host'      => 'localhost',
    'port'      => '3306',
    'base'      => 'squid',
    'user'      => 'squid',
    'pass'      => 'nzjyxy19',
    'log'       => '/var/log/dark_redir.log',
    'def_url'   => 'http://deny.iss-atom.int/access_deny',
};

# Connect to database
my $dbh = DBI->connect("dbi:mysql:dbname=$conf->{base};host=$conf->{host};port=$conf->{port}", $conf->{user}, $conf->{pass});

# Prepare sql to check urls
my $sth = {
    'ip'            => $dbh->prepare("select a.acl_redir as redir from urls u join acls a on u.acl_id = a.id where u.acl_id in (select `acl_id` from `group_acls` where `group_id` = ?) and u.url = ? and u.type = 1 limit 1"),
    'domain'        => $dbh->prepare("select a.acl_redir as redir from urls u join acls a on u.acl_id = a.id where u.acl_id in (select `acl_id` from `group_acls` where `group_id` = ?) and u.url = ? and u.type = 2 limit 1"),
    'url'           => $dbh->prepare("select a.acl_redir as redir from urls u join acls a on u.acl_id = a.id where u.acl_id in (select `acl_id` from `group_acls` where `group_id` = ?) and u.url = ? and u.type = 3 limit 1"),
    'expr'          => $dbh->prepare("select a.acl_redir as redir from urls u join acls a on u.acl_id = a.id where u.acl_id in (select `acl_id` from `group_acls` where `group_id` = ?) and u.url = ? and u.type = 4 limit 1"),
    'chk_policy'    => $dbh->prepare("select g.id, g.policy as policy, g.strict as strict,u.tr_limit as limits from clients u join groups g on u.group_id = g.id where user_name = ?"),
};

##########################################################################################################
# Redirect checker
##########################################################################################################

# http://ri.revolvermaps.com/v.php?i=8kuvmokxrd5&t=m01nae&r=ukem 10.77.0.158/- is_artemov GET myip=10.77.0.2 myport=3128

while(<>) {
    # Parsing squid string
    my ($url, $who, $ident, $method, $ip, $port) = /^(\S+) (\S+) (\S+) (\S+) (\S+) (\S+)$/;
    
    # Check policy
    $sth->{chk_policy}->execute($ident);
    my $policy = $sth->{chk_policy}->fetchrow_hashref();
    
    # Default policy
    if (!$policy) {
        print "$conf->{def_url} $who $ident $method $ip $port\n";
        next;
    }
    
    # Check limit
    if ($policy->{limits} <= 0) {
        print "$conf->{def_url} $who $ident $method $ip $port\n";
        next;
    }
    
    # Check redirect behavior
    if ($policy->{policy} eq 0) {
        print "$url $who $ident $method $ip $port\n";
        next;
    } else {
        my $redir;
        # check urls
        my ($domain) = ($url=~m#^https?://(?:www\.)?([^/]+)#);
        if ($domain=~/^\d+\.\d+\.\d+\.\d+$/) {
            $sth->{ip}->execute($policy->{id},$domain);
            $redir = $sth->{ip}->fetchrow_hashref();
        } else {
            $sth->{domain}->execute($policy->{id},$domain);
            $redir = $sth->{domain}->fetchrow_hashref();
        }
        
        #if (!$redir) {
        #    $sth->{url}->execute($policy->{id},$domain);
        #    $redir = $sth->{url}->fetchrow_hashref();
        #}
        
        if ($redir->{redir} && $policy->{strict} eq 0) {
            print "$redir->{redir} $who $ident $method  $ip $port\n";
            next;
        } elsif ($redir->{redir} && $policy->{strict} eq 1) {
            print $redir->{redir} ne 'ok' ? $conf->{def_url} : $url . " $who $ident $method  $ip $port\n";
            next;
        } else {
            print "$url $who $ident $method  $ip $port\n";
            next;
        }
    }
}
