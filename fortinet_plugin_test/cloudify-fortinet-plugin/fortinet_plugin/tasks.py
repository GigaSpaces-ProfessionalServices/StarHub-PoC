from pyFG import FortiOS

forti_username = 'admin'
forti_password = 'password'
portMask = '255.255.255.0'
host_ip = '192.168.122.146'


def port_config():
    print('Start port config task....')
    port_id = 2  # port 1 reserved for admin

    fortinet_host_ip = host_ip
    print('fortinet host ip : {0}'.format(fortinet_host_ip))

    port_alias = 'out'
    target_ip = '172.30.1.10'
    set_port(fortinet_host_ip, target_ip, port_id, port_alias)
    port_id += 1

    port_alias = 'in'
    target_ip = '172.10.1.10'
    set_port(fortinet_host_ip, target_ip, port_id, port_alias)


def set_port(fortinet_host_ip, target_ip, port_id, port_alias):
    print ('Configure fw port ....')

    command = \
        'config system interface\n' \
        '   edit port%s\n' \
        '       set mode static\n' \
        '       set allowaccess ping http https\n' \
        '       set alias %s\n' \
        '       set ip %s  %s\n' \
        '   next\n' \
        'end' % (port_id, port_alias, target_ip, portMask)

    exec_command(command, fortinet_host_ip)


def fw_config():
    print('Start fw configuration....')

    fortinet_host_ip = host_ip
    print('Fortinet_host_ip: {0}'.format(fortinet_host_ip))
    gateway = '10.10.10.1'

    #command = 'execute update-now'
    #exec_command(command, fortinet_host_ip)

    command = \
        'config router static\n' \
        '   edit 1\n' \
        '       set dst  0.0.0.0/24\n' \
        '       set gateway  %s\n' \
        '       set device port2\n' \
        'end' % gateway

    exec_command(command, fortinet_host_ip)

    command = \
        'configure firewall address\n' \
        '   edit rule1\n' \
        '       set subnet %s/24\n' \
        '       set associated-interface port2\n' \
        'end' % gateway

    exec_command(command, fortinet_host_ip)

    command = \
        'config firewall service custom\n' \
        '   edit firewallServer\n' \
        '       set protocol "TCP"\n' \
        '       set tcp-portrange 50-1000\n' \
        'end'

    exec_command(command, fortinet_host_ip)

    command = \
        'config firewall policy\n' \
        '  edit 1\n' \
        '    set srcintf \"port2\"\n' \
        '    set dstintf \"port3\"\n' \
        '    set srcaddr \"all\"\n' \
        '    set dstaddr \"all\"\n' \
        '    set action accept\n' \
        '    set schedule \"always\"\n' \
        '    set service \"firewallServer\"\n' \
        '  next\n' \
        'end'

    exec_command(command, fortinet_host_ip)


def exec_command(command, fortinet_host_ip):

    print('Open connection to host {0} '.format(fortinet_host_ip))
    conn = FortiOS(fortinet_host_ip, username=forti_username, password=forti_password)
    conn.open()

    print("Execute Command >> \n {0}".format(command))

    conn.execute_command(command)
    conn.close()

if __name__ == "__main__":

    #port_config()

    fw_config()

