apt-mirror puppet module
========================
A simple Puppet module for apt-mirror.

Usage
-----
```puppet
class { 'apt-mirror': }
apt-mirror::mirror { 'puppetlabs':
  mirror     => 'apt.puppetlabs.com',
  os         => '',
  release    => 'precise',
  components => ['main'],
}
```

