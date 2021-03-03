# -------------------------------------------------------------
# Data sources
# -------------------------------------------------------------

## Data source for decrypting secrets
data "sops_file" "secrets" {
  for_each    = var.secrets_path
  source_file = each.value
}
