terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.89.1"
    }

    talos = {
      source  = "siderolabs/talos"
      version = "0.10.0-beta.0"
    }
  }
}

provider "proxmox" {
  endpoint   = var.proxmox_endpoint
  api_token  = var.proxmox_api_key
  insecure   = true
}

provider "talos" {
  # config
}