# Simplest Server Log Monitoring
实现最简单的web登陆
# 选项动机
目的：
* Docker部署
* web展示
* 服务器实现基本授权
* 监控Docker内容

排除选项：
* 不使用 `supervisord` 管理进程，只是因为他基于python，不想安装多编程语言，保持镜像足够轻量，所以需要前台直接执行 Nginx
* `nginx-lua` 非官方实现，需要依赖更多的库，故放弃

最终选择 `openresty` 这个 Nginx 增强实现
