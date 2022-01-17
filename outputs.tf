output "project_number" {
  description = "Project number to use in GitHub secrets"
  value = data.google_project.project.number
}
output "project_id" {
  description = "Project ID to use in GitHub secrets"
  value = var.project_id
}
output "service_account" {
  description = "Service account to use in GitHub secrets"
  value = var.service_account
}