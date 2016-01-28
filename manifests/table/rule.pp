define iptables::table::rule (
  $table = undef,
  $chain = undef,
  $rule = 'ACCEPT',
  $port = '0',
  $protocol = 'tcp',
  $source = '0.0.0.0',
  $sourcemask = '0',
  $destination = '0.0.0.0',
  $destinationmask = '0'
) {

  validate_string ($table)
  validate_string ($chain)

#  $filename = "/root/iptables.d/table_${table}_${chain}_${port}_${protocol}_${source}_${sourcemask}_${destination}_${destinationmask}"
  $filename = "/tmp/table_${table}_${chain}_${port}_${protocol}_${source}_${sourcemask}_${destination}_${destinationmask}"

  if ! defined(File[$filename]) {
    file { $filename:
      ensure  => file,
      mode    => '0600',
      require => Class['iptables::config'],
      notify  => Class['iptables::update'],
    }
  }

}
