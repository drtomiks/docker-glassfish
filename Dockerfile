FROM drtomiks/ubuntu1404-java7
MAINTAINER Tom McKibben <tmckibben1138@gmail.com>

# Build image
# docker build -t drtomiks/glassfish-3.1.2 .

RUN apt-get update && \
    apt-get install -y wget unzip pwgen expect && \
    wget http://download.java.net/glassfish/3.1.2/release/glassfish-3.1.2.zip && \
    unzip glassfish-3.1.2.zip -d /opt && \
    rm glassfish-3.1.2.zip

ENV PATH /opt/glassfish3/bin:/opt/app/bin:$PATH

RUN mkdir -p /opt/app/bin
RUN mkdir -p /opt/app/deploy

COPY bin/change_admin_password.sh /opt/app/bin/change_admin_password.sh
COPY bin/change_admin_password_func.sh /opt/app/bin/change_admin_password_func.sh
COPY bin/enable_secure_admin.sh /opt/app/bin/enable_secure_admin.sh
COPY bin/initialize-glassfish.sh /opt/app/bin/initialize-glassfish.sh
COPY bin/configure-glassfish.sh /opt/app/bin/configure-glassfish.sh
RUN chmod +x /opt/app/bin/*.sh

RUN /opt/app/bin/initialize-glassfish.sh

RUN echo 'root:root' | chpasswd

RUN mkdir -p /etc/service/glassfish
COPY bin/start-glassfish.sh /etc/service/glassfish/run
RUN chmod +x /etc/service/glassfish/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener), 9009 (JPDA debug port)
EXPOSE 4848 8080 8181 9009

# CMD ["/opt/app/bin/start-glassfish.sh"]

