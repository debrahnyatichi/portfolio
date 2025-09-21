# Use official Python 3.12 slim image
FROM python:3.12-slim

# Set working directory inside the container
WORKDIR /app

# Install system dependencies for building wheels & your packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    pkg-config \
    python3-dev \
    python3-gi \
    libcairo2-dev \
    libgirepository1.0-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file first (for Docker cache efficiency)
COPY requirements.txt .

# Upgrade pi
p & install dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy your project files
COPY . .

# Expose Flask’s default port
EXPOSE 5000

# Run your Flask app
CMD ["python", "app.py"]