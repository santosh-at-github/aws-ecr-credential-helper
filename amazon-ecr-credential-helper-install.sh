#!/bin/bash
# This script installs and configures "amazon-ecr-credential-helper" on EC2 instance
# so that docker can pull images from ECR without executing "docker login" command.
# It also provides ability to pull docker images directly from ECR when a service is
# created in swarm mode and deployed on different instances.

# Works on RHEL7. Haven't tested on any-other OS yet.
# Execute the script as ec2-user
# After executing this script run docker service with "--with-registry-auth", it should work fine
# References:
#	https://github.com/awslabs/amazon-ecr-credential-helper
#	https://gist.github.com/tegansnyder/a2e36d09c13cc49b452dcc641981bc27
#	https://github.com/moby/moby/issues/25619

sudo yum install git wget -y
wget https://storage.googleapis.com/golang/go1.6.3.linux-amd64.tar.gz
tar xzvf go1.6.3.linux-amd64.tar.gz
sudo mv go /usr/local/
echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee -a /etc/profile
echo 'export GOPATH=/usr/local/go/dev' | sudo tee -a /etc/profile
echo 'export PATH=$PATH:$GOPATH/bin' | sudo tee -a /etc/profile
git clone https://github.com/awslabs/amazon-ecr-credential-helper.git
cd amazon-ecr-credential-helper
make docker
sudo cp -pv bin/local/docker-credential-ecr-login /usr/local/bin/
mkdir -p /home/ec2-user/.docker
echo '{"credsStore": "ecr-login"}' > /home/ec2-user/.docker/config.json

