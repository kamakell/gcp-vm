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
resource "google_compute_instance" "default" {
  name         = "vm-arjun"
  machine_type = "f1-micro"
  zone         = "eu-west2"
  network_interface {
    network = "dev"
  }
  boot_disk {
    initialize_params {
      image     =  "centos-7-v20180129"     
    }
  }
}
