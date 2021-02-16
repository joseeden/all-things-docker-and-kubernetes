
#----------------------------------------------------------------------------------------

# You can create your own image if you want to dockerize your application
# for ease of shipping and deployment

# We need to first understand how the application is built.
# Start by listing down how you might deploy an application manually.

# As an example, if we are to deploy a web application,
# this would be the steps we'll follow"

1.  Start with OS - CentOS
2.  Update repo
3.  Install dependencies
4.  Install python dependencies
5.  Copy source code to /opt folder
6.  Run the web server using the flask command

# Once you have the steps laid down, you can begin containerizing your application:

1.  Create a DOCKERFILE
2.  Build your image and specify the file as input, as well as the tag name
3.  Push it to the dockerhub repository to make it publicly available

#----------------------------------------------------------------------------------------

# DOCKERFILE
# Textfile written in a format that docker can understand.
# The dockerfile for a flask application is specified below.

FROM UBUNTU                                                 # Specify the base image

RUN yum update -y                                           # RUN instructs docker to run specific commands
RUN yum install -y python

RUN yum install flask
RUN yum install flask-mysql

COPY . /opt/source-code                                     # Copy files from local system to docker image

ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run      # specify command that will be run when the image 
                                                            # is run as a container


# When the image is build, it follows the order specified in the dockerfile
docker build Dockerfile -t username/my-app

#----------------------------------------------------------------------------------------

# SAMPLE - DEPLOYING APPLICATION MANUALLY FIRST

# Here we run a centos container first with bash running so that we can manually
# install dependencies first
docker pull centos
docker run -it -p 81:5000 -v /home/centos/flask:/opt centos bash

# Once centos container is running, we can proceed with installing dependencies
# and deploying the app
yum update -y
yum install -y python3
yum install -y python3-pip

pip3 install flask

cd /opt

FLASK_APP=app.py flask run --host=0.0.0.0

# Note that I'm running this container on an EC2 instance.
# Make sure the mapped port is allowed in the security group of the EC2 instance.
# To test if this works, copy the EC2 instance's public ip and open it in a browser.
# Don't forget the port. 
# It should return a 'Welcome!' message
31.98.63.3:81
# As an additional step, append '/how are you' to the url
# This should return another message
31.98.63.3:81/how are you

# Once everything is tested, we can now safely say that the steps we did can be
# written in the dockerfile

FROM centos

RUN yum update -y
RUN yum install -y python3 python3-pip
RUN pip3 install flask

COPY app.py /opt/app.py

ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0

# Now to build the image
# Make sure to switch tot he directory where the app.py and Dockerfile is.
# Also specify a tag for the image by using the "-t" flag
# Include your dockerhub accountname as well
docker build . -t edenjose/simple-flask-app

# You should now see a new image created
docker images

# To test this, run a container from that newly built image
# Note that I have the app.py in /home/centos/flask in my local machine
# so I'll just map the container's /opt directory to my local machine's flask directory
docker run -p 81:5000 -v /home/centos/flask:/opt --name sample-flask simple-flask-app

#----------------------------------------------------------------------------------------

# PUSHING TO DOCKERHUB
# You can now make your image publicly available through the dockerhub.
# Recall that when we build the image, we specify our account name, followed by image tag.
# This is because if you dont specify the org or username, it will be pushed to the defualt LIBRARY.
# You'll get an error when you do do this:
docker push simple-flask-app

# Also, before you push, you must login to your dockerhub account first
docker login

docker push edenjose/simple-flask-app