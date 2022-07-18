FROM zocker160/blender:latest

MAINTAINER zocker-160

ENV CR_VERSION latest
ENV persistent "false"
ENV local "false"

RUN apt-get update && apt-get install -y jq

WORKDIR /CR

ADD scripts/start_cr_server.sh .
ADD scripts/install_addon.py .

RUN chmod +x ./start_cr_server.sh
RUN chmod -R 777 /CR

ENTRYPOINT /CR/start_cr_server.sh
