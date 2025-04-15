FROM gitea/act_runner:latest

RUN apk add --no-cache nodejs hugo npm jq curl

COPY ./wait-for-healthy-app.sh /wait-for-healthy-app.sh

RUN curl https://gitea.com/gitea/act_runner/raw/branch/main/scripts/run.sh -o /usr/local/bin/run.sh && \
    chmod +x /usr/local/bin/run.sh

ENTRYPOINT ["/sbin/tini", "--"]

CMD bash /wait-for-healthy-app.sh ${GITEA_INSTANCE_URL}/api/healthz run.sh
