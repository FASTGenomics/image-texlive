FROM ubuntu:impish

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
    tex-common \
    texinfo \
    dvipost \
    equivs \
    perl-tk \
    perl-doc \
    locales \
    wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8 && \
    locale-gen de_DE.utf8 && \
    update-locale LANG=en_US.UTF-8

COPY texlive.profile /tmp/

RUN cd /tmp/ && \
    wget --no-check-certificate -O - -- mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar xzf - --strip-components=1 && \
    perl install-tl --profile texlive.profile && \
    tlmgr install newtx && \
    rm -rf /tmp/*

CMD ["bash"]
