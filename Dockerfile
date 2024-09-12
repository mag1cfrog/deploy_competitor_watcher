# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Install cron
RUN apt-get update && apt-get install -y cron

# Install git
RUN apt-get install -y git

# Set the working directory in the container
WORKDIR /app

# Copy the wheel file and necessary configuration files into the container
COPY ./competitor_watcher-0.1.0-py3-none-any.whl /app/
COPY ./config.json /app/
COPY ./.env /app/
COPY ./crontab /etc/cron.d/my-cron-job

# Install the package using pip
RUN pip install ./competitor_watcher-0.1.0-py3-none-any.whl

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/my-cron-job

# Apply cron job
RUN crontab /etc/cron.d/my-cron-job

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log
