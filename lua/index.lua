package.path = package.path .. ";/server/lua/?.lua"
require("module")
ngx.header.content_type = "text/html"

-- http://106.14.11.151:10001/?methods=222&sss=111
requests_params = {} -- 请求参数
-- 请求头table
for k, v in pairs(ngx.req.get_uri_args()) do
    requests_params[k] = v
end

-- 路由
if requests_params["methods"] == nil then -- 首页
    module.index()
end

if requests_params["methods"] == "docker_logs" then -- docker logs
    -- ?methods=docker_logs&n=100&container_id=f7a474324f16
    module.docker_logs(requests_params["n"], requests_params["container_id"])
end
