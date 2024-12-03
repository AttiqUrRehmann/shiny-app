# Dockerfile for Shiny App

# Use the rocker/shiny base image
FROM rocker/shiny:latest

# Copy the Shiny app to the image
COPY app.R /srv/shiny-server/
  
  # Set permissions
  RUN chmod -R 755 /srv/shiny-server

# Expose the port for the Shiny app
EXPOSE 3838

# Run the Shiny app
CMD ["/usr/bin/shiny-server"]