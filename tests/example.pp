class { 'apt_mirror': }
apt_mirror::mirror { 'puppetlabs':
  mirror     => 'apt.puppetlabs.com',
  os         => '',
  release    => 'precise',
  components => ['main'],
}
