## Deployment Instructions

### Deploying Pixi using Docker Compose

To deploy Pixi locally using Docker Compose, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/42c-arhayem/pixibay.git
   cd pixibay
   ```

2. **Start the application**:
   ```bash
   docker-compose up -d
   ```
   This command will start all the necessary services defined in the `docker-compose.yml` file. The application will be available on the configured ports.

3. **Access the application**:
   Once all containers are up and running, you can access Pixi by navigating to `http://localhost:<your_port>` in your web browser.

### Deploying with 42Crunch API Firewall

For enhanced security, you can deploy Pixi with the 42Crunch API Firewall using the provided `docker-compose-firewalled.yaml`:

1. **Start the firewalled application**:
   ```bash
   docker-compose -f docker-compose-firewalled.yaml up -d
   ```
   This setup includes the 42Crunch API Firewall, which adds an extra layer of security to the API endpoints.

2. **Verify the deployment**:
   You can verify that the firewall is active and properly filtering requests by inspecting logs or attempting to access the application endpoints.

3. **Access the secured application**:
   Navigate to `http://localhost:<your_firewalled_port>` to interact with the secured instance of Pixi.

### Stopping the Application

To stop the services, use the following command:
```bash
docker-compose down
```
Or, if you used the firewalled configuration:
```bash
docker-compose -f docker-compose-firewalled.yaml down
```

###