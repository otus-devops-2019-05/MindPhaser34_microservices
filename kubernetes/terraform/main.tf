terraform {
  required_version = ">= 0.11.11"
}

provider "google" {
  project = "${var.gcp_project}"
  region  = "${var.gcp_region}"
}

resource "google_container_cluster" "kube-cluster" {
  name               = "standart-cluster"
  location           = "${var.gcp_zone}"
  initial_node_count = "${var.initial_node_count}"
  remove_default_node_pool = true

  master_auth {
    username = "${var.master_username}"
    password = "${var.master_password}"

    client_certificate_config {
      issue_client_certificate = false
    }
  }
  addons_config {
    kubernetes_dashboard {
      disabled = true
    }
  }
}

resource "google_container_node_pool" "node_pool" {
  name = "${var.node_pool_name}"
  location = "${google_container_cluster.kube-cluster.location}"
  cluster = "${google_container_cluster.kube-cluster.name}"

  node_config {
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"
    oauth_scopes = [
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/trace.append"
        ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}


resource "google_compute_firewall" "kube-reddit" {
  name    = "kube-reddit"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}

