FROM ubuntu-oracle-jdk8
MAINTAINER Koert Zeilstra <koert.zeilstra@zencode.nl>

RUN apt-get update && \
    apt-get install -y wget unzip pwgen expect && \
    wget http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
    unzip glassfish-4.1.zip -d /opt && \
    rm glassfish-4.1.zip

ENV PATH /opt/glassfish4/bin:$PATH

ADD start-glassfish.sh /start-glassfish.sh
ADD initialize-glassfish.sh /initialize-glassfish.sh
ADD configure-glassfish.sh /configure-glassfish.sh
ADD change_admin_password.sh /change_admin_password.sh
ADD change_admin_password_func.sh /change_admin_password_func.sh
ADD enable_secure_admin.sh /enable_secure_admin.sh
RUN chmod +x /*.sh

RUN echo 'root:root' | chpasswd

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener), 9009 (JPDA debug port)
EXPOSE 4848 8080 8181 9009

CMD ["/start-glassfish.sh"]

