#docker run -ti --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidia1:/dev/nvidia1 --device /dev/nvidia2:/dev/nvidia2 --device /dev/nvidia3:/dev/nvidia3 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm --device /dev/nvidia-uvm:/dev/nvidia-uvm --device /dev/nvidia-uvm-tools:/dev/nvidia-uvm-tools thorstenwagner/docker-deeppicker /bin/bash

FROM nvidia/cuda

MAINTAINER Thorsten Wagner (https://github.com/thorstenwagner)

ENV UBUNTU_FRONTEND noninteractive

RUN apt-get update
RUN apt-get wget

# Install cude toolkit 7.5
RUN wget --no-check-certificate https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
RUN sh cuda_9.0.176_384.81_linux-run --silent


# Install cuDNN
RUN wget --no-check-certificate https://owncloud.gwdg.de/index.php/s/PKa6F4bFFX871dJ/download
RUN mv download cudnn.tgz
RUN tar xvzf cudnn.tgz
RUN cp cuda/include/cudnn.h /usr/local/cuda/include/
RUN cp cuda/lib64/libcudnn* /usr/local/cuda/lib64 
RUN chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn.so

RUN apt-get install -y python-pip python-dev python-virtualenv
RUN virtualenv --system-site-packages ~/tensorflow
RUN source ~/tensorflow/bin/activate; pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.9.0-cp27-none-linux_x86_64.whl

