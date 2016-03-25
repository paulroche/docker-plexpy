FROM ubuntu:14.04

MAINTAINER Paul Roche <paul@dreamisle.ca>

RUN apt-get -qq update             \
 && apt-get -yf install supervisor \
                        git        \
 && rm -fr /var/lib/apt/lists/*

# clone repo
RUN git clone https://github.com/drzoidberg33/plexpy.git /plexpy

# add supervisor file for application
COPY assets/configs/supervisor/plexpy.conf /etc/supervisor/conf.d/

COPY assets/scripts/startup.sh /opt/startup.sh

ENTRYPOINT [ "/opt/startup.sh" ]
