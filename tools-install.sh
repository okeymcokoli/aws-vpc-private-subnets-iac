#!/bin/bash
# Update package list
sudo apt update -y

# Create the index.html file
echo "<!DOCTYPE html>
<html>
<body>
<h1>Welcome to my website 2</h1>
</body>
</html>" | sudo tee /var/www/html/index.html

# Start the Python HTTP server on port 8000
nohup python3 -m http.server 8000 --bind 0.0.0.0 &


