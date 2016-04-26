FROM nginx:latest

RUN apt-get install git-core

RUN git clone https://github.com/tokuhirom/64p.org.git /64p/
ADD nginx.conf /nginx.conf

CMD ["nginx", "-g", "daemon off;", "-c", "/nginx.conf"]

