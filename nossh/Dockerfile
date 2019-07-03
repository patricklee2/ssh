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
EXPOSE 8080

ENV PM2HOME /pm2home

ENV WEBSITE_ROLE_INSTANCE_ID localRoleInstance
ENV WEBSITE_INSTANCE_ID localInstance
ENV PATH ${PATH}:/home/site/wwwroot

WORKDIR /home/site/wwwroot

ENTRYPOINT ["/opt/startup/init_container.sh"]
