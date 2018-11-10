#!/usr/bin/env bash

# Init IPFS
[ ! -x ~/.ipfs ] && ipfs init
ipfs daemon --enable-pubsub-experiment &
sleep 5
while [ 1 ]; do
    ipfs swarm connect /dns4/lighthouse.aira.life/tcp/4001/ipfs/QmdfQmbmXt6sqjZyowxPUsmvBsgSGQjm4VXrV7WGy62dv8
    sleep 10
done
