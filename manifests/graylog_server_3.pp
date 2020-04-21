include ::java
class { 'mongodb::globals':
  manage_package_repo => true,
  version             => '4.2.5',
}->
class { 'mongodb::server':
  bind_ip => ['127.0.0.1'],
}
class { 'graylog::repository':
  version => '3.2',
}->
class { 'graylog::server':
  package_version => 'latest',
  config          => {
    'http_bind_address'   => '0.0.0.0:9000',
#    'rest_listen_uri'     => 'http://0.0.0.0:9001/api/',
    'password_secret'     => 'temp123Temp!@#tEmP123teMp098',
    'root_password_sha2'  => '0a19533d8eae0719d0e75b3cfb2d80808111b7612756418145cc7103e621f352',
    'elasticsearch_hosts' => 'http://10.17.17.31:9200,http://10.17.17.32:9200',
  }
}
package { ['httparty','retries']:
  ensure   => present,
  provider => 'puppet_gem',
}
graylog_api { 'api':
  password => 'temp123',
  port     => 9001,
  username => 'admin',
}
# Default properties are often acceptable
graylog_api::input::gelf_udp { 'A GELF UDP Input':
  port => 11001,
}
graylog_index_set { 'graylog':
  description                => 'The Graylog default index set',
  display_name               => 'Default index set',
  shards                     => 4,
  replicas                   => 1,
  rotation_strategy          => 'size',
  rotation_strategy_details  => {
    max_size => '10 GB'.to_bytes,
  },
  retention_strategy         => 'delete',
  retention_strategy_details => {
    max_number_of_indices => 10,
  },
}
