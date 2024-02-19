#This shouls be the first command in Docker file, here we are selecting base image to run this container
FROM almalinux:8
RUN yum install nginx -y
CMD ["nginx", "-g", "daemon off;"]
RUN useradd nageswar
USER nageswar
LABEL NAME="NAGESWAR" \
      COURSE="DEVOPS"
RUN rm -rf /usr/share/nginx/html/index.html
COPY index.html /usr/share/nginx/html/
ENV MOTHER_NAME="BHAGYALAKSHMI"
CMD [ "google.com" ]
ENTRYPOINT [ "ping" ]
WORKDIR /tmp