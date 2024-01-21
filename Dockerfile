FROM alpine:3 as builder

ADD https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-src.tar.gz /

RUN apk add --no-cache \
        alpine-sdk \
        go \
        linux-headers \
        krb5-dev

RUN mkdir /source && \
    tar xfz \
        /openshift-client-src.tar.gz \
        -C /source \
        --strip-components 1 

WORKDIR /source

RUN make oc

# ------------------------------------------------------------------------------

FROM alpine:3

COPY --from=builder /source/oc /usr/local/bin
