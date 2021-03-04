locals {
  ## TODO: Implement validations
  ## Read and decode json files
  values_files = { for v in var.values_path : v => jsondecode(file(v)) }
  secret_files = { for f in data.sops_file.secrets : f.source_file => jsondecode(f.raw) }

  ## Merges secrets into values files
  vars = {
    for k, v in local.values_files :
    v.workspace => merge(
      v, {
        "secrets"     = try(local.secret_files[replace(k, "values", "secrets.enc")]["secrets"], {})
        "env_secrets" = try(local.secret_files[replace(k, "values", "secrets.enc")]["env_secrets"], {})
    })
  }

  ## Transform maps of maps into a list of maps for plain text variables
  workspace_variables = flatten([
    for ws_name, ws in local.vars : [
      for var_name, value in ws.variables : {
        workspace = ws_name
        variable  = var_name
        value     = value
        sensitive = false
        category  = "terraform"

      }
    ]
  ])

  ## Transform maps of maps into a list of maps for plain env variables
  workspace_env = flatten([
    for ws_name, ws in local.vars : [
      for var_name, value in ws.env : {
        workspace = ws_name
        variable  = var_name
        value     = value
        sensitive = false
        category  = "env"
      }
    ]
  ])

  ## Transform maps of maps into a list of maps for secret variables
  workspace_secrets = flatten([
    for ws_name, ws in local.vars : [
      for var_name, value in ws.secrets : {
        workspace = ws_name
        variable  = var_name
        value     = value
        sensitive = true
        category  = "terraform"

      }
    ]
  ])

  ## Transform maps of maps into a list of maps for secret env variables
  workspace_env_secrets = flatten([
    for ws_name, ws in local.vars : [
      for var_name, value in ws.env_secrets : {
        workspace = ws_name
        variable  = var_name
        value     = value
        sensitive = true
        category  = "env"
      }
    ]
  ])

  ## Build Unique list of maps with all variable types (values, secrets, envs and secret envs)
  workspace_vars = concat(local.workspace_variables, local.workspace_secrets, local.workspace_env, local.workspace_env_secrets)
}
