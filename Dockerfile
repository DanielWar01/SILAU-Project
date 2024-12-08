# Usamos una imagen oficial de Node.js como base
FROM node:18 AS builder

# Establecemos el directorio de trabajo
WORKDIR /app

# Copiamos los archivos de package.json y package-lock.json (o yarn.lock) para instalar dependencias
COPY package*.json ./

# Instalamos las dependencias del proyecto
RUN npm install

# Instalamos Angular CLI 17.3.11 globalmente
RUN npm install -g @angular/cli@17.3.11

# Copiamos el código fuente del proyecto
COPY . .

# Construimos la aplicación Angular (esto generará los archivos estáticos)
RUN ng build --prod

# Usamos una imagen ligera de Nginx para servir la aplicación Angular
FROM nginx:alpine

# Copiamos el contenido generado por el build de Angular al directorio de Nginx
COPY --from=builder /app/dist/silau-project /usr/share/nginx/html

# Exponemos el puerto 80
EXPOSE 80

# Comando por defecto para arrancar Nginx
CMD ["nginx", "-g", "daemon off;"]