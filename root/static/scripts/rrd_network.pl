#!/usr/bin/perl

use strict;
use warnings;
use RRDs;
use Net::SNMP;
use Data::Dumper;

my $dir		= '/usr/local/www/ap/root/static/rrd';
my $rrd		= $dir . '/network.rrd';
my $bindir	= '/usr/local/bin';

my $host	= '10.77.0.1';
my $comm	= 'Wilnukr_23';
my $nif 	= '.1.3.6.1.2.1.2.1.0';
my $ifdesc	= '.1.3.6.1.2.1.2.2.1.2.';
my $inoct 	= '.1.3.6.1.2.1.2.2.1.10.';
my $outoct 	= '.1.3.6.1.2.1.2.2.1.16.';
my $inpkts 	= '.1.3.6.1.2.1.2.2.1.11.';
my $outpkts 	= '.1.3.6.1.2.1.2.2.1.17.';

my ($sess,$err) = Net::SNMP->session(
	-hostname       => $host,
	-port           => 161,
	-community      => $comm,
);

if (!defined $sess) {
	printf "ERROR: %s.\n", $err;
	exit 1;
}

my $res = $sess->get_request(-varbindlist => [$nif, ], ) || die "Error: %s\n", $sess->error();

my $data = {};

for (my $i = 1 ; $i <= $res->{$nif} ; $i ++ ) {
	my $desc = $sess->get_request(-varbindlist => [$ifdesc.$i, ], ) || die "Error: %s\n", $sess->error();
	my $stat = $sess->get_request(-varbindlist => [$inoct.$i,$outoct.$i,$inpkts.$i,$outpkts.$i, ], ) || die "Error: %s\n", $sess->error();
	$data->{desc}->{$i} = $desc->{$ifdesc.$i};
	$data->{stats}->{$data->{desc}->{$i}.'InOct'} = $stat->{$inoct.$i};
	$data->{stats}->{$data->{desc}->{$i}.'OutOct'} = $stat->{$outoct.$i};
	$data->{stats}->{$data->{desc}->{$i}.'InPkts'} = $stat->{$inpkts.$i};
	$data->{stats}->{$data->{desc}->{$i}.'OutPkts'} = $stat->{$outpkts.$i};
}

if ( !-f $rrd ) {
	my $cmd = $bindir . "/rrdtool create $rrd --start N";

	foreach my $key (sort keys %{$data->{stats}}) {
		$cmd .= " DS:$key:COUNTER:600:U:U";
	}

	$cmd .= " RRA:AVERAGE:0.5:1:600 RRA:AVERAGE:0.5:6:700 RRA:AVERAGE:0.5:24:775 RRA:AVERAGE:0.5:288:797 RRA:MAX:0.5:1:600 RRA:MAX:0.5:6:700 RRA:MAX:0.5:24:775 RRA:MAX:0.5:288:797 RRA:MIN:0.5:1:600 RRA:MIN:0.5:6:700 RRA:MIN:0.5:24:775 RRA:MIN:0.5:288:797";
	system($cmd);
}

my $cmd = $bindir . "/rrdtool update $rrd N";
foreach my $key (sort keys %{$data->{stats}}) {
	$cmd .= ":$data->{stats}->{$key}";
}
system($cmd);

