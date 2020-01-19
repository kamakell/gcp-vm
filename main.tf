terraform {
  backend "gcs" {
    bucket  = "sales-eu01-shared"
    prefix  = "terraform/state"
  }
}
// Configure the Google Cloud provider
provider "google" {
 # credentials = "${file("${var.credentials}")}"
 project     = "${var.gcp_project}"
 region      = "${var.region}"
}

# A VM is created
resource "google_compute_instance" "vm_instance" {
name         = "${var.vm_instance}-shy"
 machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

 resource "google_compute_network" "vpc_network" {
 name = "vpc-network"
}
  network_interface {
    # A default network is created for all GCP projects
    network       = "${google_compute_network.vpc_network.self_link}"
    access_config {
    }
  }
}
