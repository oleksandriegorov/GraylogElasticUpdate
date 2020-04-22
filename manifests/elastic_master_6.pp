include ::java
class { 'elastic_stack::repo':
  version => 6,
}
class { 'elasticsearch':
  version => '6.8.8',
  restart_on_change => true,
}

$server = $facts['hostname']
elasticsearch::instance { "master-$server":
  config      => {
    'network.host' => '_eth1:ipv4_',
    'cluster.name' => 'labsetup',
    'node.master'  => true,
    'node.data'    => false,
  	'discovery.zen.ping.unicast.hosts'   => ['10.17.17.31','10.17.17.32'],
  	'discovery.zen.minimum_master_nodes' => 1,
    'xpack.monitoring.collection.enabled'    => true,
  },
  jvm_options => [
    '-Xms256m',
    '-Xmx256m',
  ]
}
