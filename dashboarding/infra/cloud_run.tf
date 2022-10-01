# Create the Cloud Run service
resource "google_cloud_run_service" "run_service" {
  name     = "metabase-server"
  project  = var.project_id
  location = var.region

  template {
    spec {
      containers {
        image = var.metabase_server_image

        ports {
          container_port = var.metabase_port
        }

        resources {
          limits = {
            cpu    = var.metabase_cpu
            memory = var.metabase_mem
          }
        }
        env {
          name  = "MB_DB_TYPE"
          value = "postgres"
        }
        env {
          name  = "MB_DB_DBNAME"
          value = var.database_name
        }
        env {
          name  = "MB_DB_PORT"
          value = "5432"
        }
        env {
          name  = "MB_DB_USER"
          value = google_sql_user.users.name
        }
        env {
          name  = "MB_DB_PASS"
          value = google_sql_user.users.password
        }
        env {
          name  = "MB_DB_HOST"
          value = google_sql_database_instance.metabase_admin_db.ip_address.0.ip_address
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # Waits for the Cloud Run API to be enabled from main.tf
  depends_on = [google_project_service.run_api]
}

# Allow unauthenticated users to invoke the service
resource "google_cloud_run_service_iam_member" "run_all_users" {
  service  = google_cloud_run_service.run_service.name
  project  = var.project_id
  location = google_cloud_run_service.run_service.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
