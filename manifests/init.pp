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

    $new_syntax_only = hiera('iptables::new_syntax_only', false)

    if (!$newsyntax){
      $tables = hiera_hash('iptables::tables', undef)
    }

  /*  notify {"Tables input ${tables} ":
      withpath => true,
    }*/

    if $tables != undef {
        create_resources('iptables::table', $tables)

    }

  }
}
