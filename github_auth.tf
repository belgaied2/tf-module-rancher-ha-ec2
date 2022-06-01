
resource "null_resource" "rancher_availability_check" {

  provisioner "local-exec" {
    command = "while ! [[ $(curl -I -L ${module.rancher_server.rancher_server_url} 2>/dev/null | head -n 1 | cut -d$' ' -f2) -eq 200 ]] ; do sleep 30; echo 'Waiting for another 30s'; done"
  }
  depends_on = [module.rancher_server]
}

provider "rancher2" {
  alias     = "bootstrap"
  api_url   = module.rancher_server.rancher_server_url
  bootstrap = true

}

terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
      version = ">=1.15.1"
    }
  }
}



resource "rancher2_bootstrap" "admin" {
  provider = rancher2.bootstrap
  password = var.rancher_bootstrap_password
  #    current_password = var.rancher_bootstrap_password
  depends_on = [null_resource.rancher_availability_check]
}

# module "rancher2_github" {
#   source            = "github.com/belgaied2/tf-module-rancher-github"
#   github_access_key = var.github_access_key
#   github_secret_key = var.github_secret_key
#   github_token      = var.github_token
#   api_url           = rancher2_bootstrap.admin.url
#   api_token         = rancher2_bootstrap.admin.token
#   organization      = var.github_organization
#   admin_group_principal_id = {
#     is_team = true
#     name    = var.github_team
#   }
# }


# Provider config for admin
provider "rancher2" {
  api_url = rancher2_bootstrap.admin.url
  token_key = rancher2_bootstrap.admin.token
}

resource "rancher2_auth_config_github" "github" {
  client_id = var.github_access_key
  client_secret = var.github_secret_key
  access_mode = "unrestricted"
  allowed_principal_ids = ["github_org://rancher"]
}

data "rancher2_user" "belgaied" {
  is_external = true
  name = "Mohamed Belgaied Hassine" 
  depends_on = ["rancher2_auth_config_github.github"]
}



resource "rancher2_global_role_binding" "admin-user" {
  name = "admin-role-bind"
  global_role_id = "admin"
  group_principal_id =  "github_org://rancher"
}






