#!/bin/bash

clear

######################################################
# Define ANSI escape sequences for colors and reset  #
######################################################
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

###########################################
# Function for displaying status messages #
###########################################
status_message() {
  local status="$1"  # "success", "error"
  local message="$2"
  local color="${GREEN}" # Default to success (green)

  if [[ $status == "error" ]]; then
    color="${RED}"
  fi

  echo -e "${color}${message}${NC}"
}

###########################################
# Function to check command exit status   #
###########################################
check_exit_status() {
  if [[ $1 -ne 0 ]]; then
    status_message "error" "$2"
    exit 1
  fi
}

#######################################################
# Start the installation of Docker and Docker Compose #
#######################################################
echo
echo -e "${GREEN}Starting the installation of Docker and Docker Compose (v2)...${NC}"
echo

# Update apt package index
sudo apt-get update
check_exit_status $? "Failed to update apt package index."

# Install prerequisites
sudo apt-get install -y ca-certificates curl gnupg lsb-release
check_exit_status $? "Failed to install prerequisites."

# Add Docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
check_exit_status $? "Failed to add Docker GPG key."

# Set up the Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
check_exit_status $? "Failed to set up the Docker repository."

# Update the apt package index again
sudo apt-get update
check_exit_status $? "Failed to update package index after setting up the repository."

# Install Docker Engine, CLI, containerd, and Compose plugin
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
check_exit_status $? "Failed to install Docker."

# Verify installation
sudo docker --version && docker compose version
check_exit_status $? "Docker installation might have issues."

clear
echo
echo -e "${GREEN}Docker and Docker Compose(v2) installation completed.${NC}"
echo

#######
# NPM #
#######
echo -ne "${GREEN}Enter Time Zone: "; read TZONE; \
echo -ne "${GREEN}Enter NPM Port Number: "; read PORTN; \
echo | tr -dc A-Za-z0-9 </dev/urandom | head -c 35 > .secrets/db_root_pwd.secret && \
echo | tr -dc A-Za-z0-9 </dev/urandom | head -c 35 > .secrets/mysql_pwd.secret && \
sed -i "s|01|${TZONE}|" .env && \
sed -i "s|02|${PORTN}|" .env && \
rm README.md && \
rm letsencrypt/tmp && \
sudo rm -rf shared/ && \
sudo chown -R root:root .secrets/ && \
sudo chmod -R 600 .secrets/ && \
while true; do
    read -p "Execute 'docker compose up -d' now? (y/n)" yn
    case $yn in
        [Yy]* ) sudo docker compose up -d; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
