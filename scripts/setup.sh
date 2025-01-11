#!/bin/bash

# Exit on error
set -e

echo "Initializing ELK Stack setup..."

# Load environment variables
if [ -f .env ]; then
  echo "Loading environment variables from .env file..."
  export $(grep -v '^#' .env | xargs)
else
  echo ".env file not found. Please create one based on .env.example."
  exit 1
fi

# Create necessary directories
echo "Creating necessary directories..."
mkdir -p elasticsearch/data logstash/config logstash/pipeline kibana/config

# Set proper permissions for Elasticsearch
echo "Setting permissions for Elasticsearch data directory..."
chmod -R 777 elasticsearch/data

# Build and start the containers
echo "Building and starting Docker containers..."
docker-compose up -d --build

# Wait for Elasticsearch to be ready
echo "Waiting for Elasticsearch to be ready..."
until curl -s http://localhost:9200 >/dev/null; do
  sleep 2
  echo "Still waiting for Elasticsearch..."
done

echo "Elasticsearch is ready!"

# Optional: Preload Kibana dashboards (if any)
if [ -d "dashboards" ]; then
  echo "Importing Kibana dashboards..."
  curl -X POST "http://localhost:5601/api/saved_objects/_import" \
       -H "kbn-xsrf: true" \
       --form file=@dashboards/prebuilt-dashboard.ndjson
fi

echo "ELK Stack setup complete! Access Kibana at http://localhost:5601"
