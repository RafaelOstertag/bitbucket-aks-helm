FROM alpine:latest

ADD answer_file /tmp/
RUN apk add bash python3 curl gcc openssl-dev libffi-dev python3-dev libc-dev make
# Install azure cli
RUN curl -o /tmp/az-install -L https://aka.ms/InstallAzureCli &&\
    sed -i 's#^_TTY=.*#_TTY=/tmp/answer_file#g' /tmp/az-install &&\
    bash /tmp/az-install && rm -rf /tmp/* && az version
# Install kubectl    
RUN curl -o /usr/local/bin/kubectl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&\
    chmod +x /usr/local/bin/kubectl &&\
    kubectl version --client=true
ADD pipe.sh /pipe.sh
ENTRYPOINT [ "/pipe.sh" ]
