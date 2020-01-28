FROM buildpack-deps:stretch as builder

ENV OTP_VERSION="22.2.3" \
    REBAR3_VERSION="3.13.0"

LABEL org.opencontainers.image.version=$OTP_VERSION

# We'll install the build dependencies for erlang-odbc along with the erlang
# build process:
RUN set -xe \
  && OTP_DOWNLOAD_URL="https://github.com/erlang/otp/archive/OTP-${OTP_VERSION}.tar.gz" \
  && OTP_DOWNLOAD_SHA256="8470fff519d9ffa5defba4e42c3c1e64cd86905313040246d4a6e35799a9e614" \
  && runtimeDeps='libodbc1 \
      libsctp1 \
      libwxgtk3.0' \
  && buildDeps='unixodbc-dev \
      libsctp-dev \
      libwxgtk3.0-dev' \
  && apt-get update \
  && apt-get install -y --no-install-recommends $runtimeDeps \
  && apt-get install -y --no-install-recommends $buildDeps \
  && curl -fSL -o otp-src.tar.gz "$OTP_DOWNLOAD_URL" \
  && echo "$OTP_DOWNLOAD_SHA256  otp-src.tar.gz" | sha256sum -c - \
  && export ERL_TOP="/usr/src/otp_src_${OTP_VERSION%%@*}" \
  && mkdir -vp $ERL_TOP \
  && tar -xzf otp-src.tar.gz -C $ERL_TOP --strip-components=1 \
  && rm otp-src.tar.gz \
  && ( cd $ERL_TOP \
    && ./otp_build autoconf \
    && gnuArch="$(dpkg-architecture --query DEB_HOST_GNU_TYPE)" \
    && ./configure --build="$gnuArch" \
    && make -j$(nproc) \
    && make install ) \
  && find /usr/local -name examples | xargs rm -rf \
  && apt-get purge -y --auto-remove $buildDeps \
  && rm -rf $ERL_TOP /var/lib/apt/lists/*

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.10.0" \
  LANG=C.UTF-8

RUN set -xe \
  && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
  && ELIXIR_DOWNLOAD_SHA256="6f0d35acfcbede5ef7dced3e37f016fd122c2779000ca9dcaf92975b220737b7" \
  && curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
  && echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
  && mkdir -p /usr/local/src/elixir \
  && tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
  && rm elixir-src.tar.gz \
  && cd /usr/local/src/elixir \
  && make install clean
