from flask import Flask, render_template, request
import json
import subprocess
import os

app = Flask(__name__)
SCRAPED_FILE = "scraped_data.json"

@app.route("/", methods=["GET", "POST"])
def index():
    scraped = {"title": "Welcome To WebScraper", "heading": "Enter a URL to begin scraping."}

    if request.method == "POST":
        url = request.form.get("url")
        if url:
            env = os.environ.copy()
            env["SCRAPE_URL"] = url

            try:
                subprocess.run(["node", "scrape.js"], env=env, check=True)
                with open(SCRAPED_FILE) as f:
                    scraped = json.load(f)
            except Exception as e:
                scraped = {"title": "Error", "heading": str(e)}

    return render_template("index.html", title=scraped["title"], heading=scraped["heading"])

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
