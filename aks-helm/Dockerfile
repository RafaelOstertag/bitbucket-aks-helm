ARG VERSION
FROM rafaelostertag/aks-kubectl:$VERSION

RUN curl -o /tmp/helm.tar.gz https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz &&\
    tar -C /usr/local/bin --strip-components=1 -xvf /tmp/helm.tar.gz linux-amd64/helm &&\
    chmod +x /usr/local/bin/helm &&\
    rm -rf /tmp/* && helm version
ADD pipe.sh /pipe.sh
ENTRYPOINT [ "/pipe.sh" ]
