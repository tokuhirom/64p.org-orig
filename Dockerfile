FROM nginx:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y git-core \
    --no-install-recommends \
        && rm -rf /var/lib/apt/lists/*

EXPOSE 8443

RUN git clone https://github.com/tokuhirom/64p.org.git /64p/
ADD nginx.conf /nginx.conf

CMD ["nginx", "-c", "/nginx.conf"]

