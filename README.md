### Usage
- run Vagrantfile:
`vagrant up`
	- it is arranged to provision ElasticMaster servers first, then data nodes and only then Graylog
- ssh to graylog node and run log generator script:
`vagrant ssh gl`
`python3 /vagrant/scripts/flood_messages_graylog_udp.py 5.6`
	- remember to indicate a version of elasticseach: e.g. 5.6 or 6.8
	- this is useful to confirm that logs from previous version are actually present after upgrade

### Upgrade from 5.6 to 6.8 simulation
- make sure to switch to tag 6.8
- run vagrant reload with a provision forced:
`vagrant reload --provision`
- as a result master nodes will be upgraded first, followed by data nodes
