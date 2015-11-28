FROM pritunl/archlinux:latest
ADD requirements.txt /opt/requirements.txt
ADD mirrorlist /etc/pacman.d/mirrorlist
ADD . /opt/configs
RUN echo workspace > /etc/hostname && \
    export TZ="/usr/share/zoneinfo/Europe/Berlin" && \
    pacman -S --noconfirm sudo vim-python3 fontconfig make gcc git wget tmux \
    python-pip nodejs npm terminator && \
    echo LANG=de_DE.UTF-8 > /etc/locale.conf && \
    echo de_DE.UTF-8 UTF-8 > /etc/locale.gen && \
    locale-gen && \
    useradd -ms /bin/bash otto && \
    echo "otto:foo" | chpasswd && \
    echo "root:foo" | chpasswd && \
    echo "otto ALL=(ALL) ALL" > /etc/sudoers && \
    pip install -r /opt/requirements.txt && \
    npm install -g bower jscs js-beautify && \
    chown -R otto:users /home/otto && chown -R otto:users /opt
USER otto
WORKDIR /opt/configs
RUN make install
CMD ["/bin/bash"]
