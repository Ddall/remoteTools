class rt_browsers{

  # Keys
  apt::source { 'tor_main':
    location => 'http://deb.torproject.org/torproject.org',
    release  => 'trusty',
    repos    => 'main',
    key      => {
      id     => 'A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89',
      server => 'keys.gnupg.net',
    },
    notify => Exec['apt_update'],
  }

  # Packages
  $packages = [
    'firefox',
    'tor',
    'torbrowser-launcher',
  ]

  package{$packages:
    ensure => latest,
  }

}