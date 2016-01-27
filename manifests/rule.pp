define iptables::rule (
  $port = $title,
  $source = '0.0.0.0',
  $sourcemask = '0',
  $destination = '0.0.0.0',
  $destinationmask = '0',
  $tcp = undef,
  $udp = undef
) {
  include iptables
  
  
 # if(!defined(Notify["source: ${source}/${sourcemask} destination: ${destination}/${destinationmask}"])){
 #     notify{"source: ${source}/${sourcemask} destination: ${destination}/${destinationmask}":}}
    
  if $tcp {
    case $tcp {
      'allow': { iptables::allow{ "tcp/${port}/${source}/${sourcemask}/${destination}/${destinationmask}":
        port            => $port,
        protocol        => 'tcp',
        source          => $source,
        sourcemask      => $sourcemask,
        destination     => $destination,
        destinationmask => $destinationmask
        }}
      'drop':  { iptables::drop{  "tcp/${port}/${source}/${sourcemask}/${destination}/${destinationmask}":
        port            => $port,
        protocol        => 'tcp',
        source          => $source,
        sourcemask      => $sourcemask,
        destination     => $destination,
        destinationmask => $destinationmask
        }
    }
    default: {
        fail("iptables: unknown action '${tcp}' - use 'allow' or 'drop'")
      }
    }
  }
  if $udp {
    case $udp {
      'allow': { iptables::allow{ "udp/${port}/${source}/${sourcemask}/${destination}/${destinationmask}":
        port            => $port,
        protocol        => 'udp',
        source          => $source,
        sourcemask      => $sourcemask,
        destination     => $destination,
        destinationmask => $destinationmask
       }
     }
      'drop':  { iptables::drop{  "udp/${port}/${source}/${sourcemask}/${destination}/${destinationmask}":
        port            => $port,
        protocol        => 'udp',
        source          => $source,
        sourcemask      => $sourcemask,
        destination     => $destination,
        destinationmask => $destinationmask
        }
      }
      default: {
        fail("iptables: unknown action '${udp}' - use 'allow' or 'drop'")
      }
    }
  }
}
