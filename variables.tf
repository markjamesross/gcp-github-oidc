variable "organization" {
  description = "Name of the GitHub Organization."
  type        = string
}
variable "repository_name" {
  description = "Name of the GitHub Repository."
  type        = string
}
variable "project_id" {
  description = "Project to deploy to"
  type        = string
}
variable "gcp_apis" {
  default = ["iamcredentials.googleapis.com"]
}
variable "service_account" {
  description = "Name of service account"
  type        = string
  default     = "github-action-account"
}