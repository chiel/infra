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
    "aspmx.l.google.com."      = 1
    "alt1.aspmx.l.google.com." = 5
    "alt2.aspmx.l.google.com." = 5
    "alt3.aspmx.l.google.com." = 10
    "alt4.aspmx.l.google.com." = 10
  }

  domain   = digitalocean_domain.kunkels_me.id
  type     = "MX"
  name     = "@"
  priority = each.value
  ttl      = 1800
  value    = each.key
}

# txt records
resource "digitalocean_record" "kunkels_me_txt" {
  domain = digitalocean_domain.kunkels_me.id
  type   = "TXT"
  name   = "@"
  ttl    = 3600
  value  = "v=spf1 include:_spf.google.com ~all"
}
