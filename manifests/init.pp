# == Class: nfsd
#
# === Authors
#
# - Damian Lukowski <damian.lukowski@credativ.de>
#
class nfsd (
  $exports = params_lookup('exports'),
) {
  case $::osfamily {
    Debian: {
      # ok
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

  $exports_file  = '/etc/exports'
  $exports_template  = 'exports.erb'

  package { 'nfs-kernel-server':
    ensure  => 'installed',
  }

  file { $exports_file:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/${exports_template}"),
  }
}
