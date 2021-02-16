
# Here is the steps I used to pull the Jenkins image from dockerhub
# Note that you'll come across the first deprecated version. You'll have to pull the new one - jenkins/jenkins
docker pull jenkins/jenkins

# You cna specify a neme for your container
--name my-jenkins-svr 

# You can map a port - <host-port>:<container-port> by using the "-p" flag
# 8080 is the default port of container
-p 80:8080

# You can also map the default jenkins directroy (that will be created in the container)
# to a directory in your linux machine by using the "-v" flag
-v /root/new-folder:/var/jenkins_home

# You might encounter an permission error when you try to run the container with the flags.
# You can use the "-u" flag, followed by the user is your linux machine
-u root

# To combine them all up:
docker run --name my-jenkins-svr -u root -p 81:8080 -v /root/new-folder:/var/jenkins_home jenkins/jenkins
