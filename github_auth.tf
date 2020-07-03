
resource "null_resource" "rancher_availability_check" {

  provisioner "local-exec" {
    command = "while ! [[ $(curl -I -L ${module.rancher_server.rancher_server_url} 2>/dev/null | head -n 1 | cut -d$' ' -f2) -eq 200 ]] ; do sleep 30; echo 'Waiting for another 30s'; done"
  }
}

provider "rancher2" {
  alias = "bootstrap"
  version = "1.8.3"
  api_url    = module.rancher_server.rancher_server_url
  bootstrap = true
  
}

resource "rancher2_bootstrap" "admin"{
  provider = rancher2.bootstrap
  password = var.rancher_bootstrap_password
#    current_password = var.rancher_bootstrap_password
  depends_on = [null_resource.rancher_availability_check]
}

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

# data "rancher2_user" "belgaied" {
#   is_external = true
#   name = "Mohamed Belgaied Hassine" 
#   depends_on = ["rancher2_auth_config_github.github"]
# }



# resource "rancher2_global_role_binding" "admin-user" {
#   name = "admin-role-bind"
#   global_role_id = "admin"
#   group_principal_id =  "github_org://rancher"
# }






