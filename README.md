
# 🕸️ Web Scraper UI with Puppeteer + Flask

This project allows users to input a URL from a web interface. It then scrapes the page title and first `<h1>` heading using Puppeteer (Node.js) and displays the result using Flask (Python).

---

## Features

- Input a URL directly from a web form
- Scrapes the page title and heading
- Clean web interface with styled output
- Dockerized with multi-stage build for minimal image size

---

## How to Build & Run

### 1. Unzip the project

```bash
cd WebScraper_UI_Project
```

### 2. Build the Docker image

```bash
docker build -t puppeteer-flask-app .
```

### 3. Run the container

```bash
docker run -d -p  5000:5000 puppeteer-flask-app
```

### 4. Access the web interface

Open your browser and go to:

```
http://localhost:5000
```

Enter a website URL to scrape its title and `<h1>` heading.

---

## Project Structure

```
.
├── Dockerfile
├── package.json          # Node.js dependencies
├── requirements.txt      # Python dependencies
├── scrape.js             # Puppeteer scraper
├── server.py             # Flask server
└── templates/
    └── index.html        # Frontend HTML
```

---

## Notes

- Make sure the target URL is public and allows scraping.
- Chromium is installed via `apt` in the container.
- Puppeteer uses the system-installed Chromium for headless browsing.

---

## Example

Try scraping:

- https://www.wikipedia.org
- https://news.ycombinator.com
- http://books.toscrape.com

---

Made with ❤️ using Flask + Puppeteer.
