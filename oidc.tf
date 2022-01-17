#Retrieve information about current GCP project
data "google_project" "project" {}

#Enable services required
resource "google_project_service" "project" {
  for_each = toset(var.gcp_apis)
  service  = each.key
}

#Service Account for GitHub OIDC
resource "google_service_account" "pipeline_account" {
  account_id   = var.service_account
  display_name = var.service_account
  description  = "Pipeline account for GitHub OIDC"
}
#Give owner permissions to service account
resource "google_project_iam_member" "project" {
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.pipeline_account.email}"
}

#Create OIDC Config for GCP login from GitHub
module "gh_oidc" {
  depends_on = [
    google_service_account.pipeline_account
  ]
  source                = "terraform-google-modules/github-actions-runners/google//modules/gh-oidc"
  project_id            = var.project_id
  pool_id               = "github-action-pool"
  pool_display_name     = "Identitiy Pool for GitHub"
  pool_description      = "Identitiy Pool for GitHub"
  provider_id           = "github-action-pool-provider"
  provider_display_name = "ID Provider for GitHub"
  provider_description  = "ID Provider for GitHub"
  sa_mapping = {
    (google_service_account.pipeline_account.account_id) = {
      sa_name   = google_service_account.pipeline_account.name
      attribute = "attribute.repository/${var.organization}/${var.repository_name}"
    }
  }
}