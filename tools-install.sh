#!/bin/bash
# Update package list
sudo apt update -y

# Create the index.html file
echo "<!DOCTYPE html>
<html>
<body>
<h1>Welcome to Prime Stone Inc</h1>
</body>
</html>" | sudo tee /var/www/html/index.html

# Start the Python HTTP server on port 8000
nohup python3 -m http.server 8000 --bind 0.0.0.0 &


# # Update package list and install Java
# sudo apt update -y
# sudo apt install -y openjdk-17-jre

# # Install Jenkins (add Jenkins repository and GPG key)
# curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
# echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
# sudo apt update -y

# # Install Jenkins
# sudo apt install -y jenkins

# # Install Docker
# sudo apt install -y docker.io

# # Add Jenkins and Ubuntu user to Docker group
# sudo usermod -aG docker jenkins
# sudo usermod -aG docker ubuntu

# # Restart Docker to apply changes
# sudo systemctl restart docker

# # Start Jenkins service (optional: ensure Jenkins starts on boot)
# sudo systemctl enable jenkins
# sudo systemctl start jenkins

# # Ensure Jenkins is running
# sudo systemctl status jenkins
