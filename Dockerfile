FROM --platform=linux/amd64 ubuntu:22.04 AS napari
# if you change the Ubuntu version, remember to update
# the APT definitions for Xpra below so it reflects the
# new codename (e.g. 20.04 was focal, 22.04 had jammy)

# below env var required to install libglib2.0-0 non-interactively
ENV TZ=America/Los_Angeles
ARG DEBIAN_FRONTEND=noninteractive

# install python resources + graphical libraries used by qt and vispy
RUN apt-get update && \
    apt-get install -qqy  \
        build-essential \
        python3.9 \
        python3-pip \
        git \
        mesa-utils \
        libgl1-mesa-glx \
        libglib2.0-0 \
        libfontconfig1 \
        libxrender1 \
        libdbus-1-3 \
        libxkbcommon-x11-0 \
        libxi6 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-randr0 \
        libxcb-render-util0 \
        libxcb-xinerama0 \
        libxcb-xinput0 \
        libxcb-xfixes0 \
        libxcb-shape0 \
        && apt-get clean

# install napari release version
RUN pip3 install napari[all]

ENTRYPOINT ["python3", "-m", "napari"]


#RUN git clone https://github.com/salkmanorlab/napari-bootstrapper.git \
#    && pip3 install napari-bootstrapper