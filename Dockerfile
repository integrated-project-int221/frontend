<<<<<<< HEAD
FROM node:14.16.1-alpine3.10 as build
WORKDIR /frontend
COPY package*.json ./
RUN npm install
COPY . /frontend
ARG BACKEND_URL
ENV VUE_APP_BACKEND_URL $BACKEND_URL
RUN npm run build

FROM nginx:1.19.10-alpine
ADD nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /frontend/dist /usr/share/nginx/html/frontend/
EXPOSE 80
=======
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

FROM nginx as production-stage
RUN mkdir /app
COPY --from=build-stage /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]
# FROM nginx:1.19.10-alpine
# RUN mkdir /frontend
# COPY --from=build-stage /frontend/dist /frontend
# COPY nginx.conf /etc/nginx/nginx.conf
# EXPOSE 80
>>>>>>> 83f4f38685f067da629b460db81b4358f3b7e8fe
