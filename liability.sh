#!/usr/bin/env bash

WORKSPACE=`pwd`

# Build when needed
if [ ! -x ws ]; then
    mkdir -p ws/src && cd ws/src
    catkin_init_workspace
    ln -s $WORKSPACE/robonomics_comm 
    cd ..
    catkin_make
    cd ..
fi

# Generate keyfile
if [ ! -e keyfile ]; then
    PASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c32)
    echo $PASSWORD > keyfile_password_file
    python -c "import os,eth_keyfile,json; print(json.dumps(eth_keyfile.create_keyfile_json(os.urandom(32), '$PASSWORD'.encode())))" > keyfile
fi

# Init IPFS
[ ! -x ~/.ipfs ] && ipfs init
ipfs daemon --enable-pubsub-experiment &
sleep 5
ipfs swarm connect /dns4/lighthouse.aira.life/tcp/4001/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8

# Launch liability
. ws/devel/setup.bash
roslaunch robonomics_liability liability.launch \
    ens_contract:="0x905D0105A6465FE1C11B00ad10552b05b5c04E17" \
    lighthouse_contract:="energyhack2018.lighthouse.3.robonomics.eth" \
    keyfile:="$WORKSPACE/keyfile" \
    keyfile_password_file:="$WORKSPACE/keyfile_password_file" \
    web3_http_provider:="https://kovan.infura.io/v3/4023cac5af2548e682ffe03d06c5dfef" \
    web3_ws_provider:="wss://kovan.infura.io/ws"
