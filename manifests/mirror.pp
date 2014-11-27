# = Definition apt_mirror::mirror
#
# == Parameters
#
# [*mirror*]
#
# Hostname or URL for upstream mirror  ( e.g. 'us.archive.ubuntu.com' or 'http://apt.puppetlabs.com' )
#
# REQUIRED 
#
# [*os*]
#
# Name of operating system
#
# Default: 'ubuntu'
#
# [*release*]
#
# Array of release version names to include in mirror ( e.g. [ 'trusty', 'trusty-updates', ] )
#
# Default: [ 'precise', ]
#
# [*components*]
#
# Array of repo components to include in mirror ( e.g. [ 'main', 'restricted', 'universe', 'multiverse', ] )
#
# Default: ['main', 'contrib', 'non-free']
#
# [*source*]
#
# Enable mirroring of source packages. Boolean, true|false
#
# Default: false
#
# [*alt_arch*]
#
# Array of alternate architectures to include in mirror. ( e.g. [ 'i386', 'armel', 'powerpc', ] )
#
# Default: undef
#

define apt_mirror::mirror (
  $mirror,
  $os         = 'ubuntu',
  $release    = ['precise'],
  $components = ['main', 'contrib', 'non-free'],
  $source     = false,
  $alt_arch   = undef,
) {

  concat::fragment { $name:
    target  => '/etc/apt/mirror.list',
    content => template('apt_mirror/mirror.erb'),
    order   => '02',
  }

}
