FROM lifeci/onbuild:base${BuildNo}
MAINTAINER rj-lifeci
ARG AWScliV
RUN pip install awscli==${AWScliV}
RUN aws --version
CMD ["bash"]
