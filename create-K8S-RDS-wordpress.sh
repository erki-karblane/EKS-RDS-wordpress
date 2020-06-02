#!/bin/bash
# create EKS cluster with worker nodes, new VPC, subnets, sg, etc
echo "Creating EKS cluster"
eksctl create cluster --name EKS-CLUSTER --version 1.16 --region eu-west-2 --nodegroup-name standard-workers --node-type t2.micro --nodes 3 --nodes-min 1 --nodes-max 4 --ssh-access --ssh-public-key public_key.pem --managed
 
sleep 300
echo "EKS cluster with corresponding VCP, SG,nodes and Nat GW complete"
# create RDS instance with networking
echo "Creating RDS database with networks, network group and ACL to be accessed by EKS"
echo " If You want to change the wordpress sql username and password, edit the vars.yml before proceeding"
ansible-playbook -v RDS.yml
echo "Waiting for the RDS instance to come up"
sleep 1200
# deploy the wordpress kubernetes deployment
echo "RDS is up, configuring wordpress deployment in kubernetes"
ansible-playbook -v kube.yml
sleep 180
echo "Wordpress deployment is operation"
# when the wordpress pod is operational, look up the loadbalancers URL for the service
echo "Please use the below URL to access the wordpress site"
kubectl get svc | grep wordpress
echo "Thats it, the Wordpress site is up, please configure it"