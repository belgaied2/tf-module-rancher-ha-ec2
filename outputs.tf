# output "app_cluster_docker_bootstrap" {
#     value = module.app_cluster.app_cluster_docker_bootstrap
# }


output "rancher_token" {
  description = "Generated API Token after Rancher Bootstrapping"
  value = rancher2_bootstrap.admin.token
}