include ::java
class { 'elastic_stack::repo':
  version => 6,
}

class { 'elasticsearch':
  version => '6.8.8',
  restart_on_change => true,
}

elasticsearch::instance { 'es-01':
  ensure => absent,
}

elasticsearch::instance { 'data-01':
  config      => {
    'network.host'                       => '10.17.17.20',
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
