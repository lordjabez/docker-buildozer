FROM ubuntu:17.10

ENV BUILDOZER_LOG_LEVEL 2

RUN apt-get update && apt-get -y full-upgrade \
 && apt-get autoremove && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && dpkg --add-architecture i386 && apt-get update \
 && apt-get -y install \
      build-essential \
      curl \
      lib32ncurses5 \
      lib32stdc++6 \
      lib32z1 \
      python-pip \
      python-setuptools \
      unzip \
 && apt-get -y install \
      git \
      openjdk-8-jdk \
      --no-install-recommends zlib1g-dev \
 && apt-get autoremove && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install -U pip \
 && pip install --no-cache-dir \
      cython==0.25.2 \
 && pip install --no-cache-dir \
      buildozer==0.34 \
      pyOpenssl \
      python-for-android \
 && sed -i 's/if is_gradle_build:/if False:/' /usr/local/lib/python2.7/dist-packages/buildozer/targets/android.py

ADD hello /buildozer/hello

RUN adduser buildozer --disabled-password --disabled-login \
 && chown -R buildozer:buildozer /buildozer/

USER buildozer

RUN cd /buildozer/hello \
 && buildozer android release \
 && cd .. \
 && rm -rf hello

VOLUME /buildozer/
WORKDIR /buildozer/

ENTRYPOINT ["buildozer"]
