provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.0.0"
  features {}
}

variable "locations" {
  type = map

  default = {
    "1" = "eastus"
    "2" = "westus"
  }
}


resource "azurerm_resource_group" "rg" {
  count = length(var.locations)
  name     = "my-test-candidate-${lookup(var.locations, count.index+1)}"
  location = lookup(var.locations, count.index+1)
}
