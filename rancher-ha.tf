locals {
  name               = "rancher-ha"
  kubernetes_version = var.kubernetes_version
  rancher_hostname = "${var.route53_name}.${var.route53_zone}"
}

# Rancher infra
module "rancher_infra" {
  source = "github.com/rawmind0/tf-module-rancher-infra-aws"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  aws_region = var.aws_region
  prefix = local.name
  node_all_count = 3
  route53_zone = var.route53_zone
  route53_name = var.route53_name
  instance_type = "t3a.large"
  deploy_lb = true
  ssh_key_file = "~/.ssh/MacOSsKey.pem"
  ssh_pub_file = "~/.ssh/MacOSsKey.pub"
}
# RKE cluster
module "rke_cluster" {
  source = "github.com/rawmind0/tf-module-rke-cluster"
  rke_nodes = module.rancher_infra.rancher_nodes
  rke = {
    cluster_name = local.name
    kubernetes_version = local.kubernetes_version
  }
}

# Rancher server
module "rancher_server" {
  source = "github.com/rawmind0/tf-module-rancher-server"
  rancher_hostname = local.rancher_hostname
  rancher_k8s = {
    host = module.rke_cluster.kubeconfig_api_server_url
    client_certificate     = module.rke_cluster.kubeconfig_client_cert
    client_key             = module.rke_cluster.kubeconfig_client_key
    cluster_ca_certificate = module.rke_cluster.kubeconfig_ca_crt
  }
  rancher_server = {
    ns = "cattle-system"
    version = var.rancher_version
    branch = "stable"
    chart_set = [
    {
        name = "ingress.tls.source"
        value = "letsEncrypt"
    },
    {
        name = "letsEncrypt.email"
        value = "mohamed@belgaied-hassine.com"
    }
  ]
  }
}
