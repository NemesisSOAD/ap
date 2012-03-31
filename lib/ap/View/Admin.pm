package ap::View::Admin;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    INCLUDE_PATH => [
        ap->path_to( 'root', 'src' ),
    ],
    TIMER => 0,
    WRAPPER => 'wr_admin.tt2',
    render_die => 1,
);

=head1 NAME

soap::View::Admin - TT View for soap

=head1 DESCRIPTION

TT View for soap.

=head1 SEE ALSO

L<soap>

=head1 AUTHOR

Semenets Pavel,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
