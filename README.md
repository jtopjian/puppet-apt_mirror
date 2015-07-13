apt-mirror puppet module
========================
A simple Puppet module for apt-mirror.

Usage
-----
```puppet
class { 'apt_mirror': }
apt_mirror::mirror { 'puppetlabs':
  mirror     => 'apt.puppetlabs.com',
  os         => '',
  release    => 'precise',
  components => ['main'],
}
```

For hiera:

```hiera
apt_mirror::mirror_list:
  'puppetlabs':
    mirror:     'apt.puppetlabs.com'
    os:         ''
    release:
      - 'precise'
    components: 
      - 'main'
```
