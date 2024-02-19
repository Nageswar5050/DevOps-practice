FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/index.html
ADD https://roboshop-builds.s3.amazonaws.com/web.zip /usr/share/nginx/html/
COPY roboshop.conf /etc/nginx/default.d/