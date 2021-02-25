
# --------------------------------------------------------------------
# Terraform Cloud resources
# --------------------------------------------------------------------

## Creates TF workspaces
resource "tfe_workspace" "workspace" {
  for_each              = length(local.vars) > 0 ? local.vars : {}
  name                  = each.key
  organization          = var.terraform_organization_name
  terraform_version     = var.terraform_version
  file_triggers_enabled = false
  queue_all_runs        = false
  allow_destroy_plan    = false
  auto_apply            = false
  execution_mode        = "remote"
  speculative_enabled   = false
}

## Creates TFC variables
resource "tfe_variable" "variable" {
  for_each     = length(local.values_files) > 0 ? { for w in local.workspace_vars : "${w.workspace}.${w.variable}" => w } : {}
  key          = each.value.variable
  value        = each.value.value
  category     = "terraform"
  workspace_id = tfe_workspace.workspace[each.value.workspace].id
  sensitive    = each.value.sensitive
}
