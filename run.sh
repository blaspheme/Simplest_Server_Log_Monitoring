docker run -d -p 10001:8000  -v /var/run/docker.sock:/var/run/docker.sock --name simplest_log_server erudite/simplest_server_nginx:1.0.0
docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock erudite/simplest_server_nginx:1.0.0 sh
