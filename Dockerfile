FROM node:14.16.1-alpine3.10 as build
RUN mkdir -p /frontend
WORKDIR /frontend
COPY package*.json ./
RUN npm install
COPY . /frontend
RUN npm run build


FROM nginx:1.19.10-alpine
COPY --from=build /frontend/dist /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]