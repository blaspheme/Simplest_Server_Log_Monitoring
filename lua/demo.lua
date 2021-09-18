-- filename:demo.lua
ngx.header.content_type = "text/html"

local docker_ps = io.popen([[/usr/local/bin/docker ps -a | awk -F" " '{print $1,$2}']])
local docker_ps_text = docker_ps:read("*all")

ngx.say(docker_ps_text)