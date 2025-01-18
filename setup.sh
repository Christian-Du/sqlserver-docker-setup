#!/usr/bin/env bash

if [ "$#" -eq 0 ]; then
    echo -e "Missing parameter.\nUsage: $0 -v <volume-location>"
    exit 1
fi

MSSQL_VOLUME_LOCATION=""
while getopts "v:" opt; do
    case $opt in
    v)
        MSSQL_VOLUME_LOCATION="$OPTARG"
        echo $MSSQL_VOLUME_LOCATION
        ;;
    *)
        echo "Usage: $0 -v <volume-location>"
        ;;
    esac
done

# check if docker is available
if ! command -v docker &>/dev/null; then
    echo "Error: Docker is not installed or not in the PATH." exit 1
fi

# Check if the user belongs to the Docker group
if ! groups | grep -q "\bdocker\b"; then
    echo "Error: The current user is not in the Docker group."
    echo "Add the user to the Docker group with 'sudo usermod -aG docker $USER' and restart the session."
    exit 1
fi

# Test if Docker commands can be executed
if ! docker ps &>/dev/null; then
    echo "Error: The user does not have permission to execute Docker commands."
    echo "Ensure the user is in the Docker group and Docker is properly configured."
    exit 1
fi

echo "Ende"
