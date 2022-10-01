resource "google_compute_instance" "default" {
  name         = "airbyte-vm"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  metadata_startup_script = file(var.bootstrap_script)

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }
}
