#!/bin/bash
# network_speed_test.sh
# This script runs a network speed test and prints the results in an organized format.

# Check if speedtest-cli is installed
if ! command -v speedtest-cli &> /dev/null; then
    echo "Error: speedtest-cli is not installed."
    echo "Please install it with: pip install speedtest-cli"
    exit 1
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed."
    echo "Please install it (e.g., sudo apt-get install jq)"
    exit 1
fi

echo "Running network speed test. Please wait..."

# Run speedtest-cli with JSON output
result=$(speedtest-cli --json 2>/dev/null)

if [ -z "$result" ]; then
    echo "Error: Failed to run speed test."
    exit 1
fi

# Parse JSON output using jq
timestamp=$(echo "$result" | jq -r '.timestamp')
ping=$(echo "$result" | jq '.ping')
download=$(echo "$result" | jq '.download')
upload=$(echo "$result" | jq '.upload')
server_name=$(echo "$result" | jq -r '.server.name')
server_country=$(echo "$result" | jq -r '.server.country')
server_sponsor=$(echo "$result" | jq -r '.server.sponsor')
client_ip=$(echo "$result" | jq -r '.client.ip')

# Convert download and upload from bits per second to Megabits per second (Mbps)
download_mbps=$(awk "BEGIN {printf \"%.2f\", $download/1000000}")
upload_mbps=$(awk "BEGIN {printf \"%.2f\", $upload/1000000}")

# Display the results in an organized form
echo "--------------------------------------------"
echo "              SPEED TEST RESULTS            "
echo "--------------------------------------------"
echo "Timestamp       : $timestamp"
echo "Server          : $server_name, $server_country"
echo "Sponsor         : $server_sponsor"
echo "Client IP       : $client_ip"
echo "--------------------------------------------"
echo "Ping            : ${ping} ms"
echo "Download Speed  : ${download_mbps} Mbps"
echo "Upload Speed    : ${upload_mbps} Mbps"
echo "--------------------------------------------"

