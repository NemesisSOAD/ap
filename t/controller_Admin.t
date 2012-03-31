use strict;
use warnings;
use Test::More;

BEGIN { use_ok 'Catalyst::Test', 'ap' }
BEGIN { use_ok 'ap::Controller::Admin' }

ok( request('/admin')->is_success, 'Request should succeed' );
done_testing();
