package Dancer2::Plugin::Locale::Meta;

use strict;
use warnings;
use Dancer2::Plugin;
use Dancer2::FileUtils;
use I18N::AcceptLanguage;
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


    



1;
