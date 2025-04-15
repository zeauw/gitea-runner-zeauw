FROM gitea/act_runner:latest

RUN apk add --no-cache nodejs hugo npm jq curl

COPY ./wait-for-healthy-app.sh /wait-for-healthy-app.sh

ENTRYPOINT ["/sbin/tini", "--"]

CMD bash /wait-for-healthy-app.sh ${GITEA_INSTANCE_URL}/api/healthz bash /usr/local/bin/run.sh
