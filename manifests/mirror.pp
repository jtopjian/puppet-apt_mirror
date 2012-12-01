#
define apt-mirror::mirror (
  $mirror,
  $os         = 'ubuntu',
  $release    = ['precise'],
  $components = ['main', 'contrib', 'non-free'],
  $source     = false,
) {

  concat::fragment { $name:
    target  => '/etc/apt/mirror.list',
    content => template('apt-mirror/mirror.erb'),
    order   => '02',
  }

}
