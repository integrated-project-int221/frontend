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