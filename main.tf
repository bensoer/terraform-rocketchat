terraform {
    required_providers {
      digitalocean = {
          source = "digitalocean/digitalocean"
      }
      cloudflare = {
          source = "cloudflare/cloudflare"
          version = "~> 2.0"
      }
    }
}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
    email = var.cf_email
    api_token = var.cf_token
}

resource "digitalocean_ssh_key" "rocketchat_ssh_key"{
    name = "rocketchat_ssh_key"
    public_key = file(abspath("./res/id_rsa.pub"))
}

resource "digitalocean_droplet" "rocketchat_droplet" {
    image = "rocketchat-20-04"
    name = "rocketchat"
    region = "sfo3"
    size = "s-1vcpu-2gb"
    backups = false
    monitoring = true
    ssh_keys = [digitalocean_ssh_key.rocketchat_ssh_key.fingerprint]
}

resource "digitalocean_project" "rocketchat_project" {
    name = "${var.cf_sub_domain}.${var.cf_domain}"
    description = "DO Resources For RocketChat Server"
    purpose = "Resources"
    environment = "Production"
    resources = [
        digitalocean_droplet.rocketchat_droplet.urn
    ]
}


// DNS

data "cloudflare_zones" "rocketchat_domain_lookup" {
    filter {
        name = var.cf_domain
    }
}


resource "cloudflare_record" "rocketchat_domain_cname" {
    zone_id = lookup(data.cloudflare_zones.rocketchat_domain_lookup.zones[0], "id")
    name = "www.${var.cf_sub_domain}"
    type = "CNAME"
    value = "${var.cf_sub_domain}.${var.cf_domain}"
    proxied = false
}

resource "cloudflare_record" "rocketchat_domain_a" {
    zone_id = lookup(data.cloudflare_zones.rocketchat_domain_lookup.zones[0], "id")
    name = "${var.cf_sub_domain}"
    type = "A"
    value = digitalocean_droplet.rocketchat_droplet.ipv4_address
    proxied = false
}

