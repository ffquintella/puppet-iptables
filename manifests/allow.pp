define iptables::allow (
  $source = '0.0.0.0',
  $sourcemask = '0',
  $destination = '0.0.0.0',
  $destinationmask = '0',
  $port     = undef,
  $protocol = undef
) {
  include iptables
  $filename = "/root/iptables.d/allow_${port}_${protocol}_${source}_${sourcemask}_${destination}_${destinationmask}"
  if ! defined(File[$filename]) {
    file { $filename:
      ensure  => file,
      mode    => '0600',
      require => Class['iptables::config'],
      notify  => Class['iptables::update'],
    }
  }
}
