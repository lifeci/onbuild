#!/bin/bash
docker build -t lifeci/onbuild:latest .
docker run --rm lifeci/onbuild:latest
docker push lifeci/onbuild:latest
