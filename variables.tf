
variable "do_token" {
    description = "Digital Ocean API Auth Token"
    sensitive = true
    type = string
}

variable "cf_token" {
    description = "CloudFlare API Auth Token"
    sensitive = true
    type = string
}

variable "cf_email" {
    description = "CloudFlare Email Account"
    sensitive = true
    type = string
}

variable "cf_domain" {
    description = "The domain host the chat is hosted on"
    sensitive = false
    type = string
}

variable "cf_sub_domain" {
    description = "Sub domain under the cf_domain to host rocketchat. If not supplied, 'chat' will be used"
    default = "chat"
}