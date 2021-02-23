variable "config" {
  description = ""
  type = object({
    name = string
    region = string
    some_secret = string
    special_secret = string
    db_username = string
    db_password = string
  })
  sensitive = true
  validation {
    condition = alltrue([for item in var.config : item != ""])
    error_message = "Some values are empty."
  }
}

locals {
  prefix  = "blah"
  postfix = "meh"
}

resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "echo ${var.config.name}"
  }
}

# resource "tfe_workspace" "test" {
#   name          = "${local.prefix}-${var.config.name}-${local.postfix}"
#   organization  = "Example Org"
# }

# module "workspaces" {
#   // Module that creates all the workspaces etc
# }