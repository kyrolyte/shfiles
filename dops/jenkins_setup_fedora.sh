# LTS - Original Source: https://www.jenkins.io/doc/book/installing/linux/
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf upgrade
# Add required dependencies for the jenkins package
sudo dnf install java-17-openjdk
sudo dnf install jenkins
sudo systemctl daemon-reload

# Notes
# A LTS (Long-Term Support) release is chosen every 12 weeks from the stream of regular releases as the stable release for that time period. It can be installed from the redhat-stable yum repository.
# Use redhat-stable for RHEL, CentOS and Alma Linux setups

# Starting Jenkins
# You can enable the Jenkins service to start at boot with the command:
sudo systemctl enable jenkins
# You can start the Jenkins service with the command:
sudo systemctl start jenkins
# You can check the status of the Jenkins service using the command:
sudo systemctl status jenkins

# Firewall 
# In most cases your firewall service will block port access to jenkins
# As superuser/root run the command below to create a permanent exception
YOURPORT=8080
PERM="--permanent"
SERV="$PERM --service=jenkins"

firewall-cmd $PERM --new-service=jenkins
firewall-cmd $SERV --set-short="Jenkins ports"
firewall-cmd $SERV --set-description="Jenkins port exceptions"
firewall-cmd $SERV --add-port=$YOURPORT/tcp
firewall-cmd $PERM --add-service=jenkins
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload
