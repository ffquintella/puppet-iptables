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


    $new_syntax_only = hiera('iptables::new_syntax_only', false)

    if (!$new_syntax_only){



      create_resources( 'iptables::rule', lookup('iptables::ports', {
        merge         => deep,
        default_value => $ports,
        }) )

      #create_resources( 'iptables::rule', lookup('iptables::ports', $ports) )

    }
    $tables = lookup('iptables::tables', {
      merge         => deep,
      default_value => undef,
      })
    #$tables = hiera_hash('iptables::tables', undef)

    if $tables != undef {
        create_resources('iptables::table', $tables)

    }

  }
}
