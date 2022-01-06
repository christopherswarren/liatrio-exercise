variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}

variable "rg" {
  description = "Resource group name"
}

variable "aks-cluster" {
  description = "AKS Cluster name"
}

variable "dns-prefix" {
  description = "DNS Prefix name"
}
