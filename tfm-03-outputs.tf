output "system_assigned_identity_kv_access_policy_id" {
  value = azurerm_key_vault_access_policy.spcc_kv_access_policy_system_assigned[*].id
}

output "user_assigned_identity_kv_access_policy_id" {
  value = azurerm_key_vault_access_policy.spcc_kv_access_policy_user_assigned[*].id
}