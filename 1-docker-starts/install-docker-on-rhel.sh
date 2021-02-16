
# These steps ae the ones I followed to install docker on RHEL 8/CentOS in an Amazon EC2 instance.

# Btw, a detailed steps can also be found in docker's official documentation:
https://docs.docker.com/engine/install/centos/

# View version of OS - I've serarched that RHEL8 supports docker but I still included this here.
ll /etc/*release
cat /etc/*release

# Update base image
sudo yum -y update

# Uninstall older versions of docker - if one exists
sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

# Install docker.
# There are two ways here:
#   1.  Install from a package - Setup repository and install from there.
#   2.  Install from a script - Use the convenience scripts

# NOTE - Method 2 is NOT RECOMMENDED for production environments

$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh

# NOTE - I encountered an error here when I run the script. Not sure if it doesn't work with RHEL8.
# The docker site only shows for CentOS. 

# Check docker version
sudo docker version
# ------------------------------------------------------------------------------------------------------------
# Run a simple container to check.
# We'll run two sample containers: whalesay and nyancat.
# For reference, you can check the images from dockerhub.com
https://hub.docker.com/r/docker/whalesay
https://hub.docker.com/r/06kellyjac/nyancat

# Sample container 1
sudo docker run docker/whalesay cowsay Infinity-and-beyond!

# Once it finished, you should see something like this:
Status: Downloaded newer image for docker/whalesay:latest
 _____________________ 
< Infinity-and-Beyond >
 ---------------------
    \
     \
      \
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
        \    \        __/
          \____\______/

# Sample container 2
sudo docker run -it --rm --name nyancat 06kellyjac/nyancat

# Once it finished, you should see an animated nyancat.


# ------------------------------------------------------------------------------------------------------------
# NOTE: If you encounter this error:
# docker: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?.
# 
# You might try to start the docker service or start the daemon
# To start docker service:
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
#
# To start docker daemon
sudo dockerd
#
# You can read more about it here:
https://stackoverflow.com/questions/44678725/cannot-connect-to-the-docker-daemon-at-unix-var-run-docker-sock-is-the-docker
# ------------------------------------------------------------------------------------------------------------
