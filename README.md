# terraform-rocketchat

A simple project that sets up a RocketChat chat server on Digital Ocean and CloudFlare.

# Prerequisites
- Terraform v1.5.3

# Setup
All settings are set in `variables.tf`. You can either set them when deploying, or add
your own `terraform.tfvars` file and deploy. To setup:

1. Clone the repository
2. `cd` into the repository and run `terraform apply`
3. If you have no created a `terraform.tfvars` you will be prompted for all of the parameters. This includes your Digital Ocean and CloudFlare keys along with configuration details for your deployment

# Settings
The settings in the `variables.tf` are as follows:
| Variable | Description |
| -------- | ----------- |
| do_token | Your digital ocean API Token |
| cf_token | Your CloudFlare API Token. Ensure this token has permissions to both read and set DNS records |
| cf_email | Your CloudFlare authentication email |
| cf_domain | The root domain in CloudFlare that this RocketChat server will be hosted under |
| cf_sub_domain | The sub domain in CloudFlare that this RocketChat server will be hoested under. By default the DNS value of "chat.<your domain>" will be pointed at the Digital Ocean server. You can change the `chat` value with this parameter |
| 