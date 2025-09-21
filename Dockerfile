FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install build dependencies (optional but good for C extensions like bcrypt/cryptography)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for caching layers)
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose port Render will map
EXPOSE 8000

# Use Gunicorn to serve Flask app
# app:app → (file: Flask app instance)
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]