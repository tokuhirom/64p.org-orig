FROM nginx:latest

ENV DEBIAN_FRONTEND noninteractive

EXPOSE 8443

ADD static/ static/
ADD nginx.conf /nginx.conf

CMD ["nginx", "-c", "/nginx.conf"]

