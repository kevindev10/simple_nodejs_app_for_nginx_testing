

```markdown
# 🚀 Node.js + Nginx Load-Balancing Project

This project demonstrates how to combine Nginx and multiple Node.js servers using HTTPS, reverse proxying, and Docker. It serves a static HTML frontend, distributes traffic across multiple backend containers, and includes full SSL termination with a self-signed certificate.

---

## 📦 Features

- ✳️ Three Node.js servers running in parallel
- 🔐 Nginx proxy configured for HTTPS using self-signed certs
- ⚖️ Load balancing via `upstream` using `least_conn` strategy
- 🔁 HTTP-to-HTTPS redirection
- 🖼️ Static frontend served through Express and/or Nginx
- 🐳 Fully containerized with Docker and orchestrated via Docker Compose
- 🧠 Richly annotated configs and HTML for DevOps learning

---

## 📁 Project Structure

```
.
├── Dockerfile
├── docker-compose.yaml
├── index.html
├── images/
│   ├── devops.png
│   ├── it-beginners.jpg
│   └── devsecops.jpg
├── server.js
├── nginx.conf
├── .env
├── nginx-certs/
│   ├── nginx-selfsigned.crt
│   └── nginx-selfsigned.key
```

---

## 🌐 Frontend – `index.html`

A responsive landing page served by Express or optionally by Nginx. Uses Flexbox-based card layout with embedded images and navigation bar.

> Images are located in `/images` and routed by Express or Nginx.

---

## 🖥️ Backend – `server.js`

Node.js (Express) server that:

- Loads `APP_NAME` from `.env`
- Serves `index.html` at `/`
- Serves static images under `/images`
- Logs which container served each request

### Example `.env` file:

```
APP_NAME=Node App 1
```

---

## 🐳 Dockerfile (for backend)

```Dockerfile
FROM node:14-alpine
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node", "server.js"]
```

Build it with:

```bash
docker build -t simple-nodejs-app .
```

---

## 🧩 Nginx Configuration – `nginx.conf`

Reverse proxy with HTTPS and load balancing.

### Key Contexts & Concepts

- `main`: declares `worker_processes`
- `events`: defines `worker_connections`
- `http`: handles all traffic routing
- `upstream nodejs_cluster`: load balances between `3001`, `3002`, and `3003`
- `server`: defines HTTPS and HTTP redirect behaviors

### TLS

Self-signed certificate and key must live in `nginx-certs/`:

```bash
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout nginx-selfsigned.key \
  -out nginx-selfsigned.crt
```

---

## 🐋 Docker Compose – `docker-compose.yaml`

Spins up 3 uniquely named backend containers:

```yaml
version: '3'
services:
  simple_nodejs_app_for_nginx_testing1:
    build: .
    environment:
      - APP_NAME=simple_nodejs_app_for_nginx_testing1 
    ports:
      - "3001:3000"

  simple_nodejs_app_for_nginx_testing2:
    build: .
    environment:
      - APP_NAME=simple_nodejs_app_for_nginx_testing2
    ports:
      - "3002:3000"

  simple_nodejs_app_for_nginx_testing3:
    build: .
    environment:
      - APP_NAME=simple_nodejs_app_for_nginx_testing3
    ports:
      - "3003:3000"
```

Run all services with:

```bash
docker-compose up --build
```

---

## 🧰 Nginx Control Reference (Ubuntu/Linux)

Useful commands for managing Nginx directly on Ubuntu.

### 🟢 Start Nginx
```bash
sudo systemctl start nginx
```

### 🔍 Get Nginx Command-Line Options
```bash
nginx -h
```

### 🔁 Reload Configuration Without Dropping Connections
```bash
sudo nginx -s reload
```

### 🔻 Stop Nginx
```bash
sudo nginx -s stop
```

### 📄 Tail Nginx Access Logs (Ubuntu default path)
```bash
sudo tail -f /var/log/nginx/access.log
```

---

## 🔐 TLS Certificate Setup (for Nginx SSL)

### 📁 Create Folder for Certs
```bash
mkdir -p ~/nginx-certs
cd ~/nginx-certs
```

### 🛡️ Generate a Self-Signed SSL Certificate
```bash
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout nginx-selfsigned.key \
  -out nginx-selfsigned.crt
```

> This creates `nginx-selfsigned.crt` and `nginx-selfsigned.key` valid for 1 year.

---

## ✅ Testing Flow

1. Visit [`http://localhost:8080`](http://localhost:8080)
2. You’ll be redirected to HTTPS
3. One of the 3 backend containers will serve the request
4. Logs will show the serving app via its `APP_NAME`

---

## 🗂️ Usage Notes for Dockerized Nginx

```nginx
# ▶️ Start Nginx normally (production-style):
# docker run -d --name dev09-container -p 8080:80 nginx-dev09:latest
# 🌐 Visit: http://localhost:8080

# 🧪 To enter container shell for debugging:
# docker run -it --rm --name dev09-container --entrypoint bash nginx-dev09:latest
```

---

## 🧠 Why This Matters

This project gives you hands-on experience with:

- Docker-based microservice scaling
- Reverse proxy design
- Certificate-based TLS
- Express + Nginx integration
- Production vs development separation

Also serves as a foundation for CI/CD pipelines, service discovery, and container orchestration.

---

🛠 Built by [Kevin]. Feel free to fork, extend, deploy—and show future you how it’s really done.
```



