FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive
ENV PATH $PATH:/usr/local/nginx/sbin

EXPOSE 1935
EXPOSE 8080
EXPOSE 80

# create directories
RUN mkdir /src /config /logs /data /static

# update and upgrade packages
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get clean && \
  apt-get install -y --no-install-recommends build-essential \
  wget software-properties-common && \
# ffmpeg
  add-apt-repository ppa:mc3man/trusty-media && \
  apt-get update && \
  apt-get install -y --no-install-recommends ffmpeg && \
# nginx dependencies
  apt-get install -y --no-install-recommends libpcre3-dev \
  zlib1g-dev libssl-dev wget && \
  rm -rf /var/lib/apt/lists/*

# get nginx source
WORKDIR /src
RUN apt-get update && \
   apt-get install -y git && \ 
   git clone https://github.com/nginx/nginx.git && \
   git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git 

WORKDIR /src/nginx
RUN auto/configure --add-module=../nginx-rtmp-module --with-http_ssl_module --conf-path=/config/nginx.conf  \
  --error-log-path=/logs/error.log \
  --http-log-path=/logs/access.log && \
   make && \
   make install

# get nginx source
#WORKDIR /src
#RUN wget http://nginx.org/download/nginx-1.6.2.tar.gz && \
#  tar zxf nginx-1.6.2.tar.gz && \
#  rm nginx-1.6.2.tar.gz && \
## get nginx-rtmp module
#  wget https://github.com/arut/nginx-rtmp-module/archive/v1.1.6.tar.gz && \
#  tar zxf v1.1.6.tar.gz && \
#  rm v1.1.6.tar.gz

# compile nginx
#WORKDIR /src/nginx-1.6.2
#RUN ./configure --add-module=/src/nginx-rtmp-module-1.1.6 \
#  --conf-path=/config/nginx.conf \
#  --error-log-path=/logs/error.log \
#  --http-log-path=/logs/access.log && \
#  make && \
#  make install

ADD nginx.conf /config/nginx.conf
ADD static /static

WORKDIR /
CMD "nginx"
