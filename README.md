# EKS-RDS-wordpress
EKS cluster with RDS setup on AWS for a wordpress deployment
--------------------------------------------------------------
This repository contains tooling for deploying EKS cluster with workers using
etctl, RDS mysql database and Wordpress Kubernetes deployment with ansible.

#Prerequisites
---------------

The tooling has been tested on ubuntu 16.04 LTS. Your going to need a user
with sudo rights.

Use the IAM.json to give the nessesary user rights for the AWS user.

Get the key from AWS to the same folder where You setup this tooling.
For more information: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
Please use the following to give right permissions and formation: chmod 600 key.pem and ssh-keygen -y -f key.pem > public_key.pem
It is important that You save the key as public_key.pem as this is the file
name which the script will user.

You can use the prerequisites.sh to install the nessesary tools required to
get the installation working. If not, lets walk through the nessesary steps:

1. Install awscli like this:
        sudo apt-get update
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        sudo apt install -y unzip
        sudo unzip awscliv2.zip
        sudo ./aws/install

2. Configure aws cli to use the aws user credentials, which user rights we
previously changed. Used eu-west-2 as region, as this will be the default
region. If You want to use some other region, check if the aws services are
offered on the other region.
        aws configure

3. Install kubectl:
        curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl
        sudo chmod +x ./kubectl
        mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
optional task
        echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

4. install eksctl:
        sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
        mv /tmp/eksctl /usr/local/bin

5. Install or upgrade python 3:
        sudo apt-get install software-properties-common
        sudo add-apt-repository ppa:deadsnakes/ppa
        sudo apt-get update
        sudo apt-et install pyhton3.6

6. Install pip for pyhton:
        sudo apt-get install -y python3-pip

7. Install ansible:
        sudo pip3 install -U ansible

8. Install openshift module:
        sudo pip3 install -U openshift

9. Install boto, boto3 and botocore modules:
        sudo pip3 install -U botocore
        sudo pip3 install -U boto
        sudo pip3 install -U boto3

10. Optional:
Testi if Your AWS credentials work for example with a test querry "aws ec2 describe-instances

#Creating the EKS cluster, RDS and wordpress site
--------------------------------------------------

Now your ready to create the EKS cluster, RDS cluster, wordpress deployment
and services needed to support those.

If You want to change the RDS instance name and credentials, modify the
vars.yml before proceeding.

For diagnostic reasons, the public key will be used to give us ssh access.
Please doublecheck that your key meets the requirements. The key region and
the region where the cluster will be created, must match.

Execute the create-K8S-RDS-wordpress.sh script to create the services.
Please be patient as the services creation can take up to 20-30 minutes.

When the script finishes, use the kubectl tooling to check if the kubernetes
nodes are operational, wordpress pod is up and which URL has been configured
for the wordpress site.
Example commands: kubectl get nodes -o wide
                  kubectl get pods
                  kubectl get svc
