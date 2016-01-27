class iptables::default {
  # Enable SSH access
  iptables::allow { 'iptables-default-tcp-22':
    port            => 22,
    protocol        => 'tcp',
    sourcemask      => '0',
    destination     => '0.0.0.0',
    destinationmask => '0'
  }
}
