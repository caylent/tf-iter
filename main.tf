terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      version = ">= 3.29.0"
      source = "hashicorp/aws"
    }
    # sops = {
    #   source = "carlpett/sops"
    #   version = "~> 0.5"
    # }
  }
}

locals {
  files = fileset(path.module, "clients/**/*json")
}

module "clients" {
  source = "./module/"

  for_each  = local.files
  config    = jsondecode(file(each.value))
}

output config {
  value = module.clients
}
