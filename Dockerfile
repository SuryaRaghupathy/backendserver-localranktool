# Use a lightweight Python base image
FROM python:3.9-slim

# Set the port environment variable (default: 443)
ARG PORT=443
ENV PORT=${PORT}

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies (for Chrome and Selenium)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    wget \
    unzip \
    curl \
    && apt-get clean

# Install Chrome and Chromedriver
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y \
    && wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip -d /usr/local/bin/ \
    && rm -rf chromedriver_linux64.zip google-chrome-stable_current_amd64.deb

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire application to the container
COPY . .

# Expose the specified port
EXPOSE ${PORT}

# Set the default command to run the Flask app
CMD ["python", "backendserver.py"]
