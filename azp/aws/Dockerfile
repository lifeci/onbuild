ARG BuildNo
ARG BasedOn=azp
FROM lifeci/onbuild:${BasedOn}${BuildNo}

ARG AWScliV
ARG AWSiamV
COPY ./azp/aws/*.sh ./
RUN ./install-aws-cli.sh ${AWScliV}; \
    ./install-aws-iam-auth.sh ${AWSiamV};

CMD printf "USAGE:\t docker run --rm lifeci/onbuild:aws$(cat ./BuildNo) aws --help\n"
