#!/bin/bash
export OS_AUTH_URL=https://vio.shdemo.local:5000/v2.0
#export OS_AUTH_URL=https://10.2.0.10:5000/v2.0
#export OS_TENANT_ID=3f915b0b737e48b7b6c8568cc5a0125a
export OS_TENANT_NAME="tenant-a"
#export OS_TENANT_NAME="service"
#export OS_PROJECT_NAME="service"
export OS_PROJECT_NAME="tenant-a"
export OS_USERNAME="nfv-admin@shdemo.local"
export OS_PASSWORD="VMware1!"
export OS_REGION_NAME="nova"
export OS_CACERT="/root/vio.pem"

