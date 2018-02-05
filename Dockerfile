# Setups Nvidia GPU installation and a particle picker for cryp-em images
# based on a deep neural network https://github.com/nejyeah/DeepPicker-python
FROM nvidia/cuda:7.5-cudnn4-devel-ubuntu14.04

MAINTAINER Thorsten Wagner (https://github.com/thorstenwagner)

ENV DEBIAN_FRONTEND noninteractive

### Get package updates
RUN apt-get update

#### Install basic  tools
RUN apt-get install -y wget locate software-properties-common python-software-properties python-pip python-dev python-virtualenv
# 0.12.0: https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.12.1-cp27-none-linux_x86_64.whl
# 0.10.0 https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.10.0-cp27-none-linux_x86_64.whl
RUN virtualenv --system-site-packages ~/tensorflow; source ~/tensorflow/bin/activate; pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.8.0-cp27-none-linux_x86_64.whl

#### Install other software
RUN apt-get install -y python-matplotlib python-scipy git
RUN git clone https://github.com/nejyeah/DeepPicker-python.git
