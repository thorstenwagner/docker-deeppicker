# Setups Nvidia GPU installation and a particle picker for cryp-em images
# based on a deep neural network https://github.com/nejyeah/DeepPicker-python
# Furthermore this image contains PyCharm, a running ssh-server, screen, and xpar
FROM nvidia/cuda

MAINTAINER Thorsten Wagner (https://github.com/thorstenwagner)

ENV DEBIAN_FRONTEND noninteractive

### Get package updates
RUN apt-get update

#### Install basic  tools
RUN apt-get install -y wget locate software-properties-common python-software-properties

### Setup ssh server
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

### Install PyCharm for development
RUN add-apt-repository -y ppa:mystic-mirage/pycharm
RUN apt-get update
RUN apt install -y pycharm-community

### Install xpra
RUN wget -q http://winswitch.org/gpg.asc -O- | apt-key add - 
RUN add-apt-repository  -y 'deb http://winswitch.org/ xenial main'
RUN apt-get update
RUN apt-get install -y  xpra

### Install cude toolkit 9.0
# Cuda toolkit v9.0 https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run
# Cuda toolkit v8.0: https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
RUN wget --no-check-certificate  https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run
RUN sh cuda_8.0.61_375.26_linux-run --silent


### Install cuDNN
#https://owncloud.gwdg.de/index.php/s/LY84GWPbPoJF7Lm/download    cuda toolkit 9 cudnn V7
#https://owncloud.gwdg.de/index.php/s/G6AAFa5Q3pLh9pr/download    cuda toolkit 8 cudnn V7
#https://owncloud.gwdg.de/index.php/s/PKa6F4bFFX871dJ/download    cudnn v4
RUN wget --no-check-certificate https://owncloud.gwdg.de/index.php/s/G6AAFa5Q3pLh9pr/download
RUN mv download cudnn.tgz
RUN tar xvzf cudnn.tgz
RUN cp cuda/include/cudnn.h /usr/local/cuda/include/
RUN cp cuda/lib64/libcudnn* /usr/local/cuda/lib64 
RUN chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn.so

RUN apt-get install -y python-pip python-dev python-virtualenv
RUN virtualenv --system-site-packages ~/tensorflow
RUN source ~/tensorflow/bin/activate; pip install --upgrade tensorflow-gpu

