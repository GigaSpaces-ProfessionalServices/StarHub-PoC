#!/bin/bash -e

ctx logger info "---- Set route to FW and start Webserver  $fw_ip "

subnet='172.30.0.0/24'
gw='172.20.0.4'
#gw=$fw_ip

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

nohup python -m SimpleHTTPServer 80 &


#
## Note, this contains some advanced info.
#
#import os
#import sys
#import subprocess
#
## Import Cloudify's context object.
## This provides several useful functions as well as allowing to pass
## contextual information of an application.
#from cloudify import ctx
#
#
#IS_WIN = os.name == 'nt'
#
## Get the port from the blueprint. We're running this script in the context of
## the `http_web_server` node so we can read its `port` property.
#PORT = ctx.node.properties['port']
#
#
#def run_server():
#    webserver_cmd = [sys.executable, '-m', 'SimpleHTTPServer', str(PORT)]
#    if not IS_WIN:
#        webserver_cmd.insert(0, 'nohup')
#
#    # The ctx object provides a built in logger.
#    ctx.logger.info('Running WebServer locally on port: {0}'.format(PORT))
#    # emulating /dev/null
#    with open(os.devnull, 'wb') as dn:
#        process = subprocess.Popen(webserver_cmd, stdout=dn, stderr=dn)
#    return process.pid
#
#
#def set_pid(pid):
#    ctx.logger.info('Setting `pid` runtime property: {0}'.format(pid))
#    # We can set runtime information in our context object which
#    # can later be read somewhere in the context of the instance.
#    # For instance, we want to save the `pid` here so that when we
#    # run `uninstall.py`, we can destroy the process.
#    ctx.instance.runtime_properties['pid'] = pid
#
#
#pid = run_server()
#set_pid(pid)
