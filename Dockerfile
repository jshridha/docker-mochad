FROM phusion/baseimage

RUN \
  apt-get update && \
  apt-get install -y cmake apt-utils build-essential && \
  apt-get install -y libusb-1.0-0-dev supervisor && \
  apt-get clean -y

# Define working directory.
WORKDIR /root

ADD mochad-0.1.16.tar.gz /root/
  
RUN \
  cd mochad-0.1.16 && ./configure && make && make install

# Cleaup
RUN rm -rf /root/*

ADD *.conf /etc/supervisor/conf.d/

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf", "-n"]