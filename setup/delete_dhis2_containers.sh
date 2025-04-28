#!/usr/bin/env bash

# List of containers to delete
containers=("proxy" "postgres" "monitor")

# Prompt for confirmation
read -r -p "Are you sure you want to delete the DHIS2 containers: proxy, postgres, monitor? [y/N]: " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "Aborting: No containers were deleted."
    exit 0
fi

# Loop through each container and delete if it exists
for container in "${containers[@]}"; do
    if lxc info "$container" >/dev/null 2>&1; then
        echo "Deleting container '$container'..."
        if lxc delete "$container" --force; then
            echo "Successfully deleted '$container'."
        else
            echo "Failed to delete '$container'."
        fi
    else
        echo "Container '$container' does not exist. Skipping."
    fi
done
