#!/bin/bash

# Exit on error
set -e

echo "Cleaning up ELK Stack resources..."

# Stop and remove Docker containers
echo "Stopping and removing Docker containers..."
docker-compose down

# Optionally, remove volumes to clean data
read -p "Do you want to remove all volumes? This will delete all stored data! [y/N]: " confirm
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  echo "Removing Docker volumes..."
  docker volume rm $(docker volume ls -q --filter "dangling=true") || true
fi

# Optionally, remove generated files
echo "Removing generated directories..."
rm -rf elasticsearch/data logstash/config logstash/pipeline kibana/config

echo "Cleanup complete! All resources have been removed."
