output "controlplane_ip" {
  value = element([
    for ip in flatten(proxmox_virtual_environment_vm.talos_node.ipv4_addresses) : 
    ip if startswith(ip, "192.168")
  ], 0)
}

output "talos_installer_image" {
    value = format(
        "factory.talos.dev/installer/%s:%s",
        regex("https://factory.talos.dev/image/([^/]+)/([^/]+)/.*", proxmox_virtual_environment_download_file.talos_iso.url)[0],
        regex("https://factory.talos.dev/image/([^/]+)/([^/]+)/.*", proxmox_virtual_environment_download_file.talos_iso.url)[1]
    )
}

output "hi" {
    value = talos_image_factory_schematic.this.schematic
}

output "hi2" {
    value = talos_image_factory_schematic.this.id
}