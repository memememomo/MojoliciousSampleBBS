package BBS::DB::Schema;
use Teng::Schema::Declare;

table {
    name 'entry';
    pk 'entry_id';
    columns qw( entry_id body updated_at created_at );
};

table {
    name 'entry_log';
    pk 'entry_log_id';
    columns qw( entry_log_id entry_id body event updated_at created_at );
};

1;
