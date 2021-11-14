variable "rg" {
  description = "resource group object"
}

variable "name" {
  description = "ACR name"
}

variable "sku" {
  description = "Basic, Standard or Premium level"
  default = "Basic"
}
