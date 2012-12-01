#
class apt-mirror (
  $ensure    = present,
  $enabled   = true,
  $base_path = '/var/spool/apt-mirror',
  $nthreads  = 20,
  $tilde     = 0
) {

  include concat::setup

  package { 'apt-mirror':
    ensure => $ensure,
  }

  concat { '/etc/apt/mirror.list':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment { 'mirror.list header':
    target  => '/etc/apt/mirror.list',
    content => template('apt-mirror/header.erb'),
    order   => '01',
  }

  cron { 'apt-mirror':
    ensure  => $enabled ? { false => absent, default => present },
    user    => 'root',
    command => '/usr/bin/apt-mirror /etc/apt/apt-mirror.list',
    minute  => 0,
    hour    => 4,
  }

}
