# Docker
apt-get remove docker docker-engine docker.io containerd runc
apt-get update
apt --yes --no-install-recommends install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt --yes --no-install-recommends install docker-ce docker-ce-cli containerd.io
usermod --append --groups docker "$USER"
systemctl enable docker
printf '\nDocker installed successfully\n\n'

docker --version
printf '\nWaiting for Docker to start...\n\n'
sleep 5

# Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose   

chmod +x /usr/local/bin/docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/1.25.4/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

printf '\n\n'
docker-compose --version

printf '\nDocker Compose installed successfully\n\n'

snap install --classic code # or code-insiders

printf '\nVisual Studio Code installed successfully\n\n'
