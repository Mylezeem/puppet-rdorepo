# == Class: rdorepo
#
# Full description of class rdorepo here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { rdorepo:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class rdorepo (
  $enabled = true,
  $release = 'icehouse',
) {

  validate_re($release, ['^havana$','^icehouse$'], "Release must be 'havana' or 'icehouse'. Found ${release}")

  if ! ($::operatingsystem in ['RedHat', 'Fedora', 'CentOS']) {
    fail ("This module does not support your operating system : ${::operatingsystem}")
  }

  $repo = $::operatingsystem ? {
    'RedHat' => 'epel',
    'CentOS' => 'epel',
    'Fedora' => 'fedora',
  }
  $os_ver = $::operatingsystem ? {
    'RedHat' => $::operatingsystemmajrelease,
    'CentOS' => $::operatingsystemmajrelease,
    'Fedora' => '$releasever',
  }

  yumrepo { "openstack-${release}" :
    name                => "Openstack ${release} Repository",
    baseurl             => "http://repos.fedorapeople.org/repos/openstack/openstack-${release}/${repo}-${os_ver}/",
    gpgkey              => "/etc/pki/rpm-gpg/RPM-GPG-KEY-RDO-${release}",
    gpgcheck            => 1,
    enabled             => bool2num($enabled),
    skip_if_unavailable => 0,
    priority            => 98,
  }

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-RDO-Icehouse' :
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'pupet:///modules/rdorepo/RPM-GPG-KEY-RDO-Icehouse'
  }

  rdorepo::rpm_gpg_key { 'RPM-GPG-KEY-RDO-Icehouse' :
    path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-RDO-Icehouse',
  }

}
