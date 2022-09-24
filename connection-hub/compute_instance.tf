resource "google_compute_instance" "default" {
  name         = "airbyte-vm"
  machine_type = var.machine_type
  zone         = var.zone
  
  metadata_startup_script = file(var.bootstrap_script)

  boot_disk {
    initialize_params {
      image =  var.image
    }
  }

  # Install Airbyte and Dependencies
  network_interface {
    network = "default"

    access_config {
    }
  }
}
