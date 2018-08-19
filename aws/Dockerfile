FROM lifeci/onbuild:base${CIRCLE_BUILD_NUM}
MAINTAINER rj-lifeci
ARG AWScliV
RUN pip install awscli==${AWScliV}
RUN aws --version
CMD ["bash"]
