FROM roypur/debian-raspberrypi-builder
COPY ["src", "/builder"]
RUN ["chmod", "-R", "755", "/builder"]

WORKDIR /builder
ENTRYPOINT ["/builder/build.sh"]
