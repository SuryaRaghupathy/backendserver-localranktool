from flask import Flask, request
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
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
    print(data)
    return data

@app.route('/', methods=['GET', 'POST'])
def home():
    if request.method == 'GET':
        return download_selenium()
if __name__ == "__main__":
    app.run(debug=True, port=3000)
