# Get VM Details
data "azurerm_virtual_machine" "spcc_vm_data" {
  name                = var.vm_name
  resource_group_name = var.virtual_machine_rg
}

# Get current principal
data "azurerm_client_config" "current_principal" {
}


# "SystemAssigned" - Allow the VM having access to Key Vault through System Managed Identity
resource "azurerm_key_vault_access_policy" "spcc_kv_access_policy_system_assigned" {
  count        = var.use_user_assigned_identity == "false" ? 1 : 0
  key_vault_id = var.key_vault_id

  tenant_id = data.azurerm_client_config.current_principal.tenant_id
  object_id = data.azurerm_virtual_machine.spcc_vm_data.identity.0.principal_id

  key_permissions    = ["get", "list"]
  secret_permissions = ["get", "list", "set", "delete", "recover", "backup", "restore"]
}

# Get the User Assigned Identity that will be attached to the VM
data "azurerm_user_assigned_identity" "spcc_msi_user" {
  count               = var.use_user_assigned_identity == "true" ? 1 : 0
  name                = "${var.vm_name}-msi"
  resource_group_name = var.msi_rg
}


# "UserAssigned" - Allow the VM having access to Key Vault through User Managed Identity
resource "azurerm_key_vault_access_policy" "spcc_kv_access_policy_user_assigned" {
  count        = var.use_user_assigned_identity == "true" ? 1 : 0
  key_vault_id = var.key_vault_id

  tenant_id = data.azurerm_client_config.current_principal.tenant_id
  object_id = data.azurerm_user_assigned_identity.spcc_msi_user[0].principal_id

  key_permissions    = ["get", "list"]
  secret_permissions = ["get", "list", "set", "delete", "recover", "backup", "restore"]
}

# Discussion Point: Use Case for Identity Type = ["SystemAssigned", "UserAssigned"]