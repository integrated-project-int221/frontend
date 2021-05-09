
FROM node:latest as build-stage
WORKDIR /frontend
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build


FROM nginx as production-stage
RUN mkdir /frontend
COPY --from=build-stage /frontend/dist /frontend
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80


# FROM nginx:1.19.10-alpine
# RUN mkdir /frontend
# COPY --from=build-stage /frontend/dist /frontend
# COPY nginx.conf /etc/nginx/nginx.conf
# EXPOSE 80