include ::java
class { 'elastic_stack::repo':
  version => 6,
}

class { 'elasticsearch':
  version => '6.8.8',
  restart_on_change => true,
}

$server = $facts['hostname']
elasticsearch::instance { "data-$server":
  config      => {
    'network.host'                       => '_eth1:ipv4_',
  	'cluster.name'                       => 'labsetup',
  	'node.master'                        => false,
  	'node.data'                          => true,
  	'discovery.zen.ping.unicast.hosts'   => ['10.17.17.31','10.17.17.32'],
  	'discovery.zen.minimum_master_nodes' => 1,
  },
  jvm_options => [
    '-Xms512m',
    '-Xmx512m',
  ]
}
