# = Class: apt_mirror
#
# Configures apt-mirror
#
# == Parameters
#
# [*ensure*]
#
# The ensure value for apt-mirror package.
#
# Default: present
#
# [*enabled*]
#
# Enables/disables cron job.
#
# Default: true
#
# [*base_path*]
#
# The base directory for apt-mirror.
#
# Default: /var/spool/apt-mirror
#
# [*var_path*]
#
# Directory where apt-mirror logs.
#
# Default: $base_path/var
#
# [*defaultarch*]
#
# Architectures to be mirrored.
#
# Default: $::architecture
#
# [*cleanscript*]
#
# Script to be executed for cleaning up.
#
# Default: $var_path/clean.sh
#
# [*postmirror_script*]
#
# Script to be executed for post mirroring tasks.
#
# Default: $var_path/postmirror.sh
#
# [*run_postmirror*]
#
# Whether to execute postmirror script.
#
# Default: 0
#
# [*nthreads*]
#
# Number of threads to be run in parallel.
#
# Default: 20
#
# [*tilde*]
#
# Allow proper download of mirrors with a tilde in the url or package name.
#
# [*wget_limit_rate*]
#
# Limit bandwidth for wget/thread.
#
# Default: unlimited
#
# [*wget_auth_no_challenge*]
#
# Wget will send Basic HTTP authentication information (plaintext username
# and password) for all requests.
#
# Default: false
#
# [*wget_no_check_certificates*]
#
# Don't check the server certificate against the available certificate
# authorities.
#
# Default: false
#
# [*wget_unlink*]
#
# Force Wget to unlink file instead of clobbering existing file.
#
# Default: false
#
# == Requires
#
# puppetlabs-concat
#
# == Examples
#
# class { 'apt_mirror':
#   nthreads        => 5,
#   wget_limit_rate => 100k,
# }
#
class apt_mirror (
  $ensure                    = present,
  $enabled                   = true,
  $base_path                 = '/var/spool/apt-mirror',
  $mirror_path               = '$base_path/mirror',
  $var_path                  = '$base_path/var',
  $defaultarch               = $::architecture,
  $cleanscript               = '$var_path/clean.sh',
  $postmirror_script         = '$var_path/postmirror.sh',
  $run_postmirror            = 0,
  $nthreads                  = 20,
  $tilde                     = 0,
  $wget_limit_rate           = undef,
  $wget_auth_no_challenge    = false,
  $wget_no_check_certificate = false,
  $wget_unlink               = false
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
