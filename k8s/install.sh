apt-get update && apt-get install -y apt-transport-https
apt-get install docker.io
apt-get install -y kubelet kubeadm kubectl --allow-unauthenticated
export KUBECONFIG=/etc/kubernetes/admin.conf