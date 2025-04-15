FROM node:18-slim AS scraper

RUN apt-get update && \
    apt-get install -y chromium chromium-common chromium-driver fonts-liberation && \
    rm -rf /var/lib/apt/lists/*

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

WORKDIR /app
COPY package.json ./
RUN npm install
COPY scrape.js ./

FROM python:3.10-slim AS final

WORKDIR /app
COPY --from=scraper /app /app
COPY server.py requirements.txt ./
COPY templates/ ./templates/
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["python", "server.py"]