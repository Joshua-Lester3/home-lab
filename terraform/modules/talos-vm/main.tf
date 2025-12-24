resource "proxmox_virtual_environment_vm" "talos_node" {
  name      = var.vm_name
  node_name = var.target_node
  vm_id     = var.vm_id

  cpu {
    cores = var.cpu_cores
    type  = "host"
  }

  memory {
    dedicated = var.memory_mb
  }

  agent {
    enabled = true
  }

  cdrom {
    file_id = proxmox_virtual_environment_download_file.talos_iso.id
  }

  disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    interface    = "scsi0"
    size         = var.disk_size
    ssd          = true
    discard      = "on"
  }

  network_device {
    bridge = "vmbr0"
  }

  # GPU Passthrough (passthrough_igpu = true for Media node)
  # dynamic "hostpci" {
  #   for_each = var.passthrough_igpu ? [1] : []
  #   content {
  #     device  = "hostpci0" # ?
  #     mapping = "iGPU" # ?
  #     pcie    = true # ?
  #     rombar  = true # ?
  #   }
  # }

  boot_order = ["scsi0", "ide3"]

  operating_system {
    type = "l26"
  }
}

# Automatically download the Talos ISO from the Factory to Proxmox
resource "proxmox_virtual_environment_download_file" "talos_iso" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.target_node

  url       = "https://factory.talos.dev/image/${talos_image_factory_schematic.this.id}/${var.talos_version}/${var.platform}.iso"
  file_name = "talos-${var.talos_version}-${var.platform}.iso"

  overwrite_unmanaged = true

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      checksum
    ]
  }
}