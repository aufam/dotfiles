FROM debian:bookworm-slim

ENV CPM_SOURCE_CACHE=/root/.cache/CPM

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    g++ \
    build-essential \
    ninja-build \
    cmake \
    ca-certificates \
    libssl-dev \
    git

