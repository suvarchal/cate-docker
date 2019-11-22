FROM continuumio/miniconda3:latest

ARG CATE_VERSION=2.0.0
ARG CATE_USER_NAME=cate

ENV CATE_VERSION=${CATE_VERSION}
ENV USER_NAME=${CATE_USER_NAME}

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name=cate
LABEL version=${CATE_VERSION}

SHELL ["bash", "-c"]

RUN groupadd -g 1000 ${CATE_USER_NAME}
RUN useradd -u 1000 -g 1000 -ms /bin/bash ${CATE_USER_NAME}
RUN mkdir /workspace && chown ${CATE_USER_NAME}.${CATE_USER_NAME} /workspace
RUN chown -R ${CATE_USER_NAME}.${CATE_USER_NAME} /opt/conda

USER ${CATE_USER_NAME}

# RUN conda create -n cate -c ccitools -c conda-forge cate-cli=${CATE_VERSION}

RUN git clone https://github.com/CCI-Tools/cate /tmp/cate
WORKDIR /tmp/cate
RUN conda env create
RUN source activate cate-env && python setup install

WORKDIR /workspace

RUN conda init

RUN echo "conda activate cate" >> ~/.bashrc

ENTRYPOINT ["/bin/bash", "-c"]
