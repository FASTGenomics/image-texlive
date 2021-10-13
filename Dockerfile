FROM ubuntu:focal

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt install -y --no-install-recommends \
    tex-common \
    texinfo \
    equivs \
    perl-tk \
    perl-doc \
    wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY texlive.profile /tmp/

RUN cd /tmp/ && \
    wget --no-check-certificate -O - -- mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar xzf - --strip-components=1 && \
    perl install-tl --profile texlive.profile && \
    tlmgr install newtx && \
    rm -rf /tmp/*


CMD ["bash"]
