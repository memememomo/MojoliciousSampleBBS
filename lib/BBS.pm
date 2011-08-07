package BBS;
use Mojo::Base 'Mojolicious';

use BBS::DB;


# This method will run once at server start
sub startup {
  my $self = shift;

  # Log Level
  $self->app->log->level('debug');

  # Make signed cookies secure
  $self->secret('Mojolicious rocks!');

  # Mode
  $self->mode('development');

  # Load config
  my $config_file = $self->home.'/conf/config.'. $self->mode  .'.pl';
  my $config = $self->plugin('config' => {
      file => $config_file,
      stash_key => 'config'
  });

  # session
  $self->sessions->default_expiration(60 * 60 * 24);

  # Charset
  $self->plugin('charset' => {charset => 'UTF-8'});

  # Text::Xslate
  $self->plugin('xslate_renderer' => {
      template_options => {
	  'syntax'   => 'TTerse',
	  'module'   => [ 'Text::Xslate::Bridge::TT2Like' ],
	  %{$config->{'Text::Xslate'}},
      }
  });

  # Teng
  my $db = BBS::DB->new($config->{'Teng'});
  $self->helper(db => sub { return $db });

  # Model
  my $loader = Mojo::Loader->new;
  for my $module (@{$loader->search('BBS::M')}) {
      my $e = $loader->load($module);
      $module->db($self->db);
  }

  # Dispatch
  $self->__dispatch();
}


sub __dispatch {
  my $self = shift;

  my $r = $self->routes;

  # Controller namespace
  $r->namespace('BBS::C');

  # Set routes
  $r->route('/')                ->to('root#index') ->name('index');
  $r->route('/post')            ->to('root#post')  ->name('index/post');
  $r->route('/delete/:entry_id')->to('root#delete')->name('index/delete');
}


1;
