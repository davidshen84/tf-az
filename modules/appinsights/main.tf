variable "rg" {
  description = "resource group object"
}

variable "location" {
  description = "resource location"
}

variable "name" {
  description = "instance name"
}

resource "azurerm_application_insights" "instance" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg.name
  application_type    = "web"
}

resource "azurerm_monitor_action_group" "mag" {
  name                = "monitor-action"
  resource_group_name = var.rg.name
  short_name          = "mag"

  webhook_receiver {
    name        = "callmyapi"
    service_uri = "http://example.com/alert"
  }
}

resource "azurerm_monitor_metric_alert" "alert" {
  name                = "metric-alert"
  resource_group_name = var.rg.name
  scopes              = [azurerm_application_insights.instance.id]
  description         = "example desc."

  criteria {
    metric_namespace = "quantium.retail.export.runner"
    metric_name      = "MemoryUsage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 50000
    skip_metric_validation = true
  }

  action {
    action_group_id = azurerm_monitor_action_group.mag.id
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "query-alert" {
  name                = "query-alert"
  resource_group_name = var.rg.name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.mag.id]
  }

  data_source_id = azurerm_application_insights.instance.id
  description    = "Alert when total results cross threshold"
  enabled        = true

  # Count all requests with server error result code grouped into 5-minute bins
  query       = <<-QUERY
  requests
    | where tolong(resultCode) >= 500
    | summarize count() by bin(timestamp, 5m)
  QUERY

  severity    = 1
  frequency   = 5
  time_window = 30

  trigger {
    operator  = "GreaterThan"
    threshold = 3
  }
}

output "instrumentation_key" {
  value = azurerm_application_insights.instance.instrumentation_key
}
