# General docker commands
	- `docker ps` or 'docker ps -a`: Show the names of all the containers you have + the id you need and the port associated
	- `docker pull "NameOfTheImage"`: Pull an image from the dockerhub
	- `docker rm`: Allow to delete all the opened images
	- `docker exec -it "NameOfTheContainer" "CommandToExecute": executes a command in interative mode on a specific container
		and if you take of the flags "-it" it just executes the command in normal mode
	- `docker stop "NameOfTheContainer`: Stops the container

# Docker run
	- `docker run "NameOfTheDockerImage"`: To run the docker image
	- `docker run -d`: Run the container in the background
	- `docker run -p`: Publish a container's port to the host
	- `docker run -P`: Publish all exposed port to random ports
	- `docker run -it "ImageName`: The program will keep running and you´ll be able to interact with the container
	- `docker run -name sl mysql`: give a name for the container instead an ID
	- Example of a command: `docker run -d -p 7000:80 test:latest`

# Docker image
	- `docker image rm -f "ImageName/id": Delete the image, if it's running you need to kill it first
	- `docker image kill "name"`: Stop a running image

**How to write a dockerfile**

-> Create a filename dockerfile
-> Write your command inside the doc
-> Build the dockerfile with the command `docker build -t "NameYouChoose"`
-> Execute the dockerfile with the command docker run "NameYouChoose"

# Most common types of instructions
	- `FROM`: Defines a base for your image. For example: FROM debian
	- `RUN`: Executes any commands in a new layer on top of the current image and commits the result. RUN also has a shell form for running commands
	- `WORKDIR`: Sets the working directory for any RUN, CMD, ENTRYPOINT, COPY, and ADD instructions that follow it in the Dockerfile. 
		(You go directly in the directory you choose)
	- `COPY`: Copies new files or directories from and adds them to the filesystem of the container at the path
	- `CMD`: Lets you define the default program that is run once you start the container based on this image. Each Dockerfile only has one CMD,
		and only the last CMD instance is respected when multiple ones exist

**Docker-compose Commands**

	- `docker-compose up -d --build`: Create and build all the containers and they still run in the background
	- `docker-compose ps`: Check the status for all the containers
	- `docker-compose logs -f --tail 5`: See the first 5 lines of the logs od your container
	- `docker-compose stop`: stop a stack of your docker compose
	- `docker-compose down`: Destroy all your resources
	- `docker-compose config`: Check the syntax of your docker-compose file