#!/bin/sh -eux

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
setenforce 0
systemctl stop firewalld
systemctl disable firewalld
yum update -y
yum install -y docker kubelet kubeadm kubectl kubernetes-cni --nogpgcheck
systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet
