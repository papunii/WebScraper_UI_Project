# ---------- Stage 1: Node.js Scraper ----------
FROM node:18-slim AS scraper

RUN apt-get update && \
    apt-get install -y chromium chromium-common chromium-driver fonts-liberation && \
    rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

WORKDIR /app
COPY package.json ./
RUN npm install
COPY scrape.js ./

# ---------- Stage 2: Python Flask + Node.js ----------
FROM python:3.10-slim AS final

# Install Chromium, fonts, curl and gnupg
RUN apt-get update && \
    apt-get install -y chromium chromium-common chromium-driver fonts-liberation curl gnupg && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js (manual method via NodeSource)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy app files from scraper stage
COPY --from=scraper /app /app

# Copy Flask files
COPY server.py requirements.txt ./
COPY templates/ ./templates/

# Install Python requirements
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python", "server.py"]
