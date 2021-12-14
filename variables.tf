variable "DIGITALOCEAN_TOKEN" {
  description = "DigitalOcean token"
  type        = string
}

variable "EMAIL" {
  description = "My e-mail address"
  type        = string
}

variable "GITHUB_TOKEN" {
  description = "GitHub token"
  type        = string
}

variable "GRAFANA_PASSWORD" {
  description = "Grafana password"
  type        = string
}

variable "GRAFANA_USERNAME" {
  description = "Grafana username"
  type        = string
}

variable "POSTGRES_IP_WHITELIST" {
  description = "List of IP addresses that are allowed to access the postgres database"
  type        = list(string)
}

variable "SITE_GHCR_TOKEN" {
  description = "GHCR.io token for personal website"
  type        = string
}

variable "SITE_GHCR_USER" {
  description = "GHCR.io user for personal website"
  type        = string
}

variable "SPACES_ACCESS_ID" {
  description = "DigitalOcean Spaces access id"
  type        = string
}

variable "SPACES_SECRET_KEY" {
  description = "DigitalOcean Spaces secret key"
  type        = string
}
