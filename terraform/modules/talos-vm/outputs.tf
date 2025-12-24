output "controlplane_ip" {
  value = element([
    for ip in flatten(proxmox_virtual_environment_vm.talos_node.ipv4_addresses) : 
    ip if startswith(ip, "192.168")
  ], 0)
}