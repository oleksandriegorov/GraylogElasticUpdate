include ::java
class { 'elastic_stack::repo':
  version => 5,
}

class { 'elasticsearch':
  version => '5.6.7',
  restart_on_change => true,
}

elasticsearch::instance { 'data-02':
  config      => {
    'network.host'                       => '10.17.17.23',
  	'cluster.name'                       => 'labsetup5.6',
  	'node.master'                        => false,
  	'node.data'                          => true,
  	'discovery.zen.ping.unicast.hosts'   => ['10.17.17.21','10.17.17.22'],
  	'discovery.zen.minimum_master_nodes' => 1,
  },
  jvm_options => [
    '-Xms512m',
    '-Xmx512m',
  ]
}
