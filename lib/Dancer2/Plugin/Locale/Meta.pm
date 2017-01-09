package Dancer2::Plugin::Locale::Meta;

use strict;
use warnings;
use Dancer2::Plugin;
use Dancer2::FileUtils;
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

BEGIN{
  has 'fallback' => (
    is => 'ro',
    from_config => 1,
    default => sub {}
  );

  has 'locale_path_directory' => (
    is => 'ro',
    from_config => 1,
    default => sub { './i18n' }
  );

  has 'lang_session' => (
    is => 'ro',
    from_config => 1,
    default => sub { 'lang' }
  );

  has 'locale_meta' => (
    is => 'rw',
    default => sub {

    $locale_meta ||= Locale::Meta->new(_path_directory_locale($self));

    }
  );

  plugin_keywords qw/
    loc
  /;

}

sub BUILD {
  my $plugin = shift;
  $plugin->app->add_hook( Dancer2::Core::Hook->new(
    name => 'before_template_render',
    code => sub {
      my $tokens = shift;
      $tokens->{l} = sub { loc($self, @_); };
    }
  ));
}

sub loc {
    my ($self, $str, $args, $force_lang) = @_;
    return 'yes';
};



1;
