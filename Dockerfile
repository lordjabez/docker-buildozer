FROM ubuntu:17.10

ENV BUILDOZER_LOG_LEVEL 2
ENV BUILDOZER_WARN_ON_ROOT 0

RUN dpkg --add-architecture i386 \
 && apt-get update && apt-get -y full-upgrade \
 && apt-get -y install --no-install-recommends \
      build-essential \
      curl \
      git \
      lib32ncurses5 \
      lib32stdc++6 \
      lib32z1 \
      openjdk-8-jdk \
      python-pip \
      python-setuptools \
      unzip \
      zlib1g-dev \
 && apt-get autoremove && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install --no-cache-dir \
      buildozer==0.32 \
      cython==0.25.1 \
      pyOpenssl \
      python-for-android

ADD hello /buildozer/hello

RUN cd /buildozer/hello \
 && buildozer android release \
 && cd .. \
 && rm -rf hello

VOLUME /buildozer/
WORKDIR /buildozer/

ENTRYPOINT ["buildozer"]
