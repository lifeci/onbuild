ARG BuildNo
ARG BasedOn=base_alpine
FROM lifeci/onbuild:${BasedOn}${BuildNo}
ARG BIN=/usr/local/bin

ARG tf_V
RUN wget -q \
      https://releases.hashicorp.com/terraform/${tf_V}/terraform_${tf_V}_linux_amd64.zip \
      -O /tmp/tf.zip &&  \
    unzip /tmp/tf.zip -d /tmp && \
    cp /tmp/terraform ${BIN}/ && \
    chmod +x ${BIN}/terraform && \
    rm -rf /tmp/*

ARG tg_V
RUN wget -q \
      https://github.com/gruntwork-io/terragrunt/releases/download/v${tg_V}/terragrunt_linux_amd64 \
      -O ${BIN}/terragrunt && \
      chmod +x ${BIN}/terragrunt

RUN cd ${BIN}/ && \
    ln -s terraform  tf && \
    ln -s terragrunt tg

ENV BIN=/usr/local/bin