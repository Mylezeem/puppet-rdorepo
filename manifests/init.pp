# == Class: rdorepo
#
# A Puppet module to manage the RDO repository
#
# === Parameters
#
# [*enabled*]
#   (boolean) Whether the RDO repository should be enabled
#   Default: true
#
# [*release*]
#   (string) The name of the Openstack release to get the RDO repository for
#   Possible value: havana, icehouse
#   Default: latest release (currently icehouse)
#
# === Examples
#
#  include rdorepo
#
#    or
#
#  class { 'rdorepo' :
#    release => 'havana',
#  }
#
# === Authors
#
#  Yanis Guenane <yguenane@gmail.com>
#
# === Copyright
#
# Copyright 2014 Yanis Guenane
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

  $blabla = $::operatingsystemrelease ? {
    /6.[0-9]/ => '6',
    /7.[0-9]/ => '7',
    default   => '$releasever',
  }

  yumrepo { "openstack-${release}" :
    name                => "OpenStack ${release} Repository",
    baseurl             => "http://repos.fedorapeople.org/repos/openstack/openstack-${release}/${repo}-${blabla}/",
    gpgkey              => "/etc/pki/rpm-gpg/RPM-GPG-KEY-RDO-${release}",
    gpgcheck            => 1,
    enabled             => bool2num($enabled),
    skip_if_unavailable => 0,
    priority            => 98,
  }

  file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-RDO-${release}" :
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => "pupet:///modules/rdorepo/RPM-GPG-KEY-RDO-${release}"
  }

  rdorepo::rpm_gpg_key { "RPM-GPG-KEY-RDO-${release}" :
    path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-RDO-${release}",
  }

}
