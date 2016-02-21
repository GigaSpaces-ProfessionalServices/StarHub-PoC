#!/bin/bash

echo "--- Start deploying service chain ---"

cfy blueprints delete -b firewall
cfy blueprints delete -b loadbalancer
cfy blueprints delete -b serviceChain

cfy blueprints upload -b firewall     -p firewall.yaml
cfy blueprints upload -b loadbalancer -p loadbalancer.yaml
cfy blueprints upload -b serviceChain -p serviceChain.yaml

cfy deployments create -b serviceChain -d serviceChain

cfy executions start -d  serviceChain -w install
cfy executions list | grep serviceChain
