terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "~> 2.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

variable "linode_token" {
  description = "Linode API token"
  type        = string
  sensitive   = true
}

resource "linode_lke_cluster" "smol_cluster" {
  label       = "smol-lke-cluster"
  k8s_version = "1.33"
  region      = "us-southeast"
  tags        = ["terraform"]

  pool {
    type  = "g6-standard-1"
    count = 3
  }
}

output "kubeconfig" {
  value     = linode_lke_cluster.smol_cluster.kubeconfig
  sensitive = true
}

output "api_endpoints" {
  value = linode_lke_cluster.smol_cluster.api_endpoints
}

output "status" {
  value = linode_lke_cluster.smol_cluster.status
}
