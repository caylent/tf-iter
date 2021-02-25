module "tf_workspaces" {
  source = "./modules/tfc-workspaces"

  terraform_organization_name = "mashimine"
  values_path                 = fileset(path.module, "./clients/**/values.json")
  secrets_path                = fileset(path.module, "./clients/**/secrets.enc.json")
}
