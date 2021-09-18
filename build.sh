#!/usr/bin/bash
docker rmi erudite/simplest_server_nginx:1.0.0
docker build -t erudite/simplest_server_nginx:1.0.0 .