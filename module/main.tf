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
  # sensitive = true
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