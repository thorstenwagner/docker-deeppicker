# Setups Nvidia GPU installation and a particle picker for cryp-em images
# based on a deep neural network https://github.com/nejyeah/DeepPicker-python
# Furthermore this image contains PyCharm, a running ssh-server, screen, and xpar
FROM nvidia/cuda:8.0-cudnn7-runtime-ubuntu16.04

MAINTAINER Thorsten Wagner (https://github.com/thorstenwagner)

ENV DEBIAN_FRONTEND noninteractive

### Get package updates
RUN apt-get update

#### Install basic  tools
RUN apt-get install -y wget locate software-properties-common python-software-properties

