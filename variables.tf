variable "aws_access_key" {
    description = "Access key for AWS account"
    default = ""
}

variable "aws_secret_key" {
    description = "Secret key for AWS account"
    default = ""
}

variable "aws_region" {
    description = "Region for the AWS Account"
    default = "eu-central-1"
}

variable "route53_zone" {
    description = "Domain name and hosted zone in Route53"
}

variable "route53_name" {
    description = "Hostname prefix used for Rancher Server"
    default = "mbh"
}

variable "github_access_key" {
    description = "Access key for the main user from Github"
    default = ""
}

variable "github_secret_key" {
    description = "Access Secret Key for the main user from Github"
    default = "" 
}

variable "rancher_bootstrap_password" {
    description = "Rancher's bootstrap password"
}

variable "sg_name" {
  description = "Name of the security group for the App Cluster nodes on AWS"
  default     = "rke-default-security-group"
}

variable "rancher_version" {
  description = "Version of Rancher Server to deploy"
  default     = "v2.4.5"
}

variable "kubernetes_version" {
  description = "K8s version for RKE"
  default     = "v1.17.5-rancher1-1"
}

variable "cloud_provider_role" {
  description = "IAM Role to attach to EC2 instances to enable cloud_provider"
  default     = ""
}


