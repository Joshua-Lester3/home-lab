#!/bin/bash

qm set 100 -scsi2 /dev/disk/by-id/ata-WDC_WD200EDGZ-11B9PA0_21GDX03Y 
qm reboot 100
talosctl get disks -e 192.168.0.65 --talosconfig _out/talosconfig # verify (replace ip with current)

# i had to wipe before mounting. not sure if you'd need to do that again.

# patch:
talosctl --talosconfig _out/talosconfig -e 192.168.0.68 -n 192.168.0.68 patch mc --patch @patches/storage-patch.yaml --patch @patches/kubelet-extra-mount.yaml

# check if mounted:
talosctl --talosconfig _out/talosconfig -e 192.168.0.68 -n 192.168.0.68 get volumestatuses 