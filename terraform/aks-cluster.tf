provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

}

resource "azurerm_resource_group" "default" {
  name     = var.rg
  location = "Central US"

  tags = {
    Environment = "POC"
  }

}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.aks-cluster
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = var.dns-prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    Environment = "POC"
  }

}