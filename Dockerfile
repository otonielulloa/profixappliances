# 1. Usar una imagen ligera de Nginx
FROM nginx:alpine

# 2. Copiar los archivos de tu página (cambia "dist" o "public" por tu carpeta de salida, o usa "." si están en la raíz)
COPY . /usr/share/nginx/html

# 3. Inyectar la configuración de caché en Nginx
RUN echo 'server { \
    listen 80; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html index.htm; \
    } \
    location ~* \.(jpg|jpeg|png|gif|ico|webp|svg|css|js)$ { \
        root /usr/share/nginx/html; \
        expires 30d; \
        add_header Cache-Control "public, no-transform"; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]