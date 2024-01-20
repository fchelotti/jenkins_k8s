#!/usr/bin/env python
import requests
import urllib3
import os
from vmware.vapi.vsphere.client import create_vsphere_client

vsphere_srv = os.environ['VSPHERE_SRV']
username = os.environ['API_USER']
secret = os.environ['API_PASSWORD']

session = requests.session()

# Disable cert verification for demo purpose.
# This is not recommended in a production environment.
session.verify = False

# Disable the secure connection warning for demo purpose.
# This is not recommended in a production environment.
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Connect to a vCenter Server using username and password
vsphere_client = create_vsphere_client(server=vsphere_srv, username=username, password=secret, session=session)

# List all VMs inside the vCenter Server
for vm in vsphere_client.vcenter.VM.list():
    print(vm)