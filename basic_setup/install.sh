cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf 
overlay 
br_netfilter 
EOF
 
sudo modprobe overlay 
sudo modprobe br_netfilter



cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf 
net.bridge.bridge-nf-call-iptables = 1 
net.ipv4.ip_forward = 1 
net.bridge.bridge-nf-call-ip6tables = 1 
EOF

sudo sysctl --system
sudo apt-get update && sudo apt-get install -y containerd

sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

sudo swapoff -a
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet=1.24.0-00 kubeadm=1.24.0-00 kubectl=1.24.0-00
sudo apt-mark hold kubelet kubeadm kubectl

sudo kubeadm init --pod-network-cidr 10.1.0.0/16 --kubernetes-version 1.24.0
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml


kubeadm join 192.168.0.201:6443 --token 3v4z5z.wbxj0pb2phqyxo6t --discovery-token-ca-cert-hash sha256:7bf7df82c4269cfecaf5fa48a16e31eb23e94a10446988b1d0135dab7337cead
