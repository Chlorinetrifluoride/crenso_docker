FROM ubuntu:22.04

RUN apt update && apt install -y \
 bc \
 gawk \
 libopenmpi-dev \
 openbabel \
 openmpi-bin \
 openmpi-common \
  && rm -rf /var/lib/apt/lists/*

# prepare directory structure
RUN mkdir /crenso && mkdir /crenso/wd && mkdir /dependencies && mkdir /dependencies/orca  # 
WORKDIR /crenso/wd
ENV HOME /crenso
# copy and prepare dependencies
#COPY --from=compile /dependencies/openmpi /dependencies/openmpi
COPY ./dependencies/xtb /dependencies/xtb

COPY ./dependencies/censo /dependencies/censo

COPY ./dependencies/crest /dependencies/crest

COPY ./config/.censorc /crenso/.censorc

COPY ./dependencies/crenso /dependencies/crenso

COPY ./dependencies/crest_combi /dependencies/crest_combi

RUN chmod +x /dependencies/censo && chmod +x /dependencies/crest_combi 

# Add to PATH
ENV PATH "$PATH:/dependencies/xtb/bin"
ENV PATH "$PATH:/dependencies"
ENV PATH "$PATH:/dependencies/orca"
#ENV PATH "$PATH:/dependencies/openmpi/bin"
# omp settings
ENV OMPI_ALLOW_RUN_AS_ROOT 1
ENV OMPI_ALLOW_RUN_AS_ROOT_CONFIRM 1
#ENV OMP_STACKSIZE "8G"
#ENV OMP_NUM_THREADS "2"
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
