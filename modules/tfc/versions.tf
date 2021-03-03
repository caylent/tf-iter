# -------------------------------------------------------------
# Terraform providers
# -------------------------------------------------------------

terraform {
  required_version = ">= 0.14"
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = ">= 0.5"
    }
    tfe = {
      version = ">= 0.24.0"
    }
  }
}
