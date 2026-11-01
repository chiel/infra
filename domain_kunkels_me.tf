resource "digitalocean_domain" "kunkels_me" {
  name = "kunkels.me"
}

# name servers
resource "digitalocean_record" "kunkels_me_ns" {
  for_each = toset(["1", "2", "3"])

  domain = digitalocean_domain.kunkels_me.id
  type   = "NS"
  name   = "@"
  ttl    = 1800
  value  = "ns${each.value}.digitalocean.com."
}

# mx records
resource "digitalocean_record" "kunkels_me_mx" {
  for_each = {
    "eu1-smtp.messagingengine.com." = 10
    "eu2-smtp.messagingengine.com." = 20
  }

  domain   = digitalocean_domain.kunkels_me.id
  type     = "MX"
  name     = "@"
  priority = each.value
  ttl      = 1800
  value    = each.key
}

# dkim records
resource "digitalocean_record" "kunkels_me_dkim" {
  for_each = {
    "fm1._domainkey" = "fm1.kunkels.me.dkim.fmhosted.com."
    "fm2._domainkey" = "fm2.kunkels.me.dkim.fmhosted.com."
    "fm3._domainkey" = "fm3.kunkels.me.dkim.fmhosted.com."
  }

  domain = digitalocean_domain.kunkels_me.id
  type   = "CNAME"
  name   = each.key
  ttl    = 1800
  value  = each.value
}

# txt records
resource "digitalocean_record" "kunkels_me_txt" {
  domain = digitalocean_domain.kunkels_me.id
  type   = "TXT"
  name   = "@"
  ttl    = 1800
  value  = "v=spf1 include:spf.messagingengine.com ?all"
}
