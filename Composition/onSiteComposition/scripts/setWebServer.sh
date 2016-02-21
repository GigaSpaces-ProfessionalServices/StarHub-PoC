#!/bin/bash

ctx logger info "---> Set route to FW 172.20.0.4 and start Webserver  "

subnet='172.30.0.0/24'
gw='172.20.0.4'

ip=$(ifconfig | grep 172.20 | awk '{print $2}')

# App network gateway
route add -net $subnet gw $gw

cat <<EOF > /root/index.html
<html>
  <head>
    <title>Web Server IP address</title>
  </head>
  <body bgcolor=white>
    This is Web Server ip : $ip
  </body>
</html>
EOF

cd /root
rm -f nohup

dtach -n nohup python -m SimpleHTTPServer 80 

