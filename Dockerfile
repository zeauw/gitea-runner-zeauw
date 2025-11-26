FROM docker:dind-rootless

RUN apk add --no-cache nodejs npm jq curl fontconfig font-noto icu-data-full
