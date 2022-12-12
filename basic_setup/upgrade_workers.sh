

export RELEASE=1.26.0 


sudo apt-get update && 
sudo apt-get install -y --allow-change-held-packages  kubeadm=$RELEASE-00

sudo  kubeadm upgrade node

sudo apt-get update &&  sudo apt-get install -y --allow-change-held-packages kubelet=$RELEASE-00 kubectl=$RELEASE-00

sudo systemctl daemon-reload
sudo systemctl restart kubelet

