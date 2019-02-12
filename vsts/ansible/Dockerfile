ARG BasedOn=vsts
ARG BuildNo
FROM lifeci/onbuild:${BasedOn}${BuildNo}

ARG AnsibleV=2.6.1
RUN pip install ansible==$AnsibleV
RUN adduser ansible --no-create-home --uid 2020 --system
