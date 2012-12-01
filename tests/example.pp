class { 'apt-mirror': }
apt-mirror::mirror { 'puppetlabs':
  mirror     => 'apt.puppetlabs.com',
  os         => '',
  release    => 'precise',
  components => ['main'],
}
