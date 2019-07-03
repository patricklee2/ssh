FROM mcr.microsoft.com/oryx/node-10.14:20190516.1
LABEL maintainer="Azure App Services Container Images <appsvc-images@microsoft.com>"

RUN echo "ipv6" >> /etc/modules

RUN npm install -g pm2 \
     && mkdir -p /home/LogFiles /opt/startup \
     && echo "root:Docker!" | chpasswd \
     && echo "cd /home" >> /etc/bash.bashrc \
     && apt-get update \  
     && apt-get install --yes --no-install-recommends vim curl wget tcptraceroute openrc

# setup default site
COPY startup /opt/startup
COPY hostingstart.html /opt/startup


RUN rm -f /etc/ssh/sshd_config \
   && chmod -R +x /opt/startup \
   && cd /opt/startup \
   && npm install 

ENV PORT 8080
ENV SSH_PORT 2222
EXPOSE 2222 8080

ENV PM2HOME /pm2home

ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot

WORKDIR /home/site/wwwroot

COPY start_sshd.sh /etc/ssh/

RUN groupadd sshd \
   && useradd -g sshd -d / sshd \
   && apt-get update -y \
   && wget -c https://www.openssl.org/source/openssl-1.0.2s.tar.gz \
   && tar -xzf openssl-1.0.2s.tar.gz \
   && cd openssl-1.0.2s/ \
   && ./configure \
      --libdir=/etc/ssh \
      --openssldir=/etc/ssh \
      --prefix=/etc/ssh \
   && make \
   && make install \
   && cd /etc/ssh \
   && wget -c https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.0p1.tar.gz \
   && tar -xzf openssh-8.0p1.tar.gz \
   && cd openssh-8.0p1/ \
   && ./configure \
      --prefix=/etc/ssh \
      --sysconfdir=/etc/ssh \
      --with-pid-dir=/etc/ssh \
      --with-privsep-path=/etc/ssh \
      --with-ssl-dir=/etc/ssh \
   && make \
   && make install \
   && chmod u+x /etc/ssh/start_sshd.sh

COPY sshd_config /etc/ssh/


VOLUME /etc/ssh

ENTRYPOINT ["/opt/startup/init_container.sh"]
