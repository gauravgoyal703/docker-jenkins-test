#!/bin/bash

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Fix for Sonarqube Elastic Search Issue
sysctl -w vm.max_map_count=262144

# Jenkins permissions
mkdir -p /var/jenkins_home
chown -R 1000:1000 /var/jenkins_home/

# run docker-compose
docker-compose build
docker-compose --env-file config/.env.dev up -d

# run jenkins
#mkdir -p /var/jenkins_home
#chown -R 1000:1000 /var/jenkins_home/
#docker build -t jenkins:jcasc .
#docker run -p 8080:8080 -p 50000:50000 --env sonarcreds=${{ secrets.SONARCREDS }} --env githubCodeRepoCredentials=${{ secrets.GITHUBCODEREPOCREDENTIALS }} --env JENKINS_ADMIN_ID=${{ secrets.JENKINS_ADMIN_ID }} --env JENKINS_ADMIN_PASSWORD=${{ secrets.JENKINS_ADMIN_PASSWORD }} -v /var/jenkins_home:/var/jenkins_home -d --name jenkins --rm jenkins:jcasc

# run sonar
#docker run -d --name sonarqube -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true -p 9000:9000 -p 9092:9092 sonarqube:latest

# show endpoint
echo 'Jenkins and Sonar installed'
echo 'You should now be able to access jenkins at: http://'$(curl -s ifconfig.co)':8080'
echo 'You should now be able to access sonar at: http://'$(curl -s ifconfig.co)':9000'
