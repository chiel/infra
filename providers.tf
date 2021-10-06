provider "digitalocean" {
  spaces_access_id  = var.SPACES_ACCESS_ID
  spaces_secret_key = var.SPACES_SECRET_KEY
}

provider "github" {
  token = var.GITHUB_TOKEN
}
