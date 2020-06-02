# #!/bin/bash
 
# install awscli
echo " Installing AWS CLI"
apt-get update
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt install -y unzip
unzip awscliv2.zip
./aws/install
# install kubectl
echo "Installing kubectl"
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
#optional
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc 
# install eksctl
echo "Installing eksctl"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
mv /tmp/eksctl /usr/local/bin
# installing pyhton3
echo "Installing Python3"
apt-get install software-properties-common
add-apt-repository ppa:deadsnakes/ppa
apt-get update
apt-et install pyhton3.6
# installing pip
echo "Installing Pyhton pip"
apt-get install -y python3-pip
# installing ansible
echo "Installing ansible"
pip3 install -U ansible
# installing openshift module
echo "Installing opensift module"
pip3 install -U openshift
# installing boto, boto3 and botocore
echo "Installing botocore and boto with boto3"
pip3 install -U botocore
pip3 install -U boto
pip3 install -U boto3

echo "Thats it, now Your ready to copy your aws key over."
echo " Please use the following to give right permissions and formation: chmod 600 key.pem and ssh-keygen -y -f key.pem > public_key.pem"
echo " Testi if Your AWS credentials work for example with a test querry "aws ec2 describe-instances""
