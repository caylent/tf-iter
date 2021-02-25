# -------------------------------------------------------------
# Terraform state backend
# -------------------------------------------------------------
terraform {
  backend "remote" {
    organization = "mashimine"
    workspaces {
      name = "terraform-variables"
    }
  }
}
