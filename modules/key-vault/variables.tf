variable "rg" {
  description = "resource group object"
}

variable "tenant_id" {
  description = "azure tenant id"
}

variable "sku_name" {
  description = "key vault sku name"
  default = "standard"
}

variable "owner_id" {
  description = "azure service principal id"
}
