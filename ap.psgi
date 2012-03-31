use strict;
use warnings;

use ap;

#my $app = ap->apply_default_middlewares(ap->psgi_app);
my $app = ap->psgi_app;
$app;

