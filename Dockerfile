# Use the official Python 3.10 slim image as the base
FROM python:3.10-slim-bullseye

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libjpeg-dev \
    zlib1g-dev \
    libpq-dev \
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables to prevent Python from writing .pyc files to disk and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Install Python dependencies
RUN pip install --no-cache-dir \
    Django==3.2.10 \
    Pillow==10.0.0 \
    jinja2==3.0 \
    gunicorn==20.1.0 \
    contextvars \
    typing-extensions==4.1.1 \
    aiohttp==3.8.5 \
    click==8.0.4 \
    wheel==0.41.1 \
    multidict==4.5

# Copy the current directory contents into the container at /app
COPY . /app

# Expose the port that gunicorn will run on
EXPOSE 8000

# Define the command to run your application using gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "your_project_name.wsgi:application"]
