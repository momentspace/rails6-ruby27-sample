FROM ruby:2.7.2-alpine

WORKDIR /app

COPY Gemfile* ./

ENV RUNTIME_PACKAGES="linux-headers libxml2-dev make gcc libc-dev nodejs tzdata postgresql-dev postgresql git" \
                      DEV_PACKAGES="build-base curl-dev" \
                      HOME=/${WORKDIR} \
                      LANG=C.UTF-8 \
                      TZ=Asia/Tokyo

RUN apk update && \
      apk upgrade && \
      apk add --no-cache ${RUNTIME_PACKAGES} && \
      apk add --virtual build-dependencies --no-cache ${DEV_PACKAGES} && \
      bundle && \
      apk del build-dependencies

