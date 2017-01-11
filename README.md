## Dancer2::Plugin::Locale::Meta

Interface to use Locale::Meta in order to provide multilanguage support to dancer2 apps.


# NAME
Dancer2::Pluging::Locale::Meta

# DESCRIPTION

This plugin allow Dancer2 developers to use Locale::Meta package. This
Plugin is based on Dancer2::Plugin::Locale::Wolowitz plugin.

# SYNOPSIS

    use Dancer2;
    use Dancer2::Plugin::Locale::Meta;

### in your templates

    get '/' => sub {
      my $greeting = loc("hello");
      template index.tt, { greeting => $greeting }
    }

### in your template

    <% l('greeting') %>

# CONFIGURATION
    plugins:
      Locale::Meta:
        fallback: "en"
        locale_path_directory: "i18n"
        lang_session: "lang"





