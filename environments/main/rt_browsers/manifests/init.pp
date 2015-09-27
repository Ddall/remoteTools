class rt_browsers{

# test two sources with the same key
  apt::source { 'tor_main':
    location => 'http://deb.torproject.org/torproject.org',
    release  => 'trusty',
    repos    => 'main',
    key      => {
      id     => 'A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 ',
      server => 'keys.gnupg.net',
    },
  }
  apt::source { 'tor_src':
    location => 'http://deb.torproject.org/torproject.org',
    release  => 'trusty',
    repos    => 'main',
    key      => {
      id     => 'A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89',
      server => 'keys.gnupg.net',
    },
  }

  

}