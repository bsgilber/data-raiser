# ssh tunneling, port forwarding from 8000 to 8000, which is airbytes default port
gcloud --project gilbert-learning-gcp-113 beta compute ssh airbyte-vm -- -L 8000:localhost:8000 -N -f

# example to ping and check the health of the airbyte server
# use the web server output in place of the ip address
curl http://35.225.124.118:8000/api/v1/health
