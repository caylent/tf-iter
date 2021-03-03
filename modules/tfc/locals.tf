locals {
  ## TODO: Implement validations
  values_files = { for v in var.values_path : v => jsondecode(file(v)) }
  secret_files = { for f in data.sops_file.secrets : f.source_file => jsondecode(f.raw) }

  vars = {
    for k, v in local.values_files :
    v.workspace => merge(
      v, {
        "secrets" = try(local.secret_files[replace(k, "values", "secrets.enc")], {})
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
      }
    ]
  ])

  workspace_vars = concat(local.workspace_variables, local.workspace_secrets)
}
