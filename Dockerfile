FROM alpine
MAINTAINER Jay Shridharani <jshridha@gmail.com>

RUN apk add --update --no-cache gcc g++ cmake make wget libusb-dev && \
      mkdir /build && cd /build && \
      wget -O mochad.tgz http://sourceforge.net/projects/mochad/files/latest/download && \
      tar -xzvf mochad*.t* && \
      cd mochad* && ./configure && make && make install && \
      apk --purge del gcc g++ cmake make wget && \
      rm -rf /var/cache/apk/* /lib/apk/db/*

CMD ["mochad", "-d"]

