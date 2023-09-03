output "ip" {
    value = digitalocean_droplet.rocketchat_droplet.ipv4_address
}
output "name" {
    value = digitalocean_droplet.rocketchat_droplet.name
}
output "size" {
    value = digitalocean_droplet.rocketchat_droplet.size
}