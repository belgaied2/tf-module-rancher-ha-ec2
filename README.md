# tf-rancher-ha-using-modules
A Rancher HA Deployment using modules from @rawmind's repo

This project uses the following modules:
- rancher_infra module (https://github.com/rawmind0/tf-module-rancher-infra-aws) : AWS Infrastructure to run a Management Cluster and Rancher HA
- rke_cluster (https://github.com/rawmind0/tf-module-rke-cluster) : RKE Kubernetes Cluster on top of the AWS Infrastructure
- rancher_server module (https://github.com/rawmind0/tf-module-rancher-server) : A Rancher HA Installation on top of the RKE Cluster
- app_cluster module (https://github.com/belgaied2/tf-rancher-app-cluster) : A Downstream Cluster Custom Deployment with its EC2 nodes




