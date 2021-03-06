class rt_base{
  $tools = [
    'git',

    'build-essential',
    'ruby-dev',
    'zlib1g-dev',
    'libpcre3',
    'libpcre3-dev',

    'openssl',
    'zip',
    'unzip',
    'vim',
    'libbz2-dev',
    'libssl-dev',
    'tar',
    'htop',
    'acl',
  ]

  ensure_packages($tools)

  package{'puppet':
    ensure => latest,
  }

# Librarian puppet
  exec{'librarian':
    command => '/usr/bin/gem install librarian-puppet',
    user => 'root',
    cwd => '/etc/puppet',
    creates => '/usr/local/bin/librarian-puppet'
  }

# CREATE A NO LOGIN SHELL (FOR FTP)
  file{ '/usr/sbin/ftponly':
    ensure  =>  link,
    target  =>  '/usr/sbin/nologin',
  }->
  file_line{ '/etc/shells':
    ensure  =>  present,
    line    =>  '/usr/sbin/ftponly',
    path    =>  '/etc/shells',
  }

# .bashrc template: force color
  file { '/etc/skel/.bashrc':
    ensure  => present,
  }->
  file_line { 'force_color in .bashrc skel':
    path    => '/etc/skel/.bashrc',
    line    => 'force_color_prompt=yes',
    match   => '^#force_color_prompt=yes$',
  }

# refresh roots .bashrc
  file { '/root/.bashrc':
    ensure  => present,
  }->
  file_line { 'force_color in /root/.bashrc ':
    path    => '/root/.bashrc',
    line    => 'force_color_prompt=yes',
    match   => '^#force_color_prompt=yes$',
  }

# Scripts
  file{'/usr/local/sbin/rt-puppet-apply.sh':
    ensure => present,
    mode   => 700,
    source => 'puppet:///modules/rt_base/rt-puppet-apply.sh'
  }

# Puppet apply cron
  file{'/var/log/puppet':
    ensure      => directory,
    mode        => 750
  }->

  cron {  'puppet_apply':
    command     =>  '/usr/local/sbin/rt-puppet-apply >> /var/log/puppet/apply.log 2> /var/log/puppet/apply.error.log',
    user        =>  'root',
    minute      =>  [10,20,30,40,50],
    hour        =>  absent,
  }


}