FROM ghcr.io/puppeteer/puppeteer:24.10.0
FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    curl \
    wget \
    gnupg \
    apt-transport-https \
    software-properties-common \
    build-essential \
    git \
    sudo && \
    apt-get clean

RUN apt-get install -y \
    gconf-service \
    libgbm-dev \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    libappindicator1 \
    libnss3 \
    lsb-release \
    xdg-utils && \
    apt-get clean

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# Configuration des variables d'environnement
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci
COPY . .

CMD [ "node", "index.js" ]
