ARG BasedOn=vstsaws
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}
ARG K8sCliV

COPY ./vsts/aws/k8s/*.sh ./
RUN ./install-k8s.sh ${K8sCliV}
