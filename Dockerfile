FROM archlinux/archlinux:base-devel

RUN pacman -Syu --noconfirm --needed git sudo

RUN echo "container ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN useradd --create-home container
USER container

RUN git clone https://aur.archlinux.org/yay /tmp/yay
WORKDIR /tmp/yay
RUN makepkg -si --noconfirm
RUN rm -r /tmp/yay


RUN yay -Sy --noconfirm clang
RUN yay -S --noconfirm python2 --mflags "--nocheck"
RUN yay -S --noconfirm libsndfile gnaural

WORKDIR /home/container

ENTRYPOINT gnaural
