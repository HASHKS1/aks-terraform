#================================================================================================
# Environment Vars - Global
#================================================================================================
variable "tenant_id" {
  type        = string
  description = "The azure tenant id"
}
variable "terraform_sp" {
  type        = string
  description = "The terraform service principal"
}
variable "location" {
  type        = string
  description = "Azure location to deploy resources in"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "application_code" {} # Project code used for naming.
variable "unique_id" {}        # A unique id for naming.

#================================================================================================
# Environment Vars
#================================================================================================
variable "environment" {
  type        = string
  description = "The environement name"
}
variable "subscription_id" {
  type        = string
  description = "The azure subscription id"
}
variable "vnet" { type = map(any) }

variable "vnet_subnets" { type = map(any) }

variable "dns_name" {
  type        = string
  description = "Your_Domain_Name"
}

variable "uai_name_aks" {
  type        = string
  description = "Managed Identity Name for AKS"
}

variable "kv_name" {
  type        = string
  description = "Key Vault Name"
}

variable "random_string_kv" {
  type        = string
  description = "Random String kv"
}




