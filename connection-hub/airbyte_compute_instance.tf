resource "google_compute_instance" "default" {
  name         = "airbyte-vm"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["ssh"]

  metadata = {
    enable-oslogin = "TRUE"
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10-buster-v20220920"
    }
  }

  # Install Airbyte and Dependencies
  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  provisioner "remote-exec" {
    script = var.bootstrap_script

    connection {
      type        = "ssh"
      host        = google_compute_address.static.address
      user        = "airbyte"
    }
  }
}

# Create a public IP address for our google compute instance to utilize
resource "google_compute_address" "static" {
  name = "vm-public-address"
}

resource "google_compute_firewall" "airbyte_firewall" {
  name    = "airbyte-app-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8000"]
  }
  source_ranges = ["0.0.0.0/0"]
}
