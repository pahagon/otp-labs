# The version of Alpine to use for the final image
# This should match the version of Alpine that the `elixir:1.13.4-alpine` image uses
ARG ALPINE_VERSION=3.16

FROM elixir:1.13.4-alpine AS builder

# The environment to build with
ENV MIX_ENV=prod

# By convention, /opt is typically used for applications
WORKDIR /opt/app

# This step installs all the build tools we'll need
RUN apk update && \
  apk upgrade --no-cache && \
  mix local.rebar --force && \
  mix local.hex --force

# Cache elixir deps
ADD . .

# Fetch dependencies, Build project
RUN mix deps.get --only ${MIX_ENV}
RUN mix compile

# Build release
RUN mix release 

# From this line onwards, we're in a new image, which will be the image used in production
FROM alpine:${ALPINE_VERSION}

# The name of your application/release (required)
ARG APP_NAME=<%= @project_name %>
ARG MIX_ENV=prod

RUN apk update && \
    apk add --no-cache bash openssl-dev ncurses-libs libgcc libstdc++

ENV REPLACE_OS_VARS=true \
    APP_NAME=${APP_NAME} \
    MIX_ENV=${MIX_ENV}

WORKDIR /opt/app

# This copies our app source code into the build container
COPY --from=builder /opt/app/_build/${MIX_ENV}/rel/${APP_NAME} /opt/app/

ENTRYPOINT /opt/app/bin/${APP_NAME} start

