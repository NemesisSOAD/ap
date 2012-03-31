package ap::Controller::Admin;
use Moose;
use namespace::autoclean;
use JSON::XS;
use Data::Dumper;

BEGIN {extends 'Catalyst::Controller'; }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash(
        current_view => 'Admin',
        template => 'admin/index.tt2',
    );
}

sub user_login : Local {
    my ( $self, $c ) = @_;

    my $data = $c->model('Adm')->user_login($c->req->param('user_login'),$c->req->param('user_pass'));
    my $json = JSON::XS->new->utf8->decode($data);
    if ($json->{data}[0]->{id}) {
        $c->session(
            'id' => $json->{data}[0]->{id},
            'role_id' => $json->{data}[0]->{role_id},
        );
        $c->response->body( '{"success" : "true", "data" : [{"status" : "Ok", "message" : "Удачный вход в систему"}]}' );
    } else {
        $c->response->body( $data );
    }
}

sub get_acls : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->get_acls($c->session->{role_id});
    $c->response->body( $data );
}

sub add_acl : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->add_acl($c->session->{role_id},$c->req->param('acl_name'),$c->req->param('acl_desc'),$c->req->param('acl_redir'));
    $c->response->body( $data );
}

sub upd_acl : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->upd_acl($c->session->{role_id},$c->req->param('acl_id'),$c->req->param('acl_name'),$c->req->param('acl_desc'),$c->req->param('acl_redir'),$c->req->param('act'));
    $c->response->body( $data );
}

sub del_acl : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->del_acl($c->session->{role_id},$c->req->param('acl_id'));
    $c->response->body( $data );
}

sub get_urls : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->get_urls($c->session->{role_id},$c->req->param('acl_id'));
    $c->response->body( $data );
}

sub get_types : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->get_types($c->session->{role_id});
    $c->response->body( $data );
}

sub add_url : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->add_url($c->session->{role_id},$c->req->param('acl_id'),$c->req->param('url'),$c->req->param('type_id'));
    $c->response->body( $data );
}

sub del_url : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->del_url($c->session->{role_id},$c->req->param('url_id'));
    $c->response->body( $data );
}

sub get_groups : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->get_groups($c->session->{role_id});
    $c->response->body( $data );
}

sub get_grants : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->get_grants($c->session->{role_id},$c->req->param('group_id'));
    $c->response->body( $data );
}

sub get_users : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->get_users($c->session->{role_id},$c->req->param('group_id'));
    $c->response->body( $data );
}

sub add_user : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->add_user($c->session->{role_id},$c->req->param('group_id'),$c->req->param('user_name'),$c->req->param('fio'),$c->req->param('tr_limit'));
    $c->response->body( $data );
}

sub upd_user : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->upd_user($c->session->{role_id},$c->req->param('group_id'),$c->req->param('user_id'),$c->req->param('fio'),$c->req->param('tr_limit'),$c->req->param('act'));
    $c->response->body( $data );
}

sub del_user : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->del_user($c->session->{role_id},$c->req->param('user_id'));
    $c->response->body( $data );
}

sub upd_group : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->upd_group($c->session->{role_id},$c->req->param('group_id'),$c->req->param('group_name'),$c->req->param('policy'),$c->req->param('strict'),$c->req->param('act'));
    $c->response->body( $data );
}

sub add_group : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->add_group($c->session->{role_id},$c->req->param('group_name'),$c->req->param('policy'),$c->req->param('strict'));
    $c->response->body( $data );
}

sub del_group : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->del_group($c->session->{role_id},$c->req->param('group_id'));
    $c->response->body( $data );
}

sub get_tree : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->get_tree($c->session->{role_id},$c->req->param('node'));
    $c->response->body( $data );
}

sub get_stats : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->get_stats($c->session->{role_id},$c->req->param('user_id'),$c->req->param('date'));
    $c->response->body( $data );
}

sub add_grant : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->add_grant($c->session->{role_id},$c->req->param('acl_id'),$c->req->param('group_id'));
    $c->response->body( $data );
}

sub del_grant : Local {
    my ( $self, $c ) = @_;
    my $data = $c->model('Adm')->del_grant($c->session->{role_id},$c->req->param('grant_id'));
    $c->response->body( $data );
}

sub export_topdf :Chained('/') :PathPart('admin/export_pdf') : Args(3): Local {
    my ( $self, $c, $sdate, $edate, $uid ) = @_;
    
    $c->stash->{pdf_template} = 'export.tt2';
    $c->stash->{stime} = $sdate;
    $c->stash->{etime} = $edate;
    my $data = $c->model('Adm')->get_stat($c->session->{role_id},$sdate, $edate, $uid);
    $c->stash->{stat_data} = $data;
    
    $c->forward('View::PDF');
}

=head1 AUTHOR

Semenets Pavel,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
