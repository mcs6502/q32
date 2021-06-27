# prepares a temporary image with rlwrap distribution in /root/rlwrapdist/
FROM docker.io/oraclelinux:8-slim
RUN microdnf -y install oracle-epel-release-el8
RUN microdnf -y install rlwrap tar
RUN mkdir /root/rlwrapdist/
RUN (cd /usr && gtar cpf - bin/rlwrap share/rlwrap) | (cd /root/rlwrapdist/ && gtar xpf -)

# builds an image with 32-bit kdb+/q, line editing support and /data mounted on a volume
FROM docker.io/oraclelinux:8-slim
RUN microdnf -y install bzip2-libs.i686 libnsl.i686 && rm -fr /var/cache/*
COPY --from=0 /root/rlwrapdist/ /usr/
COPY --from=docker.io/dpollock007/kdb-torq:jenkins /opt/q /root/q
VOLUME /data
COPY q.sh /data/
ENTRYPOINT ["/data/q.sh"]
