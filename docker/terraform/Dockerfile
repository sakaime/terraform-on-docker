FROM ubuntu:latest

ARG awscli_version="2.0.50"
ARG terraform_version="0.13.5"
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

RUN apt-get update && apt-get install -y less vim wget unzip

RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${awscli_version}.zip -O awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

RUN wget https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip -O terraform.zip && \
    unzip terraform.zip -d /usr/local/bin/

COPY ./docker/terraform/.aws /root/.aws
COPY ./docker/terraform/init.sh /root/init.sh
RUN chmod +x /root/init.sh && /root/init.sh

WORKDIR /root/src