#!/bin/bash

k create ns media

# initial username is admin
kubectl logs -n media -l app=gluetun-qbittorrent -c qbittorrent 2>&1 | grep -i password