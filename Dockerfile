# Start with a base Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Install dependencies
COPY pyproject.toml poetry.lock /app/
RUN python -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install poetry==1.8.4 && \
    poetry config virtualenvs.create false && \
    poetry install --no-dev --no-interaction --no-ansi

# Copy application files
COPY . /app

# Expose the port that Streamlit will run on
EXPOSE 8501

# Run the application
CMD ["streamlit", "run", "app/main.py", "--server.port=8501", "--server.address=0.0.0.0"]