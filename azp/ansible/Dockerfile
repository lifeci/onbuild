ARG BasedOn=azp
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}

ARG AnsibleV=2.6.1
RUN apt update && apt-cache madison ansible && apt install ansible=$AnsibleV -y
#RUN pip install ansible=$AnsibleV;
RUN adduser ansible --no-create-home --uid 2020 --system
