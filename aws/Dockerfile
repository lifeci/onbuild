ARG BuildNo
ARG BasedOn=base
FROM lifeci/onbuild:${BasedOn}${BuildNo}
ARG BuildNo
RUN echo "$BuildNo" > ./BuildNo

ARG AWScliV
ARG AWSiamV
COPY ./*.sh ./
RUN ./install-aws-cli.sh ${AWScliV}; \
    ./install-aws-iam-auth.sh ${AWSiamV};

CMD printf "USAGE:\t docker run --rm lifeci/onbuild:aws$(cat ./BuildNo) aws --help\n"
