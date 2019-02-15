ARG BuildNo
ARG BasedOn=vsts
FROM lifeci/onbuild:${BasedOn}${BuildNo}

ARG AWScliV
ARG AWSiamV
COPY ./vsts/aws/*.sh ./
RUN ./install-aws-cli.sh ${AWScliV}; \
    ./install-aws-iam-auth.sh ${AWSiamV};

CMD printf "USAGE:\t docker run --rm lifeci/onbuild:aws$(cat ./BuildNo) aws --help\n"
