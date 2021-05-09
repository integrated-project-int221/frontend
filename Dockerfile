FROM node:14.16.1-alpine3.10 as build
WORKDIR /frontend
COPY package*.json ./
RUN npm install
COPY . /frontend
ARG http://207.46.228.91:8080/
ENV VUE_APP_BACKEND_URL http://207.46.228.91:3000/
RUN npm run build

FROM nginx:1.19.10-alpine
ADD nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /frontend/dist /usr/share/nginx/html/frontend/
EXPOSE 80