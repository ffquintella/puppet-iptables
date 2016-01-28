define iptables::table (
  $table = $title,
  $chain = 'OUTPUT',
  $rules = undef,
) {
  include iptables

  validate_string($table)
  validate_string($chain)
  validate_array($rules)


  if $rules != undef {

    $rules.each | Integer $index, String $value |{

      $port = $value[port]
      $rule = $value[rule]
      $protocol = $value[protocol]
      $source = $value[source]
      $sourcemask = $value[sourcemask]
      $destination = $value[destination]
      $destinationmask = $value[destinationmask]


      iptables::table::rule {"${table}-${chain}-${index}-${port}-${rule}-${protocol}-${source}-${sourcemask}-${destination}-${destinationmask}":
        table => $table,
        chain => $chain,
        port => $value[port],
        rule => $value[rule],
        protocol => $value[protocol],
        source => $value[source],
        sourcemask => $value[sourcemask],
        destination => $value[destination],
        destinationmask => $value[destinationmask],
      }
    }
  }

}
