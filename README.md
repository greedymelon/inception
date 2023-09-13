# **Inception**
School project 12

## **Description**
this project aims to teach about docker and docker compose

## **Learning-points**
- What is a container?
- The differences between a container and a virtual machine
- What is an image?
- How does the network between containers and the host work?
- What is PID1 and a daemon?
- What are volumes and bind mounts?
- What is docker compose?
- Best practices to write a Dockerfile

**What is a container?** <br>
A container, as per its name, contains all we need to run our application. It solves, for example, the problem in this famous meme. <br>
<img src="https://github.com/greedymelon/inception/blob/main/images/memes.jpeg" height="250"/><br>

**Differences between a container and a virtual machine** <br>
The main difference is that the container uses the Kernel of the host machine, which is why it is so light and fast. You skip a big part of the process, while in a Virtual machine, you have to install the whole operating system. Both can be isolated from the hostmachine and configured to use a specific amount of resources. <br>

**What is an image?** <br>
An image is just a blueprint. From it, we can create multiple containers. We can run an image taken from the docker hub. We can use a Dockerfile to create our image (starting FROM scratch) or, most commonly, personalize an existing one to create our own. <br>

**How does the network between containers and the host work?** <br>
There are different types of networking that we can use with docker. In this project, we use just 2 of them: <br>
- The bridge network works like a switch for the containers. 
Docker has a default bridge network to which containers are automatically connected. Using it is a bad practice because we want isolation between applications or containers in an application. The best practice is to create our bridge network (docker network create 'NAME') and connect our container to it when we run it (--network 'NAME'). Creating our network also comes with other advantages: it creates a DSN with the name of the containers associated with the IP. In this way, containers in the same network can communicate with each other through their names, and we can attach and detach containers from the network at any given moment.. <br>
- Port forwarding opens a port to the outside world. By adding the flag -p, we can specify which port to open (-p 80:80). The default protocol is TCP. <br>

**What is PID1 and a daemon?** <br>
PID1 is the process associated with the container. We want it to remain the main process because is the one in which signals are sent. If we run bash in a container, for example, all the signals sent to the container will be ignored. To solve this problem when we run a bash/sh script as an ENTRYPOINT, we need to execute execve with our service at the end of it. In this way, we will start a new process for it that has PID1. This is not the best practice for a Dockerfile; we should write the running service as a CMD instruction (ex. CMD ["mariadb-safe"]),  and add at the end of our script 'exec "$@"' where $@ is the command line argument(in our case the command in CMD). <br>
A daemon is simply a process that runs in the background. To keep a container alive we need to have a program running in the foreground. There are two ways to do so: running a service that remains in the foreground or turning off a daemon mode of our service.<br>

**What are volume and bind mounts?** <br>
Volumes are storage space in which the content is hidden from the host machine; they are available only inside docker, so you cannot see the content from the outside. They are independent of the container they are bound with, so if the container is destroyed, the data inside them remain available to docker until specifically deleted (docker volume rm 'NAME'). A volume can be shared by different containers. To make a volume available for a container, we have to decide which container's folder will be connected to it, for example -v VolumeName:/var/folder. <br>
Bind mounts are just folders or files that are bound to the host machine's folder or file. When you change a file on your host machine, the change is also reflected to the container and vice versa<br>

**What is docker compose?** <br>
Docker-compose is a tool that allows us to orchestrate containers. It uses a docker-compose.yml (or .yeml) file in which all the single parts needed to run our application are together. Instead of creating a network and then connecting our container (one at a time) to it, everything is done automatically. When we run a command of docker-compose, we need to specify which docker-compose.yml we are referring to or have it in the same directory. Through docker-compose, we can see only things related to our application, which is very handy when you have multiple applications running at the same time. In this project, we run the docker-compose commands through a Makefile to make everything even smoother. <br>

**Best practices to write a Dockerfile** <br>
The best practices are available in the Docker's documentation. I will list some that I find relevant to this project. <br>
An image has layers, and every time you use one of these instructions a new layer is created:  RUN, COPY, ADD. This is important to keep in consideration because apart from the image size, we can have also some issues. Every time we change or add one of these instructions, all the instructions after are executed again, but not the ones before: If we do 'RUN apt update' and then 'RUN apt install', we risk having old packages because 'apt update' won't be executed again. For this reason, we should always execute these two commands together, and to make maintenance easier, write each packet in alphabetical order on a new line followed by a space and a '\' (to see some examples you can just open a Dockerfile on this project). <br>
If we need to forward a port, we should add EXPOSE with the port's number. This doesn't do anything (it doesn't open a port) but has a documentation purpose for whom can run our application.
Another thing that I find relevant is the WORKDIR that execute all the instruction happening after it in the directory we choose: using cd create confusion. <br>

## **Structure of this application**
As you can see in the following image, in this project, we had to create three different containers, two volumes (bind mount), a personalised bridge network and just a single port open to the outside.<br>
<img src="https://github.com/greedymelon/inception/blob/main/images/structure.png" height="500" /><br>

## **How to run**
1. Clone this repository in your computer:
```
git clone https://github.com/greedymelon/inception.git
```
2. Perform some customizations: 
- Change the PATH of our bind mount with the folder PATH in your machine.
  In the 'docker-compose.yml' and in the 'Makefile', replace "/your/folder/path" with the     actual path to your folder
- Fill the .env file:<br>
    change the values to your preference. Es: DATAB_NAME="Database_name" DATAB_NAME="WordPress"
- in the 'nginx.conf' file, modify "yourwebsite.com" to your desired website name.
- Since this project is meant to run on localhost, add this line in the hosts file in your host machine <br>
  (Substitute "yourwebsite.com" with your website's name) <br>
    127.0.0.1  "yourwebsite.com" <br><br>

The Makefile is only meant for Mac and Linux host machines, the instructions to run it on Windows are at the end of this section. <br>
3. **Using the Makefile on Linux or Mac** <br>
then ```make``` to build the images of the containers<br>
````
make
````
then ```make up``` to create and start the container<br>
````
make up
````
Now, if you open your browser at your website name with HTTPS, you will find your WordPress website. In case you receive a warning of not being secure (this happens because the certificate in this project is not validated), just ignore it. <br>
To stop and destroy our container: <br>
````
make down
````
<br>


4.**Without Makefile on Windows:** <br>
- Move to the 'srcs' directory and build the images<br>
````
cd srcs; docker compose build
````
- Create and start the container <br>
````
docker compose up --detach
````
Now, if you open your browser aty our website name with HTTPS, you will find your WordPress website. In case you receive a warning of not being secure (this happens because the certificate in this project is not validated), just ignore it.<br>
- To stop and destroy our container: <br>
````
docker compose down
````


## **Troubleshooting**
- If you run this application on Windows, remember to run the terminal (or the program you open this project with ex. VScode) as administrator. We need the administrator's right also to modify the hosts file. <br>
- Make sure Docker is running and correctly installed. <br>
