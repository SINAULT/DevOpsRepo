#Install Docker-----------------------------------------------------------------

#Si des précédentes versions de Docker été installées décommenter cette commande

#apt --yes --no-install-recommends remove docker docker-engine docker.io containerd runc

apt --yes --no-install-recommends install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

#Cet ajout de repo est pour Ubuntu uniquement !
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt update

apt --yes --no-install-recommends install docker-ce

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

systemctl daemon-reload
systemctl restart docker

#Install K8s---------------------------------------------------------------------

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt update
apt --yes --no-install-recommends install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

#Auto-completion
source /usr/share/bash-completion/bash_completion

#Pour voir si Bash Completion est bien lancé
type _init_completion 

echo 'source <(kubectl completion bash)' >>~/.bashrc

kubectl completion bash >/etc/bash_completion.d/kubectl