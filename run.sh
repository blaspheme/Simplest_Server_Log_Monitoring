docker stop simplest_log_server || true 
docker rm simplest_log_server || true 
docker run -d -p 10001:8000  -v /var/run/docker.sock:/var/run/docker.sock --name simplest_log_server erudite/simplest_server_nginx:1.0.0