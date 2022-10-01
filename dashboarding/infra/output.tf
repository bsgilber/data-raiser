# Display the service URL
output "Web-server-URL" {
  value = join("", ["http://", google_cloud_run_service.run_service.status[0].url, ":3000"])
}


