#!/bin/bash
# Creating term script for k8s lifecycle.preStop.exec.command:
/vsts/agent/bin/Agent.Listener remove --unattended \
                              --auth PAT --token $( cat /vsts/.token )
kill $( cat /vst/PID ) 
