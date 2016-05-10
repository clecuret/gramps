FROM ubuntu:xenial
MAINTAINER clecuret <clecuret@gmail.com>
RUN apt-get update  && apt-get install -y -qq gramps libcanberra-gtk-module && apt-get -y clean && rm -rf /var/lib/apt/lists/*
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["gramps"]
