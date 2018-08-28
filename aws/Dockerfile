ARG BuildNo
FROM lifeci/onbuild:base${BuildNo}
MAINTAINER rj-lifeci
ARG AWScliV
ARG BuildNo
RUN echo "$BuildNo" > ./BuildNo
RUN pip install awscli==${AWScliV}
CMD printf "USAGE:\t docker run --rm lifeci/onbuild:aws$(cat ./BuildNo) aws --help\n"
