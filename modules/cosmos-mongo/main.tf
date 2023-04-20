variable "rg" {
  description = "resource group object"
}

variable "account_name" {
  description = "cosmos account name"
}

resource "azurerm_cosmosdb_account" "account" {
  name                = var.account_name
  location            = var.rg.location
  resource_group_name = var.rg.name
  offer_type          = "Standard"
  kind                = "MongoDB"

  enable_automatic_failover = true

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }
  
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  enable_free_tier = true
  
  geo_location {
    location          = var.rg.location
    failover_priority = 0
  }

  capacity {
    total_throughput_limit = 100
  }
}

output "connection_strings" {
  sensitive = true
  value = azurerm_cosmosdb_account.account.connection_strings
}
