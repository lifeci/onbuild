ARG BuildNo
ARG BasedOn=tf_tg
FROM lifeci/onbuild:${BasedOn}${BuildNo}
#ARG BIN=/usr/local/bin

RUN  apk --no-cache --update add python3;
RUN  pip3 install --no-cache --upgrade pip setuptools wheel; \
     rm -rf /var/cache/apk/*; \
     ln -s `which pip3` ${BIN}/pip;

ARG aws_V
RUN pip install \
        awscli==1.16.225

# consider as alternative: https://github.com/saksdirect/okta-aws-login
ARG okta_V
RUN echo "https://github.com/segmentio/aws-okta/releases/download/v${okta_V}/aws-okta-v${okta_V}-linux-amd64"
RUN wget -q \
      https://github.com/segmentio/aws-okta/releases/download/v${okta_V}/aws-okta-v${okta_V}-linux-amd64 \
      -O ${BIN}/aws-okta
RUN chmod +x ${BIN}/aws-okta; ls -la ${BIN}/aws-okta