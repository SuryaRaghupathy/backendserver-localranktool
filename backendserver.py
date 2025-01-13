from flask import Flask, request, jsonify
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver

app = Flask(__name__)

def download_selenium():
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)

    driver.get("https://www.collinsonhall.co.uk/")
    title = driver.title

    data = {'Page Title': title}
    print(data)  # Log the fetched data
    driver.quit()  # Ensure the browser closes after fetching the title
    return data

@app.route('/', methods=['GET', 'POST'])
def home():
    if request.method == 'GET':
        data = download_selenium()
        return jsonify(data)  # Convert the dictionary to a JSON response
    return "Method Not Allowed", 405  # Handle unexpected methods

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=3000)
