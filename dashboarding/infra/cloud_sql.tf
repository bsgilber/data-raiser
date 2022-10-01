resource "google_sql_database_instance" "metabase_admin_db" {
  name             = "metabase-admin-db"
  database_version = "POSTGRES_14"
  region           = var.region

  settings {
    tier = var.tier
  }
}

resource "google_sql_database" "database" {
  name      = format("%s_%s", var.database_name, var.env)
  instance  = google_sql_database_instance.metabase_admin_db.name
  charset   = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
  name     = "root"
  instance = google_sql_database_instance.metabase_admin_db.name
  host     = "%"
  password = "mypassw0rd"
}


