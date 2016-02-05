#!/bin/bash

ctx logger info "---- Set route to FW and start Webserver  $fw_ip "

subnet='172.30.0.0/24'
gw='172.20.0.4'

# App network gateway
route add -net $subnet gw $gw

nohup python -m SimpleHTTPServer 80 &

echo '--->>' $fw_ip >> a.out
