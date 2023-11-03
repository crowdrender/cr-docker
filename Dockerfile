FROM debian:stable-slim

LABEL maintainer="info@crowdrender.com.au"

RUN apt-get update 	&& apt-get install -y \
	curl

RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
  && \
    sudo apt-get update

# Run installs on required dependencies for Blender
RUN apt-get update 	&& apt-get install -y \
    libfreetype6 \
    libglu1-mesa \
    libgl1-mesa-dev \
    libxi6 \
    libxrender1 \
    xz-utils \
    nvidia-container-toolkit \
    && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Blender variables used for specifying the blender version

ARG BLENDER_OS="linux-x64"
ARG BL_VERSION_SHORT="3.6"
ARG BL_VERSION_FULL="3.6.5"
ARG BLENDER_DL_URL=https://download.blender.org/release/Blender${BL_VERSION_SHORT}/blender-${BL_VERSION_FULL}-${BLENDER_OS}.tar.xz


RUN echo "Blender URL is $BLENDER_DL_URL"
RUN echo ${BLENDER_DL_URL}

# Set the working directory where we'll unpack blender
WORKDIR /usr/local/blender

# Download and unpack Blender
RUN curl -SL "$BLENDER_DL_URL" -o blender.tar.xz \
    && tar -xf blender.tar.xz --strip-components=1 && rm blender.tar.xz


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

ENTRYPOINT /CR/scripts/start_cr_server.sh
