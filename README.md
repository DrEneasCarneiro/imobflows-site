# ImobFlow — Site institucional

Landing page do **ImobFlow**, a plataforma de cobrança do mercado imobiliário.
Site **estático e portável** (HTML/CSS/JS puro, sem build) — roda em qualquer servidor.

Domínio de produção: **imobflows.com.br**

## Estrutura

```
index.html          Página única (estilos e scripts embutidos; fontes e logos em data-URI)
favicon.ico         Ícone da aba
apple-touch-icon.png / icon-32.png / icon-192.png / icon-512.png
og.png              Imagem de compartilhamento (Open Graph)
site.webmanifest    Manifesto PWA
robots.txt / sitemap.xml
nginx.conf          Configuração nginx (headers de segurança, gzip, cache)
Dockerfile          Imagem nginx pronta pra produção
```

## Rodar localmente

```bash
python3 -m http.server 8080
# abra http://localhost:8080
```

## Deploy no seu servidor

**Opção A — Docker (recomendada)**
```bash
docker build -t imobflows-site .
docker run -d --name imobflows -p 80:80 imobflows-site
```

**Opção B — nginx direto na VPS**
```bash
# copie os arquivos do site para a raiz web
sudo rsync -a --exclude '.git' --exclude 'Dockerfile' --exclude 'nginx.conf' \
  --exclude 'README.md' ./ /var/www/imobflows/
# use o nginx.conf deste repo como server block
sudo cp nginx.conf /etc/nginx/sites-available/imobflows.conf
sudo ln -s /etc/nginx/sites-available/imobflows.conf /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

**Opção C — qualquer host estático:** basta servir a pasta.

## Domínio e SSL

1. No **registro.br**, aponte o domínio para o IP do seu servidor:
   - `A  @    <IP_DO_SERVIDOR>`
   - `A  www  <IP_DO_SERVIDOR>`
2. Emita o certificado TLS (ex.: Let's Encrypt):
   ```bash
   sudo certbot --nginx -d imobflows.com.br -d www.imobflows.com.br
   ```
   Alternativa: usar **Caddy**, que resolve o SSL automaticamente.

## Formulário de contato

O formulário valida e confirma **no navegador**. Para receber os leads de verdade,
conecte o `submit` a um backend (e-mail, CRM, webhook ou banco) — o ponto exato está
marcado no `<script>` do `index.html` (`// aqui vai o POST pro backend real`).

## Editar o site

Todo o conteúdo está em `index.html`. Após editar, refaça o build da imagem
(`docker build`) ou sincronize os arquivos para a raiz web.

---

© ImobFlow. Todos os direitos reservados. Uso proprietário.
