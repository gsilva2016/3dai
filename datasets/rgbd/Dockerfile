FROM ubuntu:22.04

RUN if [ -n "$HTTP_PROXY" ] ; then  echo "Acquire::http::Proxy \"$HTTP_PROXY\";" >  /etc/apt/apt.conf; fi

RUN apt-get update -y || true; DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    autoconf \
    git \
    libssl-dev \
    libusb-1.0-0-dev \
    libudev-dev \
    pkg-config \
    libgtk-3-dev \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    nasm \
    ninja-build \
    cmake  \
    python3  \
    python3-pip  \
    python3-dev \
    meson \
    flex \
    bison && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade meson as the gstreamer needs later version
RUN  echo "upgrading meson to the latest version..." && pip3 install --user meson --upgrade

RUN mkdir -p /rs && cd /rs && git clone https://github.com/IntelRealSense/librealsense.git
# git clone https://github.com/gwen2018/librealsense.git

#RUN  cd /rs/librealsense && \
#    git checkout stream_d436_b
#COPY ./patch/libusb.h /rs/librealsense/src/libusb/libusb.h

RUN cd /rs/librealsense && mkdir build && \
    cd build/ && \
    cmake ../ \
        -DBUILD_SHARED_LIBS=true \
        -DBUILD_WITH_JPEGTURBO=true \
        -DBUILD_PYTHON_BINDINGS:bool=true \
        -DBUILD_WITH_CUDA=false \
        -DFORCE_RSUSB_BACKEND=false \
        -DPYTHON_EXECUTABLE=/usr/bin/python3 \
        -DBUILD_GLSL_EXTENSIONS=true \
        -DBUILD_WITH_CPU_EXTENSIONS=true \
        -DBUILD_UNIT_TESTS=false \
	-DBUILD_GRAPHICAL_EXAMPLES=true \
	-DCMAKE_BUILD_TYPE=Release && \
    make -j$(cat /proc/cpuinfo |grep -c proc) && \
    make install && \
    export PYTHONPATH="$PYTHONPATH":/usr/lib/python3/dist-packages/pyrealsense2 && \
    python3 -c "import pyrealsense2 as rs; print(rs)"

# RUN mv /rs/librealsense/build/libjpeg-turbo/lib/libturbojpeg.so* /usr/local/lib


