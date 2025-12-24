variable "target_node" {
  description = "Proxmox node name (e.g., pve-sff, pve-micro)"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM (e.g., talos-cp-01)"
  type        = string
}

variable "vm_id" {
  description = "Static VM ID (e.g., 100)"
  type        = number
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 4
}

variable "memory_mb" {
  description = "RAM in MB"
  type        = number
  default     = 4096
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 40
}

variable "talos_version" {
  description = "Talos version for filename consistency"
  type        = string
  default     = "v1.9.0"
}

variable "platform" {
  description = "Platform identifier (e.g., metal-amd64)"
  type        = string
  default     = "metal-amd64"
}

variable "passthrough_igpu" {
  description = "Enable Intel iGPU passthrough (requires 'iGPU' resource map in Proxmox)"
  type        = bool
  default     = false
}

variable "proxmox_endpoint" {
  description = "Endpoint for proxmox service"
  type        = string
  sensitive   = true
}

variable "proxmox_api_key" {
  description = "Endpoint for proxmox service"
  type        = string
  sensitive   = true
}
