#!/bin/bash
Timeout=$1

# Creating term script for k8s lifecycle.preStop.exec.command:
echo "GOT TERM signal from K8s";

# echo "Drain job qeue during $Timeout"
# ...

# echo "Terminate (force) after $Timeout"
# ...

echo "de-register from Agent Pool";
/vsts/agent/bin/Agent.Listener remove --unattended \
                              --auth PAT --token $( cat /vsts/.token )
