terraform{
    backend "s3" {
        bucket = "rancher-mhassine-rampup"
        key = "tf-rancher-ha-with-modules.tfstate"
        region = "eu-central-1"
    }
}