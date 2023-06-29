FROM ubuntu:latest

WORKDIR /code

COPY environment.yml .

RUN apt update -y && apt upgrade -y && conda env create -f environment.yml && conda init bash && echo "conda activate ml4t" >> ~/.bashrc