package Dancer2::Plugin::Locale::Meta;

# ABSTRACT: Interface to support multilanguage using Locale::Meta package.

use strict;
use warnings;
use Dancer2::Plugin;
use Locale::Meta;

our $VERSION = '0.001';

=head NAME

Dancer2::Pluging::Locale::Meta

=head DESCRIPTION

This plugin allow Dancer2 developers to use L<Locale::Meta> package.  This Plugin is
based on L<Dancer2::Plugin::Locale::Wolowitz> plugin.

=head SYNOPSIS

  use Dancer2;
  use Dancer2::Plugin::Locale::Meta;

  # in your templates

  get '/' => sub {
    my $greeting = loc("hello");
    template index.tt, { greeting => $greeting }
  }

  # in your template

  <% l('greeting') %>

=head CONFIGURATION

  plugins:
    Locale::Meta:
      fallback: "en"
      locale_path_directory: "i18n"
      lang_session: "lang"
=cut

BEGIN{
  has 'fallback' => (
    is => 'ro',
    from_config => 1,
    default => sub {}
  );

  has 'locale_path_directory' => (
    is => 'ro',
    from_config => 1,
    lazy => 1,
    default => sub { 
      './i18n'
    }
  );

  has 'lang_session' => (
    is => 'ro',
    from_config => 1,
    default => sub { 'lang' }
  );

  has 'locale_meta' => (
    is => 'rw',
  );

}


sub BUILD {
  my $plugin = shift;
  #Initialize Locale::Meta module
  my $lm = Locale::Meta->new( $plugin->locale_path_directory );
  #Set the locale::meta module as a variable of the plugin.
  $plugin->locale_meta($lm);

  $plugin->app->add_hook( Dancer2::Core::Hook->new(
    name => 'before_template_render',
    code => sub {
      my $tokens = shift;
      $tokens->{l} = sub { loc($plugin, @_); };
    }
  ));
}


plugin_keywords ('loc');

sub loc{
  my ($self, $str, $args, $force_lang) = @_;
  my $app = $self->app;
  my $lang = $force_lang || $app->session->read($self->lang_session) || $self->fallback;
  return $self->locale_meta->loc($str,$lang,@$args);
}

1;
