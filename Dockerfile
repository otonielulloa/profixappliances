# 1. Usar una imagen ligera de Nginx
FROM nginx:alpine

# Copia todos los archivos de tu web al servidor web
COPY . /usr/share/nginx/html

# Configura Nginx para activar la caché de imágenes por 30 días
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