FROM python:3.9-slim

WORKDIR /app

# Install necessary system packages
RUN apt-get update && apt-get install -y python3-pip wget unzip \
    && apt-get clean

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Chrome and Chromedriver for Selenium
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y \
    && wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip -d /usr/local/bin/ \
    && rm -rf chromedriver_linux64.zip google-chrome-stable_current_amd64.deb

# Copy application files
COPY . .

EXPOSE 3000

CMD ["python", "backendserver.py"]
