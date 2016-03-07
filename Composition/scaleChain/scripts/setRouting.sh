#!/bin/bash

ctx logger info "---> Set route to Vyatta 172.30.0.1"

subnet='0.0.0.0/0'
gw='172.30.0.1'

route add -net $subnet gw $gw
route del -net $subnet gw 172.10.1.1
