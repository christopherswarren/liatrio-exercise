variable "rg" {
  description = "Resource group name"
}

variable "aks-cluster" {
  description = "AKS Cluster name"
}

variable "dns-prefix" {
  description = "DNS Prefix name"
}

variable "client_id" {
  description = "AppId or client_id of Azure SPN"
}

variable "client_secret" {
  description = "Password or client_secret for Azure SPN"
}

variable "tenant_id" {
  description = "Tenant ID for Azure SPN"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
}