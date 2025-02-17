#!/bin/bash
# network_speed_test.sh
# A basic network speed test using only standard utilities.

PING_HOST="google.com"
DOWNLOAD_URL="http://ipv4.download.thinkbroadband.com/5MB.zip"
UPLOAD_URL="https://httpbin.org/post"
UPLOAD_SIZE_MB=10
UPLOAD_BYTES=$((UPLOAD_SIZE_MB * 1024 * 1024))
TEMP_FILE=$(mktemp /tmp/upload_test.XXXXXX)

cleanup() {
    rm -f "$TEMP_FILE"
}
trap cleanup EXIT

for cmd in ping curl dd awk; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: Required command '$cmd' is not available." >&2
        exit 1
    fi
done

echo "Running Ping Test to $PING_HOST..."
ping_output=$(ping -c 5 "$PING_HOST" 2>/dev/null)
avg_ping=$(echo "$ping_output" | tail -1 | awk -F'/' '{print $5}')

echo "Running Download Test..."
download_data=$(curl -o /dev/null -s -w "%{time_total} %{size_download}" "$DOWNLOAD_URL")
download_time=$(echo "$download_data" | awk '{print $1}')
download_bytes=$(echo "$download_data" | awk '{print $2}')

if (( $(echo "$download_time > 0" | awk '{print ($1 > 0)}') )); then
    download_speed_mbps=$(echo "$download_bytes $download_time" | awk '{printf "%.2f", ($1 / $2) * 8 / 1000000}')
else
    download_speed_mbps="N/A"
fi

echo "Preparing Upload Test file ($UPLOAD_SIZE_MB MB)..."
dd if=/dev/zero bs=1M count="$UPLOAD_SIZE_MB" of="$TEMP_FILE" status=none

echo "Running Upload Test..."
upload_time=$(curl -X POST -o /dev/null -s -w "%{time_total}" \
    -H "Content-Type: application/octet-stream" \
    --data-binary @"$TEMP_FILE" \
    "$UPLOAD_URL")

if (( $(echo "$upload_time > 0" | awk '{print ($1 > 0)}') )); then
    upload_speed_mbps=$(echo "$UPLOAD_BYTES $upload_time" | awk '{printf "%.2f", ($1 / $2) * 8 / 1000000}')
else
    upload_speed_mbps="N/A"
fi

echo "--------------------------------------------"
echo "              NETWORK SPEED TEST            "
echo "--------------------------------------------"
printf "%-20s: %s ms\n" "Average Ping" "$avg_ping"
printf "%-20s: %s s\n" "Download Time" "$download_time"
printf "%-20s: %s Mbps\n" "Download Speed" "$download_speed_mbps"
printf "%-20s: %s s\n" "Upload Time" "$upload_time"
printf "%-20s: %s Mbps\n" "Upload Speed" "$upload_speed_mbps"
echo "--------------------------------------------"

