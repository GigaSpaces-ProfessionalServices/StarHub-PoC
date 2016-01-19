#!/usr/bin/env bash


## Create/update Configure LB traffic manager and interfaces,
curl -v -H "Content-Type: application/json" -u admin:admin  -k -X PUT --data "@SetInterfaces.json" \
     https://192.168.122.84:9070/api/tm/3.5/config/active/traffic_managers/192.168.122.84








curl -v -H "Content-Type: application/json" -u admin:admin  -k -X PUT --data "@AddPool.json" \
  https://192.168.122.84:9070/api/tm/3.5/config/active/pools/CFY-Pool

curl -v -H "Content-Type: application/json" -u admin:admin  -k -X PUT --data "@CreatingTrafficIPGroup.json" \
  https://192.168.122.84:9070/api/tm/2.0/config/active/traffic_ip_groups/CFY-TIP

curl -v -H "Content-Type: application/json" -u admin:admin  -k -X PUT --data "@CreateSessionPersistence.json" \
  https://192.168.122.84:9070/api/tm/2.0/config/active/persistence/Persistence

curl -v -H "Content-Type: application/json" -u admin:admin  -k -X PUT --data "@AssigningSessionPersistence.json" \
  https://192.168.122.84:9070/api/tm/3.5/config/active/pools/CFY-Pool

curl -v -H "Content-Type: application/json" -u admin:admin  -k -X PUT --data "@CreatingVirtualServer.json" \
  https://192.168.122.84:9070/api/tm/2.0/config/active/virtual_servers/CFY-VS


