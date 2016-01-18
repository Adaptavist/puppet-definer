Definer Module
==============
[![Build Status](https://travis-ci.org/Adaptavist/puppet-definer.svg?branch=master)](https://travis-ci.org/Adaptavist/puppet-definer)

The purpose of this module is to declare resources using hiera. This follows
the philosophy that Puppet should be data driven as much as possible. In
combination with the roles module this pushes as much as possible into the
realm of hiera.

Global and host level config can be defined in hiera and can be merged together.
The `merge_defs` boolean controls the merging, a value of true (default) merges 
host and global config, a value of false ignores global and uses host config.
Its important to note that by default only top level keys are merged, this
means that if you have the "user" key at global and host level only the host 
level values will be applied.

Example
=======

The best way to explain usage is to show an example.

The following hiera yaml file will define a user and a group called hosting and
a host entry for `test-host`

#### global.yaml

    #!yaml
    ---

    definer::defs:
      group:
        hosting:
          ensure: 'present'
        testgroup
          ensure: 'present'
      user:
        hosting:
          ensure:     'present'
          gid:        'hosting'
          managehome: true
          shell:      '/sbin/nologin'
      host:
        test-host:
          host_aliases: 'test-host.example.com'
          ip:           '1.2.3.4'
    hosts:
      host1':
        definer::defs:
          user:
            host1user:
              ensure: 'present'
