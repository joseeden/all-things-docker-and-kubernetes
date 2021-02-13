

# These steps listed below are for Ubuntu Desktop 18 LTS. You can find the full official docs and steps for other Linux distributions here:

Ubuntu: https://docs.docker.com/install/linux/docker-ce/ubuntu/

Fedora: https://docs.docker.com/install/linux/docker-ce/fedora/

CentOS: https://docs.docker.com/install/linux/docker-ce/centos/

Debian: https://docs.docker.com/install/linux/docker-ce/debian/

#---------------------------------------------------------------------------------------

# Installing Docker

# The Docker docs suggest setting up a Docker repository to install and update from.
# This is where you should start:

https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository

# After completing the installation steps, test out Docker:

sudo docker run hello-world

# This should download and run the test container printing "hello world" to your console.

#---------------------------------------------------------------------------------------

# Installing Docker Compose

# Unlike the Mac and Windows Docker Desktop versions, we must manually install Docker Compose. See the instructions for the installation steps (Click on the tab for Linux)

https://docs.docker.com/compose/install/#install-compose

# After completing, test your installation:

docker-compose -v

# This should print the version and build numbers to your console.

#---------------------------------------------------------------------------------------

# Run without Sudo

# Follow these instructions to run Docker commands without sudo:

https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user

# The docker group will likely already be created, but you still need to add your user to this group.

#---------------------------------------------------------------------------------------

# Start on Boot

# Follow these instructions so that Docker and its services start automatically on boot:

https://docs.docker.com/install/linux/linux-postinstall/#configure-docker-to-start-on-boot

# You may need to restart your system before starting the course material.

