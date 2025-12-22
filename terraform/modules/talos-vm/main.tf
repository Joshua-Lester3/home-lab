resource "proxmox_virtual_environment_vm" "talos_node" {
  name      = var.vm_name
  node_name = var.target_node # e.g., "pve-sff" or "pve-micro"
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
    enabled   = true
    file_id   = proxmox_virtual_environment_download_file.talos_iso.id
  }

  # Disk Configuration (SCSI/VirtIO)
  disk {
    datastore_id = "local-zfs" # Adjust to your specific storage ID
    file_format  = "raw"
    interface    = "scsi0"
    size         = var.disk_size
    ssd          = true        # Treats disk as SSD (rotational=0)
    discard      = "on"        # TRIM support
  }

  network_device {
    bridge = "vmbr0"
  }

  # GPU Passthrough (Conditional)
  # Only applies if 'passthrough_igpu' is true (e.g., for the Media node)
  dynamic "hostpci" {
    for_each = var.passthrough_igpu ? [1] : []
    content {
      device  = "hostpci0" # ?
      mapping = "iGPU" # ?
      pcie    = true # ?
      rombar  = true # ?
    }
  }

  # Boot Order
  boot_order = ["ide2", "scsi0"] # Hard disk first, then CDROM
  
  operating_system {
    type = "l26"
  }
}

# Automatically download the Talos ISO from the Factory to Proxmox [cite: 148-149]
resource "proxmox_virtual_environment_download_file" "talos_iso" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.target_node
  
  # The Factory URL is passed here
  url          = "https://factory.talos.dev/image/${talos_image_factory_schematic.this.id}/${var.talos_version}/${var.platform}.iso"
  file_name    = "talos-${var.talos_version}-${var.platform}.iso"
}