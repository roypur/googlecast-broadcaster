#!/usr/bin/env bash
dir=$(dirname $(realpath $0))

random_name=$(head -c 20 /dev/random | xxd -p)
rm -rf ${dir}/out

docker build --tag googlecast-rpi4 ${dir}
docker run \
    --privileged \
    --name=${random_name} \
    --hostname=googlecast-avahi.purser.it \
    -it googlecast-rpi4

echo ${random_name}
docker cp ${random_name}:/out ${dir}/out
docker rm ${random_name}
