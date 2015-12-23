#
# = class definer
#
# THe purpose of this class is to allow resources to be defined using
# hiera, therefore creating a way to define resources in a data driven
# format. This reduces the need for helper modules.
#
class definer (
    $defs,
    $merge_defs = true
) {

    #defs can be set at either global or host level, therefore check to see if the hosts hash exists
    if ($host != undef) {

        validate_hash($host)

        #if a host level "merge_defs" flag has been set use it, otherwise use the global flag
        $merge_definers = $host["${name}::merge_defs"] ? {
            default => $host["${name}::merge_defs"],
            undef   => $merge_defs
        }

        #if there are host level defs
        if ($host["${name}::defs"] != undef) {
            #and we have merging enabled merge global and host defs
            if ($merge_definers) {
                $definers = merge($defs, $host["${name}::defs"])
            } else {
                $definers = $host["${name}::defs"]
            }
        }
        #if there are no host level defs just use global defs
        else {
            $definers = $defs
        }
    }
    #if there is no host hash then use global defs
    else {
        $definers = $defs
    }

    validate_hash($definers)
    $names = keys($definers)
    validate_array($names)
    definer::helper { $names:
        params => $definers,
    }
}
