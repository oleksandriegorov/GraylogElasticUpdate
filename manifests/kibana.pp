class { 'elastic_stack::repo':
  version => 6,
}

class { 'kibana':
  ensure => latest,
  config => {
    'elasticsearch.hosts' => ['http://10.17.17.31:9200','http://10.17.17.32:9200'],
    'server.host'         => '10.17.17.10',
  }
}
