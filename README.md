# RDO Repository

[![Build Status](https://api.travis-ci.org/Mylezeem/puppet-rdorepo.svg?branch=master)](https://travis-ci.org/Mylezeem/puppet-rdorepo)
[![Puppet Forge](http://img.shields.io/puppetforge/v/yguenane/rdorepo.svg)](https://forge.puppetlabs.com/yguenane/rdorepo)
[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)


#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with rdorepo](#setup)
    * [What rdorepo affects](#what-rdorepo-affects)
    * [Beginning with rdorepo](#beginning-with-rdorepo)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations](#limitations)
6. [Contributors](#contributors)

## Overview

A Puppet module to manage the RDO repository in order to access the OpenStack
packages in an Enterprise Linux derivative operating system.

## Module Description

This module simply allows one to enable/disable the use of the RDO repository
on an Enterprise Linux derivative operating system

## Setup

### What rdorepo affects

* rdo-release repo file (/etc/yum.repos.d/rdo-release.repo)
* the corresponding GPG keys

### Beginning with rdorepo

`include ::rdorepo` is enough to enable the RDO repository.

## Usage

All interaction with the rdorepo module can do be done through the main rdorepo class.
This means you can simply toggle the options in `::rdorepo` to have full functionality of the module.

###I just want the RDO repository to be enabled, what's the minimum I need?

```puppet
include '::rdorepo'
```

###I want to specify the release for which I want the packages for

```puppet
class { '::rdorepo':
  release => 'havana',
}
```

## Reference

####Public Classes

* rdorepo: Main class

###Parameters

The following parameters are available in the rdorepo module:

####`enabled`

Whether the RDO repository should be enabled.

####`release`

The release name to get the OpenStack packages for.

## Limitations

The module has been tested on:

* RedHat Enterprise Linux 6/7
* CentOS 6/7
* Fedora 19/20

The module has been tested for the OpenStack releases :

* icehouse
* havana

## Contributors

The list of contributors can be found at: [https://github.com/Mylezeem/puppet-rdorepo/graphs/contributors](https://github.com/Mylzeem/puppet-rdorepo/graphs/contributors)
