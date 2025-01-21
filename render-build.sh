#!/usr/bin/env bash

# Atualizar e instalar dependências necessárias para o Puppeteer
apt-get update
apt-get install -y wget gnupg libxshmfence1

# Instalar pacotes adicionais necessários para rodar o Chromium em ambiente headless
apt-get install -y --no-install-recommends \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-glib-1-2 \
    libgbm-dev \
    libnspr4 \
    libdbus-1-3 \
    libnss3 \
    libdrm2 \
    libxdamage1 \
    libx11-xcb1 \
    libxcomposite1 \
    libxrandr2 \
    xdg-utils \
    libasound2

echo "Dependências para o Puppeteer instaladas com sucesso!"
