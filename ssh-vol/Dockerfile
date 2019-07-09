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

RUN mkdir -p /etc/ssh/openssl \
   && apt-get -y remove openssl \
   && groupadd sshd \
   && useradd -g sshd -d / sshd \
   && apt-get update -y \
   && wget -c https://www.openssl.org/source/openssl-1.1.1c.tar.gz \
   && tar -xzf openssl-1.1.1c.tar.gz \
   && cd openssl-1.1.1c/ \
   && ./Configure --libdir=/etc/ssh/openssl --openssldir=/etc/ssh/openssl --prefix=/etc/ssh/openssl no-shared linux-x86_64 \
   && make \
   && make test \
   && make install \
   && PATH=$PATH:/etc/ssh/bin

COPY sshd_config /etc/ssh/
COPY ssh_setup.sh /etc/ssh/

RUN mkdir -p /etc/ssh/openssh \
   && cd /etc/ssh \
   && wget -c https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.9p1.tar.gz \
   && tar -xzf openssh-7.9p1.tar.gz \
   && cd openssh-7.9p1/ \
   && ./configure --prefix=/etc/ssh/openssh --sysconfdir=/etc/ssh/openssh --with-pid-dir=/etc/ssh/openssh --with-privsep-path=/etc/ssh/openssh --with-ssl-dir=/etc/ssh/openssl \
   && make \
   && make install \
   && chmod u+x /etc/ssh/start_sshd.sh \
   && chmod u+x ssh_setup.sh



VOLUME /etc/ssh

ENTRYPOINT ["/opt/startup/init_container.sh"]
