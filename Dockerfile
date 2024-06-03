# Use Photon 5 as the base image
FROM photon:5.0

# Configure  environment variables
ENV TANZU_CLI_CEIP_OPT_IN_PROMPT_ANSWER=yes
ENV REPO="https://wp-content.vmware.com/v2/latest/"
ENV WORKINGDIR="/data/kubernetes-node-images"
ENV IMAGE_LIST="/data/kubernetes-node-images/image.list"

# Update the package repository and install all require utilities & tools
RUN tdnf -y update && \
    tdnf -y install \
    vim \
    curl \
    wget \
    tar \
    gzip \
    openssl \
    gzip  \
    perl  \
    nginx  \
    openssh-clients \
    traceroute  \
    network-config-manager  \
    jq  
    

# Clean up to reduce image size
#RUN cd /tmp
RUN tdnf  clean all

# Install Carvel Tooling

#RUN curl -L https://carvel.dev/install.sh | bash
RUN wget -O- https://carvel.dev/install.sh | /bin/bash

# Install GOVC 
RUN wget "https://github.com/vmware/govmomi/releases/download/v0.37.2/govc_Linux_x86_64.tar.gz"
RUN tar -zxvf govc_Linux_x86_64.tar.gz -C /usr/local/bin govc
RUN rm ./govc_Linux_x86_64.tar.gz

# Creating Data directory to hold repository artifacts
RUN mkdir /data

#Install Tanzu CLI
#RUN wget "https://github.com/vmware-tanzu/tanzu-cli/releases/download/v1.3.0/tanzu-cli-linux-amd64.tar.gz"
RUN wget "https://github.com/vmware-tanzu/tanzu-cli/releases/download/v1.1.0/tanzu-cli-linux-amd64.tar.gz"
RUN tar zxvf tanzu-cli-linux-amd64.tar.gz
RUN mv ./v1.1.0/tanzu-cli-linux_amd64 /usr/local/bin/tanzu
RUN tanzu config eula accept
RUN tanzu init 

# Downloading Tanzu Packages and Tanzu Plugins  

RUN mkdir /data/packages
#RUN cd /data/packages
RUN imgpkg copy -b projects.registry.vmware.com/tkg/packages/standard/repo:v2.2.0_update.2 --to-tar /data/packages/kubernetes-packages.tar
RUN mkdir /data/tanzu-plugins
RUN tanzu plugin download-bundle --group vmware-vsphere/default  --to-tar /data/tanzu-plugins/vsphere-plugin-bundle.tar

# Install KUBECTL 1.28
RUN curl -LO https://dl.k8s.io/release/v1.28.0/bin/linux/amd64/kubectl
RUN cp kubectl /usr/local/bin/kubectl
RUN chmod a+x /usr/local/bin/kubectl

#
# Download TKRs
#
# mkdir /data/kubernetes-node-images
RUN mkdir /data/kubernetes-node-images
COPY image-copy.sh /data/kubernetes-node-images/image-copy.sh
COPY image.list /data/kubernetes-node-images/image.list 
RUN  /data/kubernetes-node-images/image-copy.sh

# Set the working directory
WORKDIR /data


# Expose port (example, modify as needed)
#EXPOSE 8080

# Define the entry point (example, modify as needed)
CMD ["sh"]


