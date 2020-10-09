ARG BasedOn=azp
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}
ARG K8sCliV

COPY ./azp/k8s/*.sh ./
RUN ./install-k8s.sh ${K8sCliV}
