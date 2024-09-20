# Competitor Watcher

This project sets up a cron job to periodically run the `competitor_watcher` Python package, which monitors competitor ASINs and sends notifications.

## Prerequisites

- Docker
- Python 3.12
- Git

## Setup

1. **Clone the repository:**

    ```sh
    git clone "<repository-url>"
    cd "<repository-directory>"
    ```

2. **Build the Docker image:**

    ```sh
    docker build -t competitor_watcher .
    ```

3. **Run the Docker container:**

    ```sh
    docker run -d competitor_watcher
    ```

## Configuration

About how to set up the configuration file, please refer to [here](https://github.com/mag1cfrog/idara_competitor_watcher#configuration) .

### Cron Job
The cron job is defined in the crontab file and is set to run every 5 minutes:

```sh
MAILTO=""
*/5 * * * * cd /app && python -m competitor_watcher 2>&1 | tee -a /var/log/cron.log
```

### Running the Cron Job
The cron job is set up and started when the Docker container is run. The setup_cron.sh script applies the cron job and starts the cron service.

## Logs
Logs are written to /var/log/cron.log inside the Docker container. You can view the logs by running:
    
```sh
docker exec -it <container-id> cat /var/log/cron.log
```