class iptables (
  $allow_icmp      = 'yes',
  $allow_localhost = 'yes',
  $log_failures    = 'yes',
  $ports           = undef
) {
  include iptables::update
  include iptables::install
  include iptables::service
  include iptables::config
  if !$ports {
    include iptables::default
  }
  else {
    create_resources( 'iptables::rule', hiera_hash('iptables::ports', $ports) )

    $tables = hiera_array('iptables::tables', undef)

  /*  notify {"Tables input ${tables} ":
      withpath => true,
    }*/

    if $tables != undef {

      create_resources('iptables::table', hash($table))
    }

  }
}
