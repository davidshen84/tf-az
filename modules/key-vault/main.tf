resource "random_string" "rnd" {
  keepers = {
    rg = var.rg.name
  }

  length  = 7
  lower   = true
  upper   = false
  special = false
  numeric = true
}

resource "azurerm_key_vault" "vault" {
  name                        = "${var.rg.name}-kv-${random_string.rnd.result}"
  location                    = var.rg.location
  resource_group_name         = var.rg.name
  enabled_for_disk_encryption = false
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.sku_name
}

resource "azurerm_key_vault_access_policy" "default-policy" {
  key_vault_id = azurerm_key_vault.vault.id
  tenant_id    = var.tenant_id
  object_id    = var.owner_id

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "GetRotationPolicy",
    "Import",
    "List",
    "List",
    "Purge",
    "Recover",
    "Release",
    "Restore",
    "Rotate",
    "SetRotationPolicy",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey"
  ]
}

resource "azurerm_key_vault_key" "key" {
  name         = "key-${random_string.rnd.result}"
  key_vault_id = azurerm_key_vault.vault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  depends_on = [azurerm_key_vault_access_policy.default-policy]
}
