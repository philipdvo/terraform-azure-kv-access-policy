# terraform-azure-kv-access-policy

# Sample variable

```

virtual_machine_rg         = "infrastructure-rg-melbourne-test"
vm_name                    = "test-vm-01"

use_user_assigned_identity = "true"

```
# How to call the module

```
data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Australia Southeast"
}

resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

module "baominhcmg_kv_access_policy" {
  #source = "./Modules/terraform-azure-kv-access-policy"
  source = "git::https://github.com/philipdvo/terraform-azure-kv-access-policy.git"
  
  virtual_machine_rg = var.virtual_machine_rg
  vm_name            = var.vm_name
  use_user_assigned_identity = var.use_user_assigned_identity

  msi_rg                     = azurerm_resource_group" "example"
  key_vault_id       = azurerm_key_vault.example.id

}

```