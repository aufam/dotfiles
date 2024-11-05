FROM debian:bookworm-slim

ENV CPM_SOURCE_CACHE=/root/.cache/CPM

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    g++ \
    cmake \
    ninja-build \
    ca-certificates \
    libssl-dev \
    libsqlite3-dev \
    libpq-dev \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

