ARG MINICONDA_VERSION=4.7.12

FROM continuumio/miniconda3:$MINICONDA_VERSION

ARG CATE_VERSION=2.1.0.dev0
ARG CATE_BUILD=1
ARG CATE_BRANCH=master_dev_3
ARG CATE_USER_NAME=root

LABEL maintainer="helge.dzierzon@brockmann-consult.de"
LABEL name="cate python minoconda base"

SHELL ["/bin/bash", "-c"]

# RUN apt-get -y update && apt-get -y upgrade

#RUN groupadd -g 1000 ${CATE_USER_NAME}
#RUN useradd -u 1000 -g 1000 -ms /bin/bash ${CATE_USER_NAME}
#RUN mkdir /workspace && chown ${CATE_USER_NAME}.${CATE_USER_NAME} /workspace
# RUN chown -R ${CATE_USER_NAME}.${CATE_USER_NAME} /opt/conda

WORKDIR /tmp

USER ${CATE_USER_NAME}

RUN conda init

RUN echo "conda activate cate-env" >> ~/.bashrc

RUN git clone https://github.com/CCI-Tools/cate && cd cate && git checkout ${CATE_BRANCH}
RUN conda env create -f cate/environment.yml
RUN conda clean -afy
RUN conda info --envs
RUN source activate cate-env
RUN conda list
RUN source activate cate-env && pip install git+https://github.com/CCI-Tools/cate.git@${CATE_BRANCH}

WORKDIR /workspace

CMD ["/bin/bash", "-c", "source activate cate-env && cate-webapi-start -v -p 4000 -a 0.0.0.0"]



