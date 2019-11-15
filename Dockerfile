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

# Pre-install some python packages
RUN pip install jupyter scipy vtk imageio imageio-ffmpeg sklearn h5py pandas ipywidgets
RUN pip install mountaintools
RUN pip install isosplit5 rlcluster
RUN pip install kachery==0.3.5
RUN pip install h5_to_json==0.1.5

#########################################
### Install reactopya
RUN git clone https://github.com/flatironinstitute/reactopya /src/reactopya \
    && cd /src/reactopya \
    && git checkout 38f77b35ab3a9fcc190bd8f2f7182b03786615eb
WORKDIR /src/reactopya
RUN pip install -e .
RUN cd reactopya/reactopya_server && yarn install && yarn build && find . -name 'node_modules' -type d -prune -exec rm -rf '{}' + && rm -rf /tmp/* && yarn cache clean

### Clone and install ccm_widgets
RUN git clone https://github.com/flatironinstitute/ccm_widgets /src/ccm_widgets \
    && cd /src/ccm_widgets \
    && git checkout cdc137488c2df83f792f8a3984777b6093d8736b
WORKDIR /src/ccm_widgets
RUN reactopya install && find . -name 'node_modules' -type d -prune -exec rm -rf '{}' + && rm -rf /tmp/* && yarn cache clean

### Clone and install kachery_widgets
RUN git clone https://github.com/flatironinstitute/kachery /src/kachery \
    && cd /src/kachery \
    && git checkout 489811741e922de9c3270f9b23e1e3bccb122f17
WORKDIR /src/kachery/kachery_widgets
RUN reactopya install && find . -name 'node_modules' -type d -prune -exec rm -rf '{}' + && rm -rf /tmp/* && yarn cache clean

### Clone and install ephys_viz
RUN git clone https://github.com/flatironinstitute/ephys-viz /src/ephys-viz \
    && cd /src/ephys-viz \
    && git checkout 235b88183b548cf43d6ef5632e233859755f2d7b
WORKDIR /src/ephys-viz
RUN reactopya install && find . -name 'node_modules' -type d -prune -exec rm -rf '{}' + && rm -rf /tmp/* && yarn cache clean

COPY webapp /webapp

EXPOSE 8080

CMD reactopya-server /webapp/webapp.json --port 8080