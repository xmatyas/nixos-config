#! /usr/bin/env bash
# Function to check for updates
check_updates() {
    container=$1
    current_image=$(podman inspect --format='{{.Image}}' $container 2>/dev/null)
    if [ -z "$current_image" ]; then
        echo "Container $container does not exist or cannot be inspected."
        return
    fi
    
    latest_image=$(podman inspect --format='{{.Image}}' $(podman search $container --format='{{.Name}}' 2>/dev/null | head -n 1))
    if [ -z "$latest_image" ]; then
        echo "Failed to retrieve information about the latest image for container $container."
        return
    fi
    
    if [ "$current_image" != "$latest_image" ]; then
        echo "Container $container has an update available."
    else
        echo "Container $container is up to date."
    fi
}

# List your containers
containers=$(podman ps -a --format="{{.Names}}")

# Loop through each container and check for updates
for container in $containers; do
    check_updates $container
done
