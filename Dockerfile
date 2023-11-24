FROM debian:stable-slim

LABEL maintainer="info@crowdrender.com.au"

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
    # Blender dependencies
    libxi6 \
    libxrender1 \
    libglu1-mesa \
    libgl1-mesa-glx \
    libxxf86vm1 \
    libxkbcommon0 \
    libsm6 \
    # other dependencies
    ca-certificates \
    gnupg2 \
    # some useful utils
    xz-utils \
    screen \
    unzip \
    7zip \
    curl \
    vim \
    jq

# probably not needed, but adding anyway for now
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
  && \
    apt-get update
RUN apt-get install -y nvidia-container-toolkit

# cleanup
RUN \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    apt-get purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Blender variables used for specifying the blender version

ARG BLENDER_OS="linux-x64"
ARG BL_VERSION_SHORT="4.0"
ARG BL_VERSION_FULL="4.0.1"
ARG BL_DL_ROOT_URL="https://mirrors.ocf.berkeley.edu/blender/release/"
ARG BLENDER_DL_URL=${BL_DL_ROOT_URL}/Blender${BL_VERSION_SHORT}/blender-${BL_VERSION_FULL}-${BLENDER_OS}.tar.xz


RUN echo "Blender Download URL is $BLENDER_DL_URL"
RUN echo ${BLENDER_DL_URL}

# Set the working directory where we'll unpack blender
WORKDIR /usr/local/blender

# Download and unpack Blender
RUN curl -SL $BLENDER_DL_URL -o blender.tar.xz \
        && tar -xf blender.tar.xz --strip-components=1 && rm blender.tar.xz;

# Set environment vars to be used when the image is running in a container
ENV use_local_cr false
ENV cr_version latest
ENV persistent false
ENV BL_VERSION_SHORT ${BL_VERSION_SHORT}

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

WORKDIR /CR

ADD scripts/start_cr_server.sh .
ADD scripts/install_addon.py .

RUN chmod +x ./start_cr_server.sh
RUN chmod -R 777 /CR

ENTRYPOINT /CR/start_cr_server.sh
