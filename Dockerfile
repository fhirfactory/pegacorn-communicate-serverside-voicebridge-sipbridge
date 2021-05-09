FROM node:14.16.1-alpine3.13 as builder

# Conditionally copy certificate, as it won't exist outside the proxy (based on https://forums.docker.com/t/copy-only-if-file-exist/3781/3)
COPY PRDPKICA.crt /opt

ENV NODE_EXTRA_CA_CERTS=/opt/PRDPKICA.crt

# Conditionally configure npm to use https proxy. Based on: 
# 1. https://www.dev-diaries.com/social-posts/conditional-logic-in-dockerfile/
ARG HTTP_PROXY
RUN if [ -n "$HTTP_PROXY" ] ; then \
    npm set proxy ${HTTP_PROXY} \ 
 && npm set strict-ssl false \
 && npm set cafile /opt/PRDPKICA.crt \
 ; fi

ENV NODE_ENV production

COPY install/ /
WORKDIR /lib
RUN npm install verto

RUN npm install jquery \
    && npm install jquery-json

FROM nginx:alpine

# Insert wasm type into Nginx mime.types file so they load correctly.
RUN sed -i '3i\ \ \ \ application/wasm wasm\;' /etc/nginx/mime.types

COPY --from=builder /src/* /usr/share/nginx/html/
COPY --from=builder /lib /usr/share/nginx/html

ARG IMAGE_BUILD_TIMESTAMP
ENV IMAGE_BUILD_TIMESTAMP=${IMAGE_BUILD_TIMESTAMP}
RUN echo IMAGE_BUILD_TIMESTAMP=${IMAGE_BUILD_TIMESTAMP}