# ImobFlow — site institucional (estático, servido por nginx)
FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html robots.txt sitemap.xml site.webmanifest \
     favicon.ico apple-touch-icon.png \
     icon-32.png icon-192.png icon-512.png og.png \
     /usr/share/nginx/html/

EXPOSE 80
