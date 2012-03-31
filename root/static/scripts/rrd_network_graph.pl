#!/usr/bin/perl

use strict;
use warnings;
use RRDs;
use Net::SNMP;
use Data::Dumper;

my $dir		= '/usr/local/www/ap/root/static/rrd';
my $gdir	= '/usr/local/www/ap/root/static/graph';
my $rrd		= $dir . '/network.rrd';
my $bindir	= '/usr/local/bin';

my $host	= '10.77.0.1';
my $comm	= 'Wilnukr_23';
my $nif 	= '.1.3.6.1.2.1.2.1.0';
my $ifdesc	= '.1.3.6.1.2.1.2.2.1.2.';

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
	$data->{desc}->{$i} = $desc->{$ifdesc.$i};
}

foreach my $key (sort keys %{$data->{desc}}) {
	RRDs::graph $gdir . "/daily-$data->{desc}->{$key}-tio.png"
		,"--end", "now"
		,"--start" ,"end-1d"
		,"--imgformat", "PNG"
		,"--width=600"
		,"--height=150"
		,"-v Bytes Per Second"
		,"DEF:inavg=$rrd:".$data->{desc}->{$key}."InOct:AVERAGE"
		,"DEF:outavg=$rrd:".$data->{desc}->{$key}."OutOct:AVERAGE"
		,"COMMENT:\\n"
		,"COMMENT: Traffic for interface \"$data->{desc}->{$key}\"\\n"
		,"COMMENT:-----------------------------------------------------------------------------------------\\n"
		,"LINE2:inavg#5353e7:In\\t"
		,"GPRINT:inavg:MAX:Max\\: %8.2lf %Sbp/s"
		,"GPRINT:inavg:MIN:Min\\: %8.2lf %Sbp/s"
		,"GPRINT:inavg:AVERAGE:Avg\\: %8.2lf %Sbp/s\\n"
		,"LINE2:outavg#009804:Out\\t"
		,"GPRINT:outavg:MAX:Max\\: %8.2lf %Sbp/s"
		,"GPRINT:outavg:MIN:Min\\: %8.2lf %Sbp/s"
		,"GPRINT:outavg:AVERAGE:Avg\\: %8.2lf %Sbp/s\\n"
		,"COMMENT:-----------------------------------------------------------------------------------------\\n"
		,"COMMENT: All rights reserved by JSC \"MEGANET\"\t meganet\@meganet.ru \\n"
		,"COMMENT: Created by Darkman \t\t\t darkman\@meganet.ru\\n";

	RRDs::graph $gdir . "/daily-$data->{desc}->{$key}-pio.png"
                ,"--end", "now"
                ,"--start" ,"end-1d"
                ,"--imgformat", "PNG"
                ,"--width=600"
                ,"--height=150"
		,"-v Pakets Per Second"
                ,"DEF:inpkts=$rrd:".$data->{desc}->{$key}."InPkts:AVERAGE"
                ,"DEF:outpkts=$rrd:".$data->{desc}->{$key}."OutPkts:AVERAGE"
                ,"COMMENT:\\n"
                ,"COMMENT: Traffic for interface \"$data->{desc}->{$key}\"\\n"
                ,"COMMENT:-----------------------------------------------------------------------------------------\\n"
                ,"LINE2:inpkts#969800:In\\t"
		,"GPRINT:inpkts:MAX:Max\\: %8.2lf %Spkt/s"
                ,"GPRINT:inpkts:MIN:Min\\: %8.2lf %Spkt/s"
                ,"GPRINT:inpkts:AVERAGE:Avg\\: %8.2lf %Spkt/s\\n"
                ,"LINE2:outpkts#ff9212:Out\\t"
		,"GPRINT:outpkts:MAX:Max\\: %8.2lf %Spkt/s"
                ,"GPRINT:outpkts:MIN:Min\\: %8.2lf %Spkt/s"
                ,"GPRINT:outpkts:AVERAGE:Avg\\: %8.2lf %Spkt/s\\n"
		,"COMMENT:-----------------------------------------------------------------------------------------\\n"
                ,"COMMENT: All rights reserved by JSC \"MEGANET\"\t meganet\@meganet.ru \\n"
                ,"COMMENT: Created by Darkman \t\t\t darkman\@meganet.ru\\n";
}

