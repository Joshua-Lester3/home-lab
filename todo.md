next steps:

- need to finish setting up the cluster/linking nodes together

it'd be nice:

- might want to also automate adding tailscale if possible
- add https certificate, so you don't have to deal with the invalid cert message when connecting to stuff
- combine this whole setup into one pipeline, that I can run with one command
- gitops/argocd/etc :3

current:

- can somewhat spin up a proxmox machine quickly with scripts (mine and https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/tools/pve/post-pve-install.sh)
  - test this when home
- automated adding a basic talos vm through terraform. dont fully understand all the best practices around proxmox vm's and automating this
-
