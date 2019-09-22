variable "gcp_region" {
  description = "GCP region, e.g. us-east1"
  default = "europe-west1"
}

variable "gcp_zone" {
  description = "GCP zone, e.g. us-east1-b (which must be in gcp_region)"
  default = "europe-west1-b"
}

variable "gcp_project" {
  description = "GCP project name"
  default = "DEFAULT"
}

variable "initial_node_count" {
  description = "Number of worker VMs to initially create"
  default = 1
}

variable "master_username" {
  default = ""
}

variable "master_password" {
  default = ""
}

variable "node_machine_type" {
  description = "GCE machine type"
  default = "g1-small"
}

variable "node_disk_size" {
  description = "Node disk size in GB"
  default = "20"
}
variable "node_pool_name" {
  description = "Pool of nodes"
  default = "default-pool"
}
