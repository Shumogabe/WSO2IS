### Ubuntu - Giải nén tar và cài JDK 11.0.17_8
FROM ubuntu:22.04

# Cài tar và wget để tải JDK
RUN apt-get update && \
    apt-get install -y tar wget unzip telnet inetutils-ping dnsutils vim dos2unix traceroute && \
    rm -rf /var/lib/apt/lists/*

# Copy file tar từ Windows stage
COPY IDP_WSO2.tar /opt/IDP_WSO2.tar
COPY jdk-11.0.17.tar.gz /opt/jdk-11.0.17.tar.gz

# Giải nén file tar
RUN tar -xvf /opt/IDP_WSO2.tar -C /opt/ && tar -xzvf /opt/jdk-11.0.17.tar.gz -C /opt/

# Thiết lập biến môi trường JAVA_HOME
ENV JAVA_HOME=/opt/jdk-11.0.17
ENV PATH="$JAVA_HOME/bin:$PATH"

WORKDIR /opt/IDP_WSO2/bin
RUN sed -i 's/\r$//' wso2server.sh
RUN chmod 777 wso2server.sh
#RUN ./wso2server.sh
CMD ["./wso2server.sh"]
