package t::lib::TestApp1;

use Dancer2;

BEGIN{
  set plugins => {
      'Locale::Meta' => {
        
      },
  };
}

use Dancer2::Plugin::Locale::Meta;

get '/' => sub {
  return "ok";
};

1;
