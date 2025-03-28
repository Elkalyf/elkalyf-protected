#!/bin/bash

echo "Starting Hello World test app..."
node /server.js &

echo "Starting Authentik Outpost..."
authentik-proxy &

echo "Starting Traefik..."
traefik
