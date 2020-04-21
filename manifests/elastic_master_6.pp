include ::java
class { 'elastic_stack::repo':
  version => 6,
}

class { 'elasticsearch':
  version => '6.8.8',
  restart_on_change => true,
}

elasticsearch::instance { 'esm-01':
  ensure => absent,
}

elasticsearch::instance { 'master-01':
  config      => {
    'network.host' => '10.17.17.21',
		'cluster.name' => 'labsetup5.6',
    'node.master'  => true,
    'node.data'    => false,
  	'discovery.zen.ping.unicast.hosts'   => ['10.17.17.22'],
  	'discovery.zen.minimum_master_nodes' => 1,
  },
  jvm_options => [
    '-Xms256m',
    '-Xmx256m',
  ]
}
