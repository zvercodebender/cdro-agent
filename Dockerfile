ARG TAG="${TAG}"
FROM cloudbees/cbflow-agent:${TAG}


USER root

RUN mkdir /opt/cbflow/grape && \
    chown cbflow:cbflow /opt/cbflow/grape

RUN mkdir /home/cbflow \
&&  chown cbflow:cbflow /home/cbflow \
&&  sed -i "s/\/tmp/\/home\/cbflow/g" /etc/passwd


RUN dnf -y update && \
    dnf -y install wget vim git java && \ 
    dnf -y install python3 python-pip unzip gnupg2 nodejs && \
    rm -rf /var/lib/apt/lists/*
# Install python poetry (for some procedures)
RUN pip3 install poetry

# Install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install

# Install terraform
RUN dnf install -y dnf-utils && \
  dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
  dnf install -y terraform && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /home/cbflow
# install gcloud
ENV CLOUDSDK_INSTALL_DIR /home/cbflow/
RUN curl https://sdk.cloud.google.com > install.sh
RUN bash install.sh --disable-prompts

ENV PATH /home/cbflow/google-cloud-sdk/bin:$PATH

# Install ansible
RUN pip3 install ansible

# Install Juice
RUN npm -g install juice

# Install ec-specs-tool
RUN wget https://github.com/electric-cloud/ec-specs-tool/releases/download/1.7.4/ec-specs-tool.zip && \
  unzip -d ec-specs-tool ec-specs-tool.zip && \
  mkdir -p /opt/tools && \
  mv ec-specs-tool /opt/tools/ && \
  chmod +x /opt/tools/ec-specs-tool/ec-specs

# Install pdk
RUN wget https://downloads.cloudbees.com/cloudbees-cd/pdk/release/bundle/3.8.3/pdk-cli-bundle.zip && \
    unzip pdk-cli-bundle.zip && \
    mkdir -p /opt/tools && \
    mv pdk /opt/tools/ && \
    chmod +x /opt/tools/pdk/bin/pdk*


ENV HOME=/home/cbflow
ENV PS1="[\u@\h \W]\$ "
ENV PATH=$PATH:/opt/tools/pdk/bin

USER cbflow
