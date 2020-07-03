module "app_cluster" {
    source = "github.com/belgaied2/tf-rancher-app-cluster"
    node_count = 3
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    api_url = rancher2_bootstrap.admin.url
    token_key = rancher2_bootstrap.admin.token
    security_group_name = var.sg_name
    key_name = "MacOSsKey"
    cloud_provider_role = var.cloud_provider_role
}