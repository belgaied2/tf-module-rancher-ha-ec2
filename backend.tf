terraform {
  backend "s3" {
    bucket = "rancher-mhassine-rampup"
    key    = "tf-rancher-ha-with-modules-3.tfstate"
    region = "eu-central-1"
  }
}