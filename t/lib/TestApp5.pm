package t::lib::TestApp5;

use Dancer2;
use Dancer2::Plugin::Locale::Meta;

hook 'before' => sub {
  my $structure = { 
                    "en" => {
                      "color" => {
                        "trans" => "color",
                      },
                      "greeting" => {
                        "trans" => "hello"
                      }
                    },
                    "es" => {
                      "color" => {
                        "trans" => "color",
                      },
                      "greeting" => {
                        "trans" => "hola"
                      }
                    }
                  };


  load_structure($structure);
};
get '/:lang' => sub {
  session 'lang' => param('lang');
  my $a = loc('greeting');
  return $a;
};

1;
