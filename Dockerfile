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

# Pre-install some python libraries
RUN pip install vtk
RUN pip install sklearn

#########################################
### Install reactopya
RUN pip install reactopya==0.10.3

RUN mkdir /src

### Clone and install ccm_widgets
RUN git clone https://github.com/flatironinstitute/ccm_widgets /src/ccm_widgets \
    && cd /src/ccm_widgets \
    && git checkout cdc137488c2df83f792f8a3984777b6093d8736b

WORKDIR /src/ccm_widgets
RUN reactopya install && find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +
# RUN pip install ipywidgets

### Clone and install kachery_widgets
RUN git clone https://github.com/flatironinstitute/kachery /src/kachery \
    && cd /src/kachery \
    && git checkout cf9d88b2ace8d1f2087336c372b63bffb5df4dc5

WORKDIR /src/kachery/kachery_widgets
RUN reactopya install && find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +

COPY webapp /webapp

EXPOSE 8080

CMD reactopya-server /webapp/webapp.json --port 8080