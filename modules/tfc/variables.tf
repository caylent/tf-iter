# --------------------------------------------------------------------
# Terraform cloud organization variables
# --------------------------------------------------------------------

variable "create_organization" {
  description = "Wheater to create an organization or not"
  type        = bool
}

variable "collaborator_auth_policy" {
  description = "Authentication policy (password or two_factor_mandatory)"
  type        = string
  default     = "password"
}
variable "cost_estimation_enabled" {
  description = "Whether or not the cost estimation feature is enabled for all workspaces in the organization"
  type        = bool
  default     = true
}
variable "organization_email" {
  description = "Admin email address"
  type        = string
}

variable "organization_name" {
  description = "Name of the organization"
  type        = string
}

variable "session_remember_minutes" {
  description = "Session expiration"
  type        = number
  default     = 0
}
variable "session_timeout_minutes" {
  description = "Session timeout after inactivity"
  type        = number
  default     = 0
}

# --------------------------------------------------------------------
# Terraform cloud vars variables
# --------------------------------------------------------------------

variable "values_path" {
  description = "List of the values' path"
  type        = set(string)
}

variable "secrets_path" {
  description = "List of the secrets' path"
  type        = set(string)
}

# --------------------------------------------------------------------
# Terraform cloud workspaces variables
# --------------------------------------------------------------------

variable "terraform_version" {
  description = "The terraform version used for remote execution"
  type        = string
}

variable "enable_vcs" {
  description = "Enable VCS support on the workspace. Omit this argument to utilize the CLI-driven and API-driven workflows, where runs are not driven by webhooks on your VCS provider"
  type        = bool
}
variable "file_triggers_enabled" {
  description = "Whether to filter runs based on the changed files in a VCS push. If enabled, the working directory and trigger prefixes describe a set of paths which must contain changes for a VCS push to trigger a run. If disabled, any push will trigger a run"
  type        = bool
  default     = false
}
variable "queue_all_runs" {
  description = "Whether all runs should be queued. When set to false, runs triggered by a VCS change will not be queued until at least one run is manually queued"
  type        = bool
  default     = false
}
variable "allow_destroy_plan" {
  description = "Whether destroy plans can be queued on the workspace."
  type        = bool
  default     = false
}
variable "auto_apply" {
  description = "Whether to automatically apply changes when a Terraform plan is successful"
  type        = bool
  default     = false
}
variable "execution_mode" {
  description = "Which execution mode to use. Using Terraform Cloud, valid values are remote, local or agent"
  type        = string
  default     = "remote"
}
variable "speculative_enabled" {
  description = "Whether this workspace allows speculative plans. Setting this to false prevents Terraform Cloud or the Terraform Enterprise instance from running plans on pull requests"
  type        = bool
  default     = true
}
variable "ssh_key_id" {
  description = "The ID of an SSH key to assign to the workspace"
  type        = string
  default     = null
}
variable "trigger_prefixes" {
  description = "List of repository-root-relative paths which describe all locations to be tracked for changes"
  type        = list(string)
  default     = []
}

variable "vcs_repo_identifier" {
  description = "A reference to your VCS repository in the format <organization>/<repository> where <organization> and <repository> refer to the organization and repository in your VCS provider."
  type        = string
  default     = null
}

variable "vcs_repo_ingress_submodules" {
  description = "Whether submodules should be fetched when cloning the VCS repository"
  type        = bool
  default     = false
}

variable "vcs_repo_oauth_token_id" {
  description = "The VCS Connection (OAuth Connection + Token) to use. This ID can be obtained from a tfe_oauth_client resource"
  type        = string
  default     = null
}
