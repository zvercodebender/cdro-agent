ARG TAG="${TAG}"
FROM cloudbees/cbflow-agent:${TAG}


USER root

RUN mkdir /opt/cbflow/grape && \
    chown cbflow:cbflow /opt/cbflow/grape

RUN mkdir /home/cbflow \
&&  chown cbflow:cbflow /home/cbflow \
&&  sed -i "s/\/tmp/\/home\/cbflow/g" /etc/passwd

ENV HOME=/home/cbflow
ENV PS1="[\u@\h \W]\$ "

USER cbflow
