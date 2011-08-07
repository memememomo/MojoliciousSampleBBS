package BBS::C::Root;
use Mojo::Base 'Mojolicious::Controller';


sub index {
    my $self = shift;

    my @entries = $self->db->search(
	entry => {}, {limit => 10, offset => 0, order_by => {'entry_id' => 'DESC'}}
    );

    $self->render(entries => \@entries);
};


sub post {
    my $self = shift;
    if ( my $body = $self->param('body') ) {
	BBS::M::Entry->insert_body($body);
    }
    $self->redirect_to('index');
}


sub delete {
    my $self = shift;
    if ( my $entry_id = $self->param('entry_id') ) {
	BBS::M::Entry->delete($entry_id);
    }
    $self->redirect_to('index');
}


1;
