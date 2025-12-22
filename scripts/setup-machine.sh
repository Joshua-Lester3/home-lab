#!/bin/bash

# Editing setup
apt-get update && apt-get install -y vim
sed -i 's/XKBLAYOUT=.*/XKBLAYOUT="us"/' /etc/default/keyboard
sed -i 's/XKBVARIANT=.*/XKBVARIANT="dvorak"/' /etc/default/keyboard
setupcon

# Disable Enterprise Repo in .sources files and Add the No-Subscription repo
sed -i 's/^Suites: pve-enterprise/# Suites: pve-enterprise/g' /etc/apt/sources.list.d/pve-enterprise.sources 2>/dev/null
echo "deb http://download.proxmox.com/debian/pve $(source /etc/os-release && echo $VERSION_CODENAME) pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list
apt update