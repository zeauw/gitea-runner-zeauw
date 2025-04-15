#!/bin/bash

# check args
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <health-check-url> <command> [args...]"
  echo "Example: $0 http://localhost:8080/health ./start-service.sh"
  exit 1
fi

HEALTH_CHECK_URL=$1
shift
COMMAND=$@

# wait time
MAX_WAIT=60
INTERVAL=5

SECONDS=0

echo "Waiting for health check at $HEALTH_CHECK_URL to pass..."

while true; do
  STATUS=$(curl -s "$HEALTH_CHECK_URL" | jq -r '.status')

  if [ "$STATUS" == "pass" ]; then
    echo "Health check passed!"
    sleep 10 # make sure gitea is ready
    break
  fi

  if [ "$SECONDS" -ge "$MAX_WAIT" ]; then
    echo "Health check did not pass within $MAX_WAIT seconds. Exiting."
    exit 1
  fi

  echo "Health check not passed yet. Retrying in $INTERVAL seconds..."
  sleep $INTERVAL
done

echo "Running command: $COMMAND"
exec $COMMAND
