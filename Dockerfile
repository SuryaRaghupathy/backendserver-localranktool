ARG PORT=443

# Use a specific Cypress browser image
FROM cypress/browsers:node16.17.0-chrome104-ff102-edge105

# Install Python3 and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Set the user base path for Python
ENV PATH /root/.local/bin:$PATH

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose the port
EXPOSE $PORT

# Command to run the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "$PORT"]
