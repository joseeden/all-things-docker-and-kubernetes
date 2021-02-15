
#----------------------------------------------------------------------------------------

# This will run an image from a container.
docker run <image>

# As example, this will run an nginx container. 
# Docker will look in the host for the image, and if not found, will check dockerhub na dpull image down.
# Note that this is only done first time. For subsequest executions, the same image pulled down will be re-used.
docker run nginx

# This list all running containers.
# Each container will get a random 'silly name' assigned to it. 
# This is found in the last column of the output.
docker ps

# This list all running and not running containers.
# This also shows the state, 
# if not running - "Exited"
# if running - "Up"
docker ps -a

# Recall that each container will have their own "silly-names".
# You can set your own contianer-name by using the "--name" flag
sudo docker run --name Thanos_of_2019 docker/whalesay cowsay Im-Inevitable! 

# TAG
# You can also specify the version of image to run in case
# you have multiple versions of an image by specifying "image:version"
# This is called the TAG.
# In this example, we'll pull down two versions of nginx.
sudo docker nginx
sudo docker nginx:1.14-alpine

# To run a container from the 1.14-alpine image and 
# set container-name to nginx-2
sudo docker run -d --name nginx-2 nginx:1.14-alpine

# To know all the available tags for an image, look for the image in dockerhub.com
# and you'll find all the supported tags there.

# You can run multiple isntances/containers from the same image
sudo docker run docker/whalesay cowsay Infinity-and-beyond!
sudo docker run docker/whalesay cowsay Hello-there!
sudo docker run docker/whalesay cowsay Cowabunga!
# This will show three running containers when you list them.
$ sudo docker ps -a
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS                      PORTS     NAMES
b4b832aecfb9   docker/whalesay   "cowsay Cowabunga!"      8 seconds ago    Exited (0) 7 seconds ago              happy_gates
a870817d8e27   docker/whalesay   "cowsay Hello-there!"    2 minutes ago    Exited (0) 2 minutes ago              festive_elion
16e5d555d741   docker/whalesay   "cowsay Infinity-and…"   41 minutes ago   Exited (0) 41 minutes ago             friendly_feistel

# This pulls the image down to our host but doesn't run a container.
sudo docker pull <image-name>
sudo docker pull nginx

# This lists all images present in our host.
docker images

# This stops a running container.
# You can use the "silly-name" or first few digits of the container-id.
# If the first 2 or 3 digits of the container-id is unique, 
# docker will immediately know which container you want to stop.
docker stop <silly-name>
docker stop <container-id>

# This removes the container permanently.
# List all containers afterwards to check
docker rm <silly-name>

# You can also remove all stopped containers AT ONCE by running the ps command
# and passing it to the rm command.
# Note that it'll return an error if there is a running container.
sudo docker rm $(sudo docker ps -a -q)

# This removes an image permanently.
# NOTE that no container must be running off of that image.
# Delete all dependent containers to delete an image.
docker rmi <image-name>

# NOTE that containers are not meant to run operating systems
# Container are meant to run a specific task or process.
# Once task is complete, the container exits.
# The container runs as logn as the process inside it is alive.
# When you run ubuntu, you're just running a base-image of an OS.
# There is no application/process running in it by default.
sudo docker run ubuntu

# You can instruct a process to run by appending the command.
# IN this case, we're telling ubuntu to sleep for 60 seconds.
# This will appear as a running process for a minute when we run docker ps
# After that, container will exit.
sudo docker run ubuntu <command>
sudo docker run ubuntu cat /etc/hosts

# We can also execute a command on a running container
sudo docker exec <container-id> <command>
sudo docker exec <silly-name> <command>

# If container is running, we can use exec to exeucte a command.
sudo docker ps
sudo docker exec <container-id> cat /etc/hosts
sudo docker exec <silly-name> cat /etc/hosts

#----------------------------------------------------------------------------------------

# ATTACH MODE
# You can run a container is an ATTACH mode - this means process will run in the foreground.
# you cannot do anything else while process is attached to the console until container exits.
# Console won't response to any input, except if you stop it by running Ctrl-C

# As an example, we can run a simple web-server that listens on port 8080
sudo docker run kodekloud/simple-webapp
# Run docker ps
$ sudo docker ps
CONTAINER ID   IMAGE                     COMMAND           CREATED          STATUS          PORTS      NAMES
734e84936864   kodekloud/simple-webapp   "python app.py"   30 seconds ago   Up 29 seconds   8080/tcp   relaxed_grothendieck
# Stop the container

# DETACH MODE
# You can run a container in the background mode by using the "-d" flag.
# By doing this, you can still work on the console while container runs in the background.
sudo docker run -d ubuntu sleep 60

# To attach to the running container in the background
sudo docker ps
sudo docker attach <container-id>
sudo docker attach <silly-name>

# You can also run and automatically log in to the container by using the "-it" flag.
sudo docker run -it -d --name nyancat2 06kellyjac/nyancat

#----------------------------------------------------------------------------------------

# INPUTS

# By default, a docker container doesn't listen to standard input.
# It runs in a non-interactive shell.
# You can map the standard input of your host to the docker container using the "-i" flag.
# You can also map your terminal to the container's terminal by using the "-t" flag
# "-i"  - interactive
# "-t"  - terminal

# As an example, we can use a simple image of an app that promps user for its name.
docker pull kodekloud/simple-prompt-docker
docker run -it kodekloud/simple-prompt-docker

#----------------------------------------------------------------------------------------

# PORT MAPPING

# Recall that the underlying host (your machine) where docker is installed is called 
# DOCKER HOST or DOCKER ENGINE
# If you want to access your app in the container through a web browser, you can use the 
# container's IP, but note that this is an internal IP is only accessible from the host itself.
# Note also that users outside the host cannot access this IP.

# To get the IP address;
docker ps
docker inspect <container-id>

# To access the ip from within the host, you can open the ip address in a browser in the host.
# You can also do a curl in the host's terminal
# Note that 8080 is the default port of the container
curl <ip-of-vm>:8080

# You can also use the IP of the docker host, but you need to map the port inside the container
# to the free port inside the docker host.
# We can use the "-p" flag to map the ports

# As an example, we can use to map container port 5000 to host port 80
docker run -d -p 80:8080 kodekloud/simple-webapp

# To see the port mappings in your linux machine:
netstat -tulpn

#----------------------------------------------------------------------------------------

# DATA PERSISTENCE

# If you have a database inside the container, the data in it will be lost as soon as the
# container exist or is removed. If you want to persist data, 
# you can map a directory (in the container) to another directory(in the docker host)
# you can use the "-v" flag, followed by the directory mappings
# "-v"  - volume mapping
docker run -v <host-dir>:<container-dir> <image>

# As an example, I have created a /opt/mysqldir in my linux machine
# and then mapped it to the default mysql directory inside the container.
docker run -v /opt/mysqldir:/var/lib/mysql mysql

#----------------------------------------------------------------------------------------

# LOGS

# To see the logs, you can simply use the logs command
docker ps
docker logs <container-id>

#----------------------------------------------------------------------------------------


