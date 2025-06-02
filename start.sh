#!/bin/bash

# Set permissions for CodeIgniter
sudo chown -R son:son /workspace
sudo chmod -R 755 /workspace/application/cache
sudo chmod -R 755 /workspace/application/logs

# Start services
sudo php-fpm
sudo nginx

# Keep container running
tail -f /dev/null
