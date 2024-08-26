#!/bin/bash

# Prompt the user to choose which Docker Compose configuration to deploy based on descriptions
echo "Choose the Pixi state to deploy:"
echo "1. Deploy the vulnerable version"
echo "2. Deploy the patched version"
echo "3. Deploy the firewalled version"
read -p "Enter your choice (1, 2 or 3): " choice

# Define the base directory as the parent directory of the scripts folder
base_dir="$(dirname "$(pwd)")"

# Define the Docker Compose file path using the absolute path
if [ "$choice" == "1" ]; then
    compose_file="$base_dir/docker-compose.yaml"
elif [ "$choice" == "2" ]; then
    compose_file="$base_dir/docker-compose-patched.yaml"
elif [ "$choice" == "3" ]; then
    compose_file="$base_dir/docker-compose-firewalled.yaml"
else
    echo "Invalid choice."
    exit 1
fi

# Uninstall existing containers if they exist
docker-compose -f "$compose_file" down

# Run the Docker Compose command to deploy the selected version and check if it was successful
docker-compose -f "$compose_file" up -d --build
if [ $? -ne 0 ]; then
    echo "Docker Compose deployment failed. Exiting script."
    exit 1
fi

# Wait for a few seconds to ensure the deployment is completed
sleep 20

# JSON data for the API request 
json_data_user_inbound='{"user": "user-inbound@acme.com","pass": "hellopixi","name": "User Inbound","is_admin": false,"account_balance": 1000}'
json_data_user_common='{"user": "userscan-run@acme.com","pass": "hellopixi","name": "User Common","is_admin": false,"account_balance": 1000}'

# Define the API URL (assuming localhost for Docker Compose)
api_url="http://localhost:8090/api/user/register"

# Invoke the API using curl with POST method and passing the JSON data
curl_response_inbound=$(curl -s -X POST -H "Content-Type: application/json" -d "$json_data_user_inbound" "$api_url")
curl_response_common=$(curl -s -X POST -H "Content-Type: application/json" -d "$json_data_user_common" "$api_url")

# Check the curl response
if [ $? -eq 0 ]; then
    echo "API Response:"
    echo "Inbound user: $curl_response_inbound"
    echo "Common User: $curl_response_common"

    # Extract the token from the JSON response using jq
    token=$(echo "$curl_response_common" | jq -r '.token')

    if [ -n "$token" ]; then
        echo "Token to use as parameter SCAN42C_SECURITY_COMMON_ACCESS_TOKEN : $token"
        export PIXI_TOKEN="$token"
    else
        echo "Error: Failed to extract token from API response."
    fi
else
    echo "Error: Failed to invoke the API."
fi