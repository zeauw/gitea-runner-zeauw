FROM docker:dind-rootless

USER root

RUN apk add --no-cache nodejs npm jq curl fontconfig font-noto icu-data-full

USER rootless
