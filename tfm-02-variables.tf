variable "virtual_machine_rg" {
  description = "Name of the Resource Group in which the Virtual Machine should exist"
}

variable "vm_name" {
  description = "Name of the Virtual Machine that will be assigned the Managed Identity"
}

variable "key_vault_id" {
  description = "Name of the target Key Vault"
}

variable "use_user_assigned_identity" {
  description = "Flag to indicate if User Assigned Identity will be used for the VM"
}

variable "msi_rg" {
  description = "Name of the Resource Group in which the Managed Identity should exist"
}