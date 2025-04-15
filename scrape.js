const puppeteer = require('puppeteer');
const fs = require('fs');

const url = process.env.SCRAPE_URL;

(async () => {
  if (!url) {
    console.error("❌ SCRAPE_URL environment variable is not set");
    process.exit(1);
  }

  const browser = await puppeteer.launch({
    headless: "new",
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
    executablePath: '/usr/bin/chromium'
  });

  const page = await browser.newPage();
  await page.goto(url, { waitUntil: 'domcontentloaded' });

  const data = await page.evaluate(() => {
    const title = document.title;
    let heading = document.querySelector('h1')?.innerText || "No <h1> found";
    heading = heading
      .split('\n')
      .map(h => h.trim())
      .filter(Boolean)
      .join(' - ');
    return { title, heading };
  });

  fs.writeFileSync('scraped_data.json', JSON.stringify(data, null, 2));
  await browser.close();
})();