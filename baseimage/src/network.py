#!/usr/bin/env python3
import configparser
import uuid
import os

def create_conf(vlan_id):
    if vlan_id < 2:
        name = 'wired'
        priority = '10'
        mode = 'ethernet'
    else:
        name = 'vlan%03d' %(vlan_id)
        priority = '20'
        mode = 'vlan'

    config = configparser.ConfigParser()
    connection = dict()
    connection['id'] = name
    connection['uuid'] = str(uuid.uuid4())
    connection['interface-name'] = name
    connection['type'] = mode
    connection['autoconnect'] = 'yes'
    connection['autoconnect-priority'] = priority

    ipv4 = dict()
    ipv4['method'] = 'auto'

    ipv6 = dict()
    ipv6['method'] = 'auto'

    config['connection'] = connection

    if vlan_id > 1:
        vlan = dict()
        vlan['parent'] = 'eth0'
        vlan['id'] = str(vlan_id)
        config['vlan'] = vlan
    
    config['ipv4'] = ipv4
    config['ipv6'] = ipv6

    with open(name, 'w') as f:
        config.write(f)

os.makedirs('/disk/base-pre/etc/NetworkManager/system-connections')
os.chdir('/disk/base-pre/etc/NetworkManager/system-connections')
for vlan_id in range(1, 300, 1):
    create_conf(vlan_id)
