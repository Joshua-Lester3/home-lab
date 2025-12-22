resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode({
    customization = {
      systemExtensions = {
        officialExtensions = [
          "siderolabs/i915-ucode",      # GPU Firmware
          "siderolabs/intel-ucode",     # CPU Stability
          "siderolabs/qemu-guest-agent" # Proxmox IP Reporting
        ]
      }
    }
  })
}