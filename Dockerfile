FROM ubuntu:18.04

#########################################
### Python                                                               
RUN apt-get update && apt-get -y install git wget build-essential
RUN apt-get install -y python3 python3-pip
RUN ln -s python3 /usr/bin/python
RUN ln -s pip3 /usr/bin/pip
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y python3-tk

#########################################
### Node 12 and yarn
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get update && apt-get install -y nodejs
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
### Install reactopya
RUN pip install reactopya==0.10.0

RUN mkdir /src

### Clone and install ccm_widgets
RUN git clone https://github.com/flatironinstitute/ccm_widgets /src/ccm_widgets \
    && cd /src/ccm_widgets \
    && git checkout a87b93fcc06ddb32b9382123942ff13088f9ee46

WORKDIR /src/ccm_widgets
RUN reactopya install-jupyter
RUN pip install ipywidgets

COPY webapp /webapp

EXPOSE 8080

CMD reactopya-server /webapp/ccm_widgets.json --port 8080