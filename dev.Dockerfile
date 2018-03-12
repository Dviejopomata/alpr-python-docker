FROM ubuntu:16.04

# Install prerequisites
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libcurl3-dev \
    libleptonica-dev \
    liblog4cplus-dev \
    libopencv-dev \
    libtesseract-dev \
    python-dev \
    python-pip \
    wget

RUN git clone https://github.com/openalpr/openalpr.git

RUN ls -l
# Copy all data
RUN cp -r  ./openalpr /srv/openalpr

# Setup the build directory
RUN mkdir /srv/openalpr/src/build
WORKDIR /srv/openalpr/src/build

# Setup the compile environment
RUN cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_INSTALL_SYSCONFDIR:PATH=/etc .. && \
    make -j2 && \
    make install

# Install bindings to use openalpr from python
RUN cd /srv/openalpr/src/bindings/python && python setup.py install

WORKDIR /code

EXPOSE 5000
CMD ["bash"]

