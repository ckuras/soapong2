FROM debian:bookworm-slim

USER root

RUN apt-get update
RUN apt-get install -y wget unzip llvm clang

RUN wget https://github.com/odin-lang/Odin/releases/download/dev-2024-07/odin-ubuntu-amd64-dev-2024-07.zip
RUN unzip odin-ubuntu-amd64-dev-2024-07.zip
RUN unzip dist.zip

ENTRYPOINT ["/dist/odin"]
