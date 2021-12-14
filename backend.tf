terraform {
  backend "s3" {
    # access_key and secret_key need to
    # be provided to `terraform init`
    bucket   = "kunkels"
    key      = "tfstate/terraform.tfstate"
    endpoint = "https://ams3.digitaloceanspaces.com"
    region   = "eu-west-1"

    skip_credentials_validation = true
  }
}

resource "digitalocean_spaces_bucket" "kunkels" {
  name   = "kunkels"
  region = "ams3"
  acl    = "private"
}
