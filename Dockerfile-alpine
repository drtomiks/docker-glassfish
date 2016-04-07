FROM frolvlad/alpine-oraclejdk8
MAINTAINER Koert Zeilstra <koert.zeilstra@zencode.nl>

# Build image
# docker build -t koert/glassfish-4.1 .

RUN apk add --update bash expect && rm -rf /var/cache/apk/* && \
    mkdir -p /opt/app/bin && mkdir -p /opt/app/deploy && \
    wget http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
    unzip glassfish-4.1.zip -d /opt && \
    rm glassfish-4.1.zip


RUN echo 'root:root' | chpasswd

ENV PATH /opt/glassfish4/bin:/opt/app/bin:$PATH

ADD bin/change_admin_password.sh /opt/app/bin/change_admin_password.sh
ADD bin/change_admin_password_func.sh /opt/app/bin/change_admin_password_func.sh
ADD bin/enable_secure_admin.sh /opt/app/bin/enable_secure_admin.sh
ADD bin/initialize-glassfish.sh /opt/app/bin/initialize-glassfish.sh
ADD bin/configure-glassfish.sh /opt/app/bin/configure-glassfish.sh
ADD bin/start-glassfish.sh /opt/app/bin/start-glassfish.sh

RUN chmod +x /opt/app/bin/*.sh
RUN /opt/app/bin/initialize-glassfish.sh

# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener), 9009 (JPDA debug port)
EXPOSE 4848 8080 8181 9009

CMD ["/opt/app/bin/start-glassfish.sh"]

