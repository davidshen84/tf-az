variable "account" {
  description = "storage account name (global unique)"
}

variable "name" {
  description = "container name"
}

variable "rg" {
  description = "resource group object"
}

variable "tags" {
  description = "resource tags object"
  default = {}
}
