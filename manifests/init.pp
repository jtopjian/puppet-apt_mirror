#
class apt_mirror (
  $ensure            = present,
  $enabled           = true,
  $base_path         = '/var/spool/apt-mirror',
  $mirror_path       = '$base_path/mirror',
  $var_path          = '$base_path/var',
  $defaultarch       = $::architecture,
  $cleanscript       = '$var_path/clean.sh',
  $postmirror_script = '$var_path/postmirror.sh',
  $run_postmirror    = 0,
  $nthreads          = 20,
  $tilde             = 0
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
    content => template('apt_mirror/header.erb'),
    order   => '01',
  }

  cron { 'apt-mirror':
    ensure  => $enabled ? { false => absent, default => present },
    user    => 'root',
    command => '/usr/bin/apt-mirror /etc/apt/mirror.list',
    minute  => 0,
    hour    => 4,
  }

}
