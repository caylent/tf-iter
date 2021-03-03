# --------------------------------------------------------------------
# Terraform Cloud resources
# --------------------------------------------------------------------

## Creates TFC organization
resource "tfe_organization" "org" {
  count                    = var.create_organization ? 1 : 0
  collaborator_auth_policy = var.collaborator_auth_policy
  cost_estimation_enabled  = var.cost_estimation_enabled
  email                    = var.organization_email
  name                     = var.organization_name
  session_remember_minutes = var.session_remember_minutes
  session_timeout_minutes  = var.session_timeout_minutes
}

## Creates TFC workspaces
resource "tfe_workspace" "workspace" {
  for_each              = length(local.vars) > 0 ? local.vars : {}
  name                  = each.key
  organization          = var.organization_name
  terraform_version     = var.terraform_version
  file_triggers_enabled = var.file_triggers_enabled
  queue_all_runs        = var.queue_all_runs
  allow_destroy_plan    = var.allow_destroy_plan
  auto_apply            = var.auto_apply
  execution_mode        = var.execution_mode
  speculative_enabled   = var.speculative_enabled
  ssh_key_id            = var.ssh_key_id
  trigger_prefixes      = var.trigger_prefixes

  ## NOTE: As we have a 1-1 relationship between repos and workspaces
  ## We return build a custom/hacky map {"true" = "true"}, just for
  ## enabling the vcs_repo block in case enable_vcs = true
  dynamic "vcs_repo" {
    for_each = var.enable_vcs ? { "true" = "true" } : {}

    content {
      branch             = each.value.branch
      identifier         = var.vcs_repo_identifier
      ingress_submodules = var.vcs_repo_ingress_submodules
      oauth_token_id     = var.vcs_repo_oauth_token_id
    }
  }
}

## Creates TFC variables
resource "tfe_variable" "variable" {
  for_each     = length(local.values_files) > 0 ? { for w in local.workspace_vars : "${w.workspace}.${w.variable}" => w } : {}
  key          = each.value.variable
  value        = each.value.value
  category     = var.variable_category
  workspace_id = tfe_workspace.workspace[each.value.workspace].id
  sensitive    = each.value.sensitive
}
