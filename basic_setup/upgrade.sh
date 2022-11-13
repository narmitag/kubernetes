master 

sudo apt-get update &&  sudo apt-get install -y --allow-change-held-packages kubeadm=1.22.2-00
kubectl drain k8s-control --ignore-daemonsets

sudo kubeadm upgrade plan v1.22.2

sudo kubeadm upgrade apply v1.22.2
