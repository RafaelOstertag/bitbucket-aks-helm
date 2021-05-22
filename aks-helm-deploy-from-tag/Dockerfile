ARG VERSION
FROM rafaelostertag/aks-helm:$VERSION

RUN apk add git

ADD pipe.sh /pipe.sh
ENTRYPOINT [ "/pipe.sh" ]
