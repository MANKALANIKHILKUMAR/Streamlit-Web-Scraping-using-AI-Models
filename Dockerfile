# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install system dependencies required for Playwright
RUN apt-get update && \
    apt-get install -y \
    wget \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    libatspi2.0-0 \
    libwayland-client0 \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright and its browsers
RUN pip install playwright && \
    playwright install

# Copy the current directory contents into the container
COPY . .

# Install Python dependencies
RUN pip install -r requirements.txt

# Expose the port the app runs on
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "streamlit_app.py"]
