#!/bin/bash

echo "Starting Authentik Outpost..."
authentik-proxy &

echo "Starting Traefik..."
traefik

