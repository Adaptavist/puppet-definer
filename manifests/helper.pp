#
# = define definer::helper
# helper define for the definer class
define definer::helper (
    $params
){
    validate_hash($params)
    $p = $params[$name]
    validate_hash($p)
    create_resources($title, $p)
}
