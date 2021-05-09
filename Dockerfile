FROM node:14.16.1-alpine3.10 as build
WORKDIR /frontend
COPY package*.json ./
RUN npm install
COPY . /frontend
# ARG http://172.22.0.3:8080/
# ENV VUE_APP_BACKEND_URL http://172.22.0.3:8080/
RUN npm run build

FROM nginx:1.19.10-alpine
ADD nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /frontend/dist /usr/share/nginx/html/frontend/
EXPOSE 80

# FROM nginx:1.19.10-alpine
# RUN mkdir /frontend
# COPY --from=build-stage /frontend/dist /frontend
# COPY nginx.conf /etc/nginx/nginx.conf
# EXPOSE 80