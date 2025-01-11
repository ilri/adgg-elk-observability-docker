# ELK Stack Monitoring Project

This project is a Dockerized ELK (Elasticsearch, Logstash, and Kibana) stack for centralized logging, monitoring, and visualization of data. 

---

## Features

- **Elasticsearch**: A distributed search and analytics engine for storing and querying log data.
- **Logstash**: A log pipeline for ingesting, transforming, and forwarding data.
- **Kibana**: A powerful visualization tool for analyzing data and building dashboards.
- **Dockerized Setup**: Easy-to-use Docker Compose configuration.
- **Customizable**: Flexible to add new pipelines, indices, and dashboards.

---

## Prerequisites

- **Docker**: [Download and Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose**: [Download and Install Docker Compose](https://docs.docker.com/compose/install/)
- **Git**: [Download and Install Git](https://git-scm.com/)

---

## Getting Started

Follow these steps to set up and run the ELK stack:

### 1. Clone the Repository

```bash
git@github.com:ilri/adgg-elk-observability-docker.git
cd elk-monitoring-docker
```

### 2. Set Up Environment Variables

Create a `.env` file using the provided `.env.example` template:

```bash
cp .env.example .env
```

Edit the `.env` file to configure ports, paths, and credentials.

### 3. Initialize the Setup

Run the `setup.sh` script to build and start the ELK stack:

```bash
./setup.sh
```

### 4. Access the Stack

- **Kibana**: [http://localhost:5601](http://localhost:5601)
- **Elasticsearch**: [http://localhost:9200](http://localhost:9200)

---

## Directory Structure

```plaintext
elk-monitoring-docker/
├── elasticsearch/          # Elasticsearch data and config
├── logstash/               # Logstash pipelines and config
├── kibana/                 # Kibana config
├── dashboards/             # Pre-built Kibana dashboards (optional)
├── logs/                   # Log directory (auto-created)
├── docker-compose.yml      # Docker Compose configuration
├── setup.sh                # Script to initialize the stack
├── cleanup.sh              # Script to stop and clean up the stack
├── .env.example            # Environment variable template
├── README.md               # Project documentation
```

---

## Stopping and Cleaning Up

To stop the stack and optionally clean up resources, use the `cleanup.sh` script:

```bash
./cleanup.sh
```

---

## Customization

### Adding a Logstash Pipeline

1. Create a new pipeline file in `logstash/pipeline/`.
2. Update `docker-compose.yml` to mount the new pipeline file.
3. Restart the stack:
   ```bash
   docker-compose restart
   ```

### Importing Dashboards to Kibana

1. Place your `.ndjson` dashboard files in the `dashboards/` directory.
2. The `setup.sh` script will automatically import these dashboards.

---

## Troubleshooting

- **Elasticsearch Not Starting**: Ensure the `elasticsearch/data` directory has the correct permissions:
  ```bash
  chmod -R 777 elasticsearch/data
  ```
- **Check Container Logs**: View logs for individual containers:
  ```bash
  docker-compose logs <container_name>
  ```

---

