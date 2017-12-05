FROM nvidia/cuda

MAINTAINER Thorsten Wagner (https://github.com/thorstenwagner)

ENV UBUNTU_FRONTEND noninteractive

RUN apt-get update
RUN apt-get wget
RUN wget --no-check-certificate https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
RUN sh cuda_9.0.176_384.81_linux-run --silent
apt-get install -y python-pip python-dev python-virtualenv
