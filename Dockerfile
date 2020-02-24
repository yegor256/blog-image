# Copyright (c) 2014-2020 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so. The Software doesn't include files with .md extension.
# That files you are not allowed to copy, distribute, modify, publish, or sell.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

FROM yegor256/rultor
MAINTAINER Yegor Bugayenko <yegor256@gmail.com>
LABEL Description="yegor256.com" Vendor="Yegor Bugayenko" Version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN sudo apt-get -y update --fix-missing
RUN sudo apt-get -y install aspell aspell-en
RUN sudo apt-get -y install graphviz
RUN sudo apt-get -y update --fix-missing
RUN sudo apt-get -y install gnuplot
RUN sudo apt-get -y install s3cmd
RUN sudo apt-get -y install fontforge liblapack-dev

RUN sudo apt-get -y install plantuml
COPY plantuml.jar /usr/share/plantuml/plantuml.jar

RUN wget --no-check-certificate --quiet https://cmake.org/files/v3.5/cmake-3.5.1.tar.gz && \
  tar xf cmake-3.5.1.tar.gz && \
  rm -rf _cmake-3.5.1 && \
  mv cmake-3.5.1 _cmake-3.5.1 && \
  cd _cmake-3.5.1 && \
  ./configure && \
  make && \
  make install

RUN git clone https://github.com/htacg/tidy-html5.git _tidy-html5 && \
  cd _tidy-html5/build/cmake && \
  git checkout 5.1.25 && \
  cmake ../.. && \
  make && \
  make install

COPY woff.zip /tmp/woff.zip
RUN unzip /tmp/woff.zip -d _sfnt2woff && \
  cd _sfnt2woff && \
  make && \
  cp sfnt2woff /usr/local/bin/

RUN sudo apt-get -y update --fix-missing
RUN sudo apt-get install -y libxml2-utils

RUN npm install -g cssshrink@0.0.5

RUN /bin/bash -l -c "gem install jgd -v 1.6.5"
