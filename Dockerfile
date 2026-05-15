FROM nginx:alpine

# Copia todos los archivos de tu web al servidor web
COPY . /usr/share/nginx/html

# Configura Nginx para activar la caché de imágenes por 30 días y habilitar la compresión Gzip
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
    # --- CONFIGURACIÓN DE COMPRESIÓN GZIP --- \
    gzip on; \
    gzip_vary on; \
    gzip_min_length 10240; \
    gzip_proxied any; \
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/x-javascript application/xml; \
    gzip_disable "MSIE [1-6]\."; \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]