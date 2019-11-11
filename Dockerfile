FROM ubuntu:18.04

#########################################
### Python                                                               
RUN apt-get update && apt-get -y install git wget build-essential
RUN apt-get install -y python3 python3-pip
RUN ln -s python3 /usr/bin/python
RUN ln -s pip3 /usr/bin/pip
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-tk

#########################################
### Node and yarn
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && apt-get install -y nodejs
RUN npm install -g yarn

#########################################
### opengl and other
RUN apt-get update && apt-get install -y libgl1-mesa-glx
RUN apt-get install -y libsm6 libxext6 libxrender-dev

#########################################
### Numpy
RUN pip install numpy

#########################################
### Make sure we have python3 and a working locale
RUN rm /usr/bin/python && ln -s python3 /usr/bin/python && rm /usr/bin/pip && ln -s pip3 /usr/bin/pip
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
RUN apt-get install -y locales && locale-gen en_US.UTF-8

#########################################
### Install ephys_viz
RUN pip install ephys_viz==0.9.0

#########################################
### Install ccm_widgets
RUN pip install ccm_widgets==0.4.10

COPY main.py /working/main.py

EXPOSE 8080

CMD ["python", "/working/main.py"]