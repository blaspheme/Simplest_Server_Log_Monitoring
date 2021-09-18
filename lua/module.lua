module = {}

-- 函数定义
function module.index() -- 首页函数
    local docker_ps = io.popen([[/usr/local/bin/docker ps -a | awk -F" " '{print $1,$2}']])
    ngx.say([[<script type="text/javascript">function clickDockerLogs(n,container_id) {
        window.location.href=`?methods=docker_logs&n=${n}&container_id=${container_id}`;
    }</script>]])
    local line = docker_ps:read()
    local first_line_flag = true
    while line do
        ngx.say(line)
        if first_line_flag then -- 第一行不增加按钮 
            first_line_flag = false
        else -- 非第一行增加按钮
            for word in string.gmatch(line, "%w+") do
                -- https://www.codenong.com/9643311/
                ngx.say(string.format([[<input type="button" value="click" onclick="clickDockerLogs('100','%s')" />]], word))
                break
            end
        end
        ngx.say("<br>")
        line = docker_ps:read() -- 读取下一行
    end
end

function module.docker_logs(n, container_id)
    local docker_logs = io.popen(string.format([[/usr/local/bin/docker logs -n %s %s]], n, container_id))
    local line = docker_logs:read()
    while line do
        ngx.say(line)
        ngx.say("<br>")
        line = docker_logs:read() -- 读取下一行
    end
end

return module
