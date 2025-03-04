terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = var.tf-organization
    
    workspaces {
      name = var.tf-workspace
    }
  }
}

resource "azurerm_resource_group" "life-blood-rg" {
  name                = var.resource_group_name
  location            = var.location
}


module "aks" {
  source              = "../../modules/kubernetes"
  cluster_name        = "life-blood-aks"
  location            = azurerm_resource_group.life-blood-rg.location
  resource_group_name = azurerm_resource_group.life-blood-rg.name
  dns_prefix          = "life-blood-prod"  
  min_node_count      = 1
  max_node_count      = 3
  vm_size             = "Standard_D2s_v3"
}

module "networking" {
  source              = "../../modules/networking"
  vnet_name           = "lb-prod-vnet"
  location            = azurerm_resource_group.life-blood-rg.location
  resource_group_name = azurerm_resource_group.life-blood-rg.name
  subnet_name         = "lb-prod-subnet"
}