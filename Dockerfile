# Use a base Python image
FROM python:3.12-slim

# Install essential build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy requirements and install them
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Set environment variables for Flask
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development

# Expose the port that the Flask app runs on
EXPOSE 5000

# Default command to run Alembic migrations and start the Flask app
CMD ["sh", "-c", "alembic -c migrations/alembic.ini -x db=dev upgrade head && flask run"]