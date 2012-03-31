package ap::View::PDF;

use strict;
use base 'Catalyst::View::PDF::API2';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    INCLUDE_PATH => [
        ap->path_to( 'root', 'pdf' ),
    ],
);

=head1 NAME

ap::View::PDF - PDF::API2 View for ap

=head1 DESCRIPTION

PDF::API2 View for ap. 

=head1 AUTHOR

Semenets Pavel,,,

=head1 SEE ALSO

L<ap>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
