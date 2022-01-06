# Terraform configuration

The included terraform configuration will create:
1. A Resource Group in Azure
2. An AKS Cluster in Azure

It requires:
1. An Azure Subscription
1. An SPN configured in that Subscription
1. Those SPN credentials to be supplied in the `terraform.tfvars` file included here in these fields
- appId
- password

You may also choose to use Terraform Cloud to manage your IaC. In that case you will need to configure variables in your Terraform Cloud workspace for all variables found in `terraform.tfvars`