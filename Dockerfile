FROM ruby:2.3

ENV ENTRYKIT_VERSION 0.4.0

WORKDIR /

# entrykit
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes \
  wget
RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz --no-check-certificate\
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y nodejs mysql-client --no-install-recommends

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


COPY ./ /usr/src/app/

RUN bundle config --global frozen 1
RUN bundle install

EXPOSE 3000

ENTRYPOINT [ \
  "prehook", \
    "ruby --version", \
    "ls -alh", \
    "--", \
  "switch", \
    "shell=/bin/bash", \
    "--", \
  "./bin/setup_boot" \
]
