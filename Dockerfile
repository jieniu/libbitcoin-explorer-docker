# 中科大ubuntu base，无需设置deb源
FROM ustclug/ubuntu:16.04 as build

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y g++-4.8 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50 \
    && update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.8 50 \
    && apt-get install build-essential autoconf automake libtool pkg-config git -y \
    && apt-get install wget libboost-all-dev -y \
    && wget https://raw.githubusercontent.com/libbitcoin/libbitcoin-explorer/version3/install.sh \
    && chmod +x install.sh \
    && ./install.sh

FROM frolvlad/alpine-glibc
COPY --from=build /lib/x86_64-linux-gnu/* /lib/x86_64-linux-gnu/
COPY --from=build /lib64 /
COPY --from=build /usr/lib/x86_64-linux-gnu/* /usr/lib/x86_64-linux-gnu/
COPY --from=build /usr/local/lib/* /usr/local/lib/
COPY --from=build /usr/local/bin/* /usr/local/bin/

RUN sed -i '$a\/usr/lib/x86_64-linux-gnu' /usr/glibc-compat/etc/ld.so.conf && \
    sed -i '$a\/lib/x86_64-linux-gnu' /usr/glibc-compat/etc/ld.so.conf && \
    sed -i '$a\/lib64' /usr/glibc-compat/etc/ld.so.conf && \
    /usr/glibc-compat/sbin/ldconfig
