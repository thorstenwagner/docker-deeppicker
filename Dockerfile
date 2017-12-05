FROM nvidia/cuda

MAINTAINER Thorsten Wagner (https://github.com/thorstenwagner)

ENV UBUNTU_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y wget

# Install cude toolkit 7.5
RUN wget --no-check-certificate https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
RUN sh cuda_9.0.176_384.81_linux-run --silent


# Install cuDNN
#https://owncloud.gwdg.de/index.php/s/LY84GWPbPoJF7Lm cudnn V9
#https://owncloud.gwdg.de/index.php/s/PKa6F4bFFX871dJ/download cudnn v4
RUN wget --no-check-certificate https://owncloud.gwdg.de/index.php/s/LY84GWPbPoJF7Lm/download
RUN mv download cudnn.tgz
RUN tar xvzf cudnn.tgz
RUN cp cuda/include/cudnn.h /usr/local/cuda/include/
RUN cp cuda/lib64/libcudnn* /usr/local/cuda/lib64 
RUN chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn.so

RUN apt-get install -y python-pip python-dev python-virtualenv
RUN virtualenv --system-site-packages ~/tensorflow
RUN source ~/tensorflow/bin/activate; pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.9.0-cp27-none-linux_x86_64.whl

