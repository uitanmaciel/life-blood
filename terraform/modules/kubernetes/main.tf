resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"    
    auto_scaling_enabled = true
    min_count = var.min_node_count
    max_count = var.max_node_count
    vm_size    = var.vm_size
  }

  identity {
    type = "SystemAssigned"
  }
}
