variable "name" {
  description = "aks name"
}

variable "rg" {
  description = "the resource group object"
}

variable "pool_size" {
  description = "aks managed pool size"
}

variable "vm_size" {
  description = "aks vm size"
}

variable "subnet" {
  description = "vnet subnet"
}
