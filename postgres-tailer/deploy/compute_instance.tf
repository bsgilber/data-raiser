module "gce-container" {
  source = "terraform-google-modules/container-vm/google"
  version = "~> 2.0"

  cos_image_name = var.cos_image_name

  container = {
    // image = "us-central1-docker.pkg.dev/gilbert-learning-gcp-113/gilbert-test-repo/postgres-tailer:test"
    image = "gcr.io/google-samples/hello-app:1.0"

    env = [
      {
        name  = "TEST_VAR"
        value = "Hello World!"
      },
    ]

    volumeMounts = [
      {
        mountPath = "/cache"
        name      = "tempfs-0"
        readOnly  = false
      },
    ]
  }

  volumes = [
    {
      name = "tempfs-0"

      emptyDir = {
        medium = "Memory"
      }
    },
  ]

  restart_policy = "Always"
}

resource "google_compute_instance" "vm" {
  name         = "postgres-tailer-vm"
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = module.gce-container.source_image
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    gce-container-declaration = module.gce-container.metadata_value
    google-logging-enabled    = "true"
    google-monitoring-enabled = "true"
  }
}

///

resource "google_compute_instance" "default" {
  name         = "postgres-tailer-vm"
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
