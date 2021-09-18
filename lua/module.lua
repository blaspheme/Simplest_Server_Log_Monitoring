module = {}

-- 函数定义
function module.index() -- 首页函数
    local docker_ps = io.popen(
        [[/usr/local/bin/docker ps -a --format "{{.ID}}\t{{.Image}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Ports}}"]])
    ngx.say([[<script type="text/javascript">function clickDockerLogs(n,container_id) {
        window.location.href=`?methods=docker_logs&n=${n}&container_id=${container_id}`;
    }</script>]])
    local line = docker_ps:read()
    ngx.say([[<span>ID  Image   CreatedAt   Status  Ports </span>]]) -- 表头
    ngx.say("<br>")
    while line do -- 表内容
        ngx.say(line)
        for word in string.gmatch(line, "[^%s]+") do
            -- https://www.codenong.com/9643311/
            ngx.say(string.format([[<input type="button" value="click" onclick="clickDockerLogs('100','%s')" />]], word))
            break
        end
        ngx.say("<br>")
        line = docker_ps:read() -- 读取下一行
    end
end

function module.docker_logs(n, container_id) -- docker logs
    local docker_logs = io.popen(string.format([[/usr/local/bin/docker logs -n %s %s]], n, container_id))
    local line = docker_logs:read()
    while line do
        ngx.say(line)
        ngx.say("<br>")
        line = docker_logs:read() -- 读取下一行
    end
end

return module

-- for word in string.gmatch([[246a23818b76    yc_springboot:test  2021-09-18 18:51:54 +0800 CST   Up 12 hours 0.0.0.0:8311->8211/tcp, :::8311->8211/tcp]],"[^%s]+") do
--     print(word)
--     print("xxxxxxxxxxxxxxxx")
-- end
