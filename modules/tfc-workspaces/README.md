Terraform cloud
========================

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

| Name                        | Description                                     | Type          | Default    | Required |
| --------------------------- | ----------------------------------------------- | ------------- | ---------- | :------: |
| secrets_path                | List of the secrets' path                       | `set(string)` | n/a        |   yes    |
| terraform_organization_name | The name of the terraform organization          | `string`      | n/a        |   yes    |
| terraform_version           | The terraform version used for remote execution | `string`      | `"0.14.5"` |    no    |
| values_path                 | List of the values' path                        | `set(string)` | n/a        |   yes    |

## Outputs

No output.
