variable "rg" {
  description = "resource group object"
}

variable "server_name" {
  description = "mssql server name"
}

variable "database_name" {
  description = "database name"
}

variable "admin_name" {
  description = "mssql server admin username"
}

variable "admin_password" {
  description = "mssql server admin password"
}

variable "sku_name" {
  description = "mssql sku name"
  default = "Basic"
}

variable "tags" {
  description = "tags object"
  default = {}
}
