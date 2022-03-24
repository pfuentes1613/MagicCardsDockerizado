FROM bitnami/apache

WORKDIR /app

COPY . /app

EXPOSE 8080


#Solo por que no es workstation
#COPY package.json .
#RUN npm install
#CMD [ "npm", "start" ]


