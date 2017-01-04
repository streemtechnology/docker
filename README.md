NGINX RTMP Dockerfile
=====================

This Dockerfile installs NGINX configured with `nginx-rtmp-module`, ffmpeg
and some default settings for HLS live streaming.

**Note: in the current state, this is just an experimental project to play with
RTMP and HLS.**


How to use
----------

1. Build and run the container (`docker build -t nginx_rtmp .` &
   `docker run -p 80:80 -p 1935:1935 -p 8080:8080 --rm nginx_rtmp`).

2. Stream your live content to `rtmp://<ip>:1935/encoder/stream_name` where
   `stream_name` is the name of your stream.

3. In Safari, VLC or any HLS compatible browser / player, open
   `http://<ip>:8080/hls/stream_name.m3u8`.
   This gives the submitted stream. 

4. A random stream has been autmatically added for ingest and delivery. It can be accessed at 
   `http://<ip>:8080/dash/stream.m3u8` Integrated player using [hls.js](https://github.com/dailymotion/hls.js/tree/master) can play hls in chrome at `http://<ip>/static/player.html`

5. Server statistics are exposed at `http://<ip>/stat` 


Links
-----

* Guide to setup nginx rtmp module - https://docs.peer5.com/guides/setting-up-hls-live-streaming-server-using-nginx/
* Nginx rtmp module - https://github.com/sergey-dryabzhinsky/nginx-rtmp-module
* Nginx server -  https://github.com/nginx/nginx 
* HTTP/2 push module - http://nossdav14.iis.sinica.edu.tw/slides/2-3_Low-Latency-LiveV-Streaming-over-HTTP2.pdf 
* ffmpeg tuning - https://ffmpeg.org/pipermail/ffmpeg-user/2016-January/030127.html 
