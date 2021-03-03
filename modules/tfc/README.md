Terraform cloud
=================

## Usage example 

## Requirements

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

| Name                        | Description                                                                                                                                                                                                                                          | Type           | Default       | Required |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------------- | :------: |
| allow_destroy_plan          | Whether destroy plans can be queued on the workspace.                                                                                                                                                                                                | `bool`         | `false`       |    no    |
| auto_apply                  | Whether to automatically apply changes when a Terraform plan is successful                                                                                                                                                                           | `bool`         | `false`       |    no    |
| collaborator_auth_policy    | Authentication policy (password or two_factor_mandatory)                                                                                                                                                                                             | `string`       | `"password"`  |    no    |
| cost_estimation_enabled     | Whether or not the cost estimation feature is enabled for all workspaces in the organization                                                                                                                                                         | `bool`         | `true`        |    no    |
| create_organization         | Wheater to create an organization or not                                                                                                                                                                                                             | `bool`         | n/a           |   yes    |
| enable_vcs                  | Enable VCS support on the workspace. Omit this argument to utilize the CLI-driven and API-driven workflows, where runs are not driven by webhooks on your VCS provider                                                                               | `bool`         | n/a           |   yes    |
| execution_mode              | Which execution mode to use. Using Terraform Cloud, valid values are remote, local or agent                                                                                                                                                          | `string`       | `"remote"`    |    no    |
| file_triggers_enabled       | Whether to filter runs based on the changed files in a VCS push. If enabled, the working directory and trigger prefixes describe a set of paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run | `bool`         | `false`       |    no    |
| organization_email          | Admin email address                                                                                                                                                                                                                                  | `string`       | n/a           |   yes    |
| organization_name           | Name of the organization                                                                                                                                                                                                                             | `string`       | n/a           |   yes    |
| queue_all_runs              | Whether all runs should be queued. When set to false, runs triggered by a VCS change will not be queued until at least one run is manually queued                                                                                                    | `bool`         | `false`       |    no    |
| secrets_path                | List of the secrets' path                                                                                                                                                                                                                            | `set(string)`  | n/a           |   yes    |
| session_remember_minutes    | Session expiration                                                                                                                                                                                                                                   | `number`       | `0`           |    no    |
| session_timeout_minutes     | Session timeout after inactivity                                                                                                                                                                                                                     | `number`       | `0`           |    no    |
| speculative_enabled         | Whether this workspace allows speculative plans. Setting this to false prevents Terraform Cloud or the Terraform Enterprise instance from running plans on pull requests                                                                             | `bool`         | `true`        |    no    |
| ssh_key_id                  | The ID of an SSH key to assign to the workspace                                                                                                                                                                                                      | `string`       | `null`        |    no    |
| terraform_version           | The terraform version used for remote execution                                                                                                                                                                                                      | `string`       | n/a           |   yes    |
| trigger_prefixes            | List of repository-root-relative paths which describe all locations to be tracked for changes                                                                                                                                                        | `list(string)` | `[]`          |    no    |
| values_path                 | List of the values' path                                                                                                                                                                                                                             | `set(string)`  | n/a           |   yes    |
| variable_category           | Whether this is a Terraform or environment variable. Valid values are terraform or env                                                                                                                                                               | `string`       | `"terraform"` |    no    |
| vcs_repo_identifier         | A reference to your VCS repository in the format <organization>/<repository> where <organization> and <repository> refer to the organization and repository in your VCS provider.                                                                    | `string`       | `null`        |    no    |
| vcs_repo_ingress_submodules | Whether submodules should be fetched when cloning the VCS repository                                                                                                                                                                                 | `bool`         | `false`       |    no    |
| vcs_repo_oauth_token_id     | The VCS Connection (OAuth Connection + Token) to use. This ID can be obtained from a tfe_oauth_client resource                                                                                                                                       | `string`       | `null`        |    no    |

## Outputs

No output.

