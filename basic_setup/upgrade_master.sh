#master 
export RELEASE=1.26.0 
sudo apt-get update &&  sudo apt-get install -y --allow-change-held-packages kubeadm=$RELEASE-00
kubectl drain k8s-control --ignore-daemonsets

sudo kubeadm upgrade plan v$RELEASE



sudo kubeadm upgrade apply v$RELEASE

sudo apt-get update &&  sudo apt-get install -y --allow-change-held-packages kubelet=$RELEASE-00 kubectl=$RELEASE-00

sudo systemctl daemon-reload

sudo systemctl restart kubelet

 kubectl uncordon k8s-control

kubectl get nodes