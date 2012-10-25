define iptables::deny (
  $port,
  $protocol = 'tcp'
) {
  include iptables
  file { "/root/iptables.d/deny_${port}_${protocol}_${title}":
    ensure  => file,
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0600',
    require => Class['iptables'],
    notify  => Class['iptables::update'],
  }
}
