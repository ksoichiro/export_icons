FROM ubuntu:12.04

RUN apt-get update -qq
RUN apt-get upgrade -qq
RUN apt-get install -y -qq --no-install-recommends inkscape

