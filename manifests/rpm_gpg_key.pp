# define: rdorepo::rpm_gpg_key
#
# Import a RDO repository GPG key for rpm
#
# Parameters:
# [*path*]
#   path to GPG-key
#
# Actions:
#
#  Import GPG key
#
# Requires:
#
# Sample Usage:
#
#   rdorepo::rpm_gpg_key { 'RPM-GPG-KEY-RDO-icehouse' :
#      path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-RDO-icehouse',
#   }
#
define rdorepo::rpm_gpg_key($path) {
  # Given the path to a key, see if it is imported, if not, import it
  exec {  "import-${name}":
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => "rpm --import ${path}",
    unless    => "rpm -q gpg-pubkey-$(echo $(gpg --throw-keyids < ${path}) | cut --characters=11-18 | tr '[A-Z]' '[a-z]')",
    require   => File[$path],
    logoutput => 'on_failure',
  }
}

