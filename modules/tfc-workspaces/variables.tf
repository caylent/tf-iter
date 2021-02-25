# --------------------------------------------------------------------
# Terraform cloud variables
# --------------------------------------------------------------------

variable "terraform_organization_name" {
  description = "The name of the terraform organization"
  type        = string
}

variable "terraform_version" {
  description = "The terraform version used for remote execution"
  type        = string
  default     = "0.14.5"
}

variable "values_path" {
  description = "List of the values' path"
  type        = set(string)
}

variable "secrets_path" {
  description = "List of the secrets' path"
  type        = set(string)
}
