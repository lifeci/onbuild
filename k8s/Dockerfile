ARG BasedOn=base
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}
ARG K8sCliV

COPY ./*.sh ./

RUN ./install-k8s.sh ${K8sCliV}
