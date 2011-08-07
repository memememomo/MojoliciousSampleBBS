package BBS::M::Entry;
use Mojo::Base 'BBS::M';


sub insert_body {
    my ($self, $body) = @_;

    if ( $body ) {

	my $row = $self->db->insert(
	    entry => {
		body => $body,
		created_at => \"datetime('now')",
		updated_at => \"datetime('now')",
	    },
	);

	$self->db->insert(
	    entry_log => {
		event    => 'insert',
		entry_id => $row->entry_id,
		body     => $body,
		created_at => \"datetime('now')",
		updated_at => \"datetime('now')",
	    },
	);
    }
}


sub delete {
    my ($self, $entry_id) = @_;

    if ( $entry_id ) {
	my $entry = $self->db->single(entry => { entry_id => $entry_id });

	if ( $entry ) {

	    $self->db->insert(
		entry_log => {
		    event    => 'delete',
		    entry_id => $entry_id,
		    body     => $entry->body,
		    created_at => \"datetime('now')",
		    updated_at => \"datetime('now')",
		},
            );

	    $entry->delete;
	}
    }
}


1;
