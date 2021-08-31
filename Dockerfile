FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y gcc libpcre3-dev zlib1g-dev make wget

WORKDIR /root/

RUN wget http://nginx.org/download/nginx-1.20.1.tar.gz
RUN tar xvzf nginx-1.20.1.tar.gz

COPY ngx_upstream_resolveMK ./ngx_upstream_resolveMK/

RUN cd nginx-1.20.1 && ./configure --add-module=../ngx_upstream_resolveMK
RUN cd nginx-1.20.1 && make && make install
RUN cd nginx-1.20.1 && ln -s `pwd`/objs/nginx  /usr/bin/nginx

CMD ["nginx", "-v"]