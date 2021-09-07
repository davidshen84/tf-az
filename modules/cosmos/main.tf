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
  kind                = "GlobalDocumentDB"

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

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.rg.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "sqldb" {
  name                = var.sql_database_name
  resource_group_name = var.rg.name
  account_name        = azurerm_cosmosdb_account.name
  throughput          = 400
}
