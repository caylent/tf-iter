Terraform cloud
================

Terraform module for creating terraform cloud workspaces, variables and organizations                                                                  
These types of resources are supported:
                                                                    
- [Terraform Cloud](https://www.terraform.io/cloud)

## Summary

Terraform cloud module will allow you to create organizations, multiple workspaces, and variables. 

For secret management easiness we decided to go full `GitOps` and have all of our secrets encrypted used the `sops` provider. Secrets and variables have been defined in values.json and secrets.enc.json files respectivily by client. Behind the scenes those files are going to be decrypted, decoded and read by the module dynamically, giving us the flexibility
of instancing different type of variable across multiple workspaces

## Sops provider

For secret managing we are using the terraform sops provider. [Sops](https://github.com/mozilla/sops) will allow you to encrypt/decrypt your sensitive data using an GPG/KMS(AWS/GCP/Azure/Hashicorp keys.

The `.sops.yaml` file reflects which `AWS KMS` key is going to be used for encrypting/decrypting your secrets as you can see in the following lines

```yaml
creation_rules:
  - path_regex: clients/
    kms: arn:aws:kms:<aws-region>:<aws-account-id>:key/<kms-key-arn>
```

#### Encrypting a file

```shell
$ sops -e file-to-encrypt > clients/client-name/secrets.enc.json 
```

#### Decrypting a file

```shell
$ sops -d clients/client-name/secrets.enc.json
```

## Clients directory

The `client` directory structure reflects how `values` and `secrets` are split between clients. Each client directory contains their own `values.json` and `secrets.enc.json` file. 
For client naming convention, you can use the naming pattern you want, but for files it is mandatory that they follow the naming convention stablished above. \

We also should have at least a `values.json` file at least in each directory

```shell
.
├── client-1
│   ├── secrets.enc.json
│   └── values.json
└── client-2
    └── values.json

2 directories, 3 files
```

## Values and secrets json structure

Whenever you want to instance a new `workspace` your `values.json` and `secrets.enc.json` files **MUST** stick to following json bodies format:

#### **values.json**

```json
{
  "workspace": "",
  "branch": "",
  "description": "",
  "variables": {},
  "env": {}
}
```
- `workspace` is a string type that defines the workspace's name
- `branch` is a string type that defines the branch that is going to be set in the workspace for the vcs repo
- `description` is a string type that defines a brief description about the workspace
- `variables` is an object type where you can define the `terraform variables` you need for you brand new workspace
- `env` is an object type where you can define the `environment variables` you need for your brand new workspace

#### **secrets.enc.json**

```json
{
  "secrets": {},
  "env_secrets": {}
}
```
- `secrets` is an object type where you can define the `terraform secret variables` you need for you brand new workspace
- `env` is an object type where you can define the `environment secret variables` you need for your brand new workspace

**NOTE:** Secret variables are sensitive, therefore they are not going to be displayed during the terraform plan/output or shown in the terraform cloud UI

## Instantiation example

```hcl

module "tfc" {
  source = "./modules/tfc"

  ## Organization settings
  create_organization = true
  organization_email  = "organization@mail.com"
  organization_name   = "foo"

  ## Workspace settings
  enable_vcs              = false
  speculative_enabled     = false
  terraform_version       = "0.14.5"
  vcs_repo_identifier     = "organization/repo"
  vcs_repo_oauth_token_id = "your_oauth_token_id"
  ssh_key_id              = "youur_ssh_key_id"

  ## Variables settings
  values_path  = fileset(path.module, "./clients/**/values.json")
  secrets_path = fileset(path.module, "./clients/**/secrets.enc.json")
}

```

## Module requirements

| Name      | Version   |
| --------- | --------- |
| terraform | >= 0.14   |
| sops      | >= 0.5    |
| tfe       | >= 0.24.0 |

## Providers

| Name | Version   |
| ---- | --------- |
| sops | >= 0.5    |
| tfe  | >= 0.24.0 |

## Inputs

| Name                        | Description                                                                                                                                                                                                                                          | Type           | Default      | Required |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------------ | :------: |
| allow_destroy_plan          | Whether destroy plans can be queued on the workspace.                                                                                                                                                                                                | `bool`         | `false`      |    no    |
| auto_apply                  | Whether to automatically apply changes when a Terraform plan is successful                                                                                                                                                                           | `bool`         | `false`      |    no    |
| collaborator_auth_policy    | Authentication policy (password or two_factor_mandatory)                                                                                                                                                                                             | `string`       | `"password"` |    no    |
| cost_estimation_enabled     | Whether or not the cost estimation feature is enabled for all workspaces in the organization                                                                                                                                                         | `bool`         | `true`       |    no    |
| create_organization         | Wheater to create an organization or not                                                                                                                                                                                                             | `bool`         | n/a          |   yes    |
| enable_vcs                  | Enable VCS support on the workspace. Omit this argument to utilize the CLI-driven and API-driven workflows, where runs are not driven by webhooks on your VCS provider                                                                               | `bool`         | n/a          |   yes    |
| execution_mode              | Which execution mode to use. Using Terraform Cloud, valid values are remote, local or agent                                                                                                                                                          | `string`       | `"remote"`   |    no    |
| file_triggers_enabled       | Whether to filter runs based on the changed files in a VCS push. If enabled, the working directory and trigger prefixes describe a set of paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run | `bool`         | `false`      |    no    |
| organization_email          | Admin email address                                                                                                                                                                                                                                  | `string`       | n/a          |   yes    |
| organization_name           | Name of the organization                                                                                                                                                                                                                             | `string`       | n/a          |   yes    |
| queue_all_runs              | Whether all runs should be queued. When set to false, runs triggered by a VCS change will not be queued until at least one run is manually queued                                                                                                    | `bool`         | `false`      |    no    |
| secrets_path                | List of the secrets' path                                                                                                                                                                                                                            | `set(string)`  | n/a          |   yes    |
| session_remember_minutes    | Session expiration                                                                                                                                                                                                                                   | `number`       | `0`          |    no    |
| session_timeout_minutes     | Session timeout after inactivity                                                                                                                                                                                                                     | `number`       | `0`          |    no    |
| speculative_enabled         | Whether this workspace allows speculative plans. Setting this to false prevents Terraform Cloud or the Terraform Enterprise instance from running plans on pull requests                                                                             | `bool`         | `true`       |    no    |
| ssh_key_id                  | The ID of an SSH key to assign to the workspace                                                                                                                                                                                                      | `string`       | `null`       |    no    |
| terraform_version           | The terraform version used for remote execution                                                                                                                                                                                                      | `string`       | n/a          |   yes    |
| trigger_prefixes            | List of repository-root-relative paths which describe all locations to be tracked for changes                                                                                                                                                        | `list(string)` | `[]`         |    no    |
| values_path                 | List of the values' path                                                                                                                                                                                                                             | `set(string)`  | n/a          |   yes    |
| vcs_repo_identifier         | A reference to your VCS repository in the format <organization>/<repository> where <organization> and <repository> refer to the organization and repository in your VCS provider.                                                                    | `string`       | `null`       |    no    |
| vcs_repo_ingress_submodules | Whether submodules should be fetched when cloning the VCS repository                                                                                                                                                                                 | `bool`         | `false`      |    no    |
| vcs_repo_oauth_token_id     | The VCS Connection (OAuth Connection + Token) to use. This ID can be obtained from a tfe_oauth_client resource                                                                                                                                       | `string`       | `null`       |    no    |

## Outputs

No output.


Authors
-------
Module created by Caylent
