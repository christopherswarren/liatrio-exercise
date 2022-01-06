provider "azurerm" {
  features {}
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
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    Environment = "POC"
  }

}