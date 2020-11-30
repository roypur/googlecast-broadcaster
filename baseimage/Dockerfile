FROM debian:bullseye-slim as setup
COPY ["src/50-headless.conf", "/builder/50-headless.conf"]
COPY ["src/sources.list", "/builder/sources.list"]
COPY ["src/install.sh", "/builder/install.sh"]
COPY ["src/sfdisk.dump", "/builder/sfdisk.dump"]
COPY ["src/network.py", "/builder/network.py"]
COPY ["src/format.sh", "/disk/format.sh"]
COPY ["src/finish.sh", "/disk/finish.sh"]
COPY ["src/rootfs", "/disk/base"]
COPY ["src/rootfs-pre", "/disk/base-pre"]
RUN ["bash", "/builder/install.sh"]
FROM scratch
COPY --from=setup / /
