# Terraform configuration

The included terraform configuration will create:
1. A Resource Group in Azure
2. An AKS Cluster in Azure

It requires:
1. An Azure Subscription
1. An SPN configured in that Subscription (follow [this guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret) for details)
1. Those SPN credentials to be supplied in the `terraform.tfvars` file included here in these fields
- appId (aka client_id)
- password (aka client_secret)
- subscription_id (shown as id from the `az account list` command)
- tenant_id (shown as tenantId from the `az account list` command)

_**NOTE** Your values will vary_

  ![az account list command output](https://github.com/whoha4242/liatrio-exercise/raw/94c71fb9cc1d93d9f8a341dc1668fd36d74e0653/attachments/azaccountlist.png)

You may also choose to use Terraform Cloud to manage your IaC. In that case you will need to configure variables in your Terraform Cloud workspace for all variables found in `terraform.tfvars` as shown below

  ![terraform cloud variables](https://github.com/whoha4242/liatrio-exercise/raw/94c71fb9cc1d93d9f8a341dc1668fd36d74e0653/attachments/tfvars.png)

_**NOTE** These values are only examples. Yours will vary with your Azure Subscription and naming choices, etc_

Key|Description|Value|Category
---|---|---|---
rg|Azure Resource Group|csw-liatrio-exercise-rg|terraform
aks-cluster|Azure Kubernetes Services Cluster Name|csw-liatrio-exercise-aks1|terraform
dns-prefix|AKS DNS Prefix|cswliatrioexerciseaks1|terraform
subscription_id|Azure Subscription ID|2b71fc73-f30a-40e5-a1c1-7d4db96b080d|terraform
tenant_id|Azure Tenant ID|7500411e-6146-4c36-8612-6f9390df3440|terraform
client_id|Azure SPN AppId|Sensitive - write only|terraform
client_secret|Azure SPN Password (client_id)|Sensitive - write only|terraform