FROM ubuntu:20.04

RUN apt-get update -qqy \
    && apt-get -qqy install wget libarchive-tools genisoimage syslinux-utils

RUN wget https://cdimage.debian.org/cdimage/bullseye_di_alpha3/amd64/iso-cd/debian-bullseye-DI-alpha3-amd64-netinst.iso
RUN mkdir /tmp/iso && cat  debian-bullseye-DI-alpha3-amd64-netinst.iso | bsdtar -C "/tmp/iso" -xf - \
    && chmod -R +w /tmp/iso
ADD preseed.cfg /tmp/iso/preseed.cfg
ADD txt.cfg /tmp/iso/isolinux/txt.cfg

RUN genisoimage -r -J -b isolinux/isolinux.bin -c isolinux/boot.cat  -no-emul-boot -boot-load-size 4 -boot-info-table -o ShapeOS-base-on-debian-buster-DI-alpha4-amd64-netinst.iso /tmp/iso/
RUN isohybrid ShapeOS-base-on-debian-buster-DI-alpha4-amd64-netinst.iso && mkdir -p /upload 

CMD [ "cp", "ShapeOS-base-on-debian-buster-DI-alpha4-amd64-netinst.iso", "/upload" ]

