# --------------------------------------------------------------------
# Terraform Cloud module instantiations
# --------------------------------------------------------------------

module "tf_workspaces" {
  source = "./modules/tfc"

  ## Organization settings
  create_organization = false
  organization_email  = "maashimine@gmail.com"
  organization_name   = "mashimine"

  ## Workspace settings
  enable_vcs              = false
  speculative_enabled     = false
  terraform_version       = "0.14.5"
  vcs_repo_identifier     = "caylent/tf-iter"
  vcs_repo_oauth_token_id = "ot-586fGR8JftqkPV2z"
  # ssh_key_id              = "sshkey-YUJzzWhJWWPc7V4J"

  ## Variables settings
  values_path  = fileset(path.module, "./clients/**/values.json")
  secrets_path = fileset(path.module, "./clients/**/secrets.enc.json")
}
