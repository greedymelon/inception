# **Inception**
School project 12

## **Description**
this project aims to teach about docker and docker compose

## **Learning-points**
- Understand what is a container
- The defference between a container and a virtual machine
- What is an image?
- How the network between containers and host works?
- What is PID1 and a daemon?
- What are volumes and bind mounts?
- What is docker compose?
- Best practices to write a Dockerfile

**What is a container?** <br>
A container as per its name cointain all we need, to run our application, it solves for exemple one of the problem in this famous meme
<img src="https://github.com/greedymelon/inception/blob/main/images/memes.jpeg" height="250"/><br>

**Defferece between a container and a virtual machine** <br>
The main difference is that the container use the Kernel of the hostmachine that is why is so light and fast, you skip a big parte of the process while in Virtual machine you have to install the whole opereting system. Both can be isolated from the hostmachine and configure to use a specific amount of resurces. <br>

**What is a image?** <br>
An image is a blueprint, from it we can create multiple containers. We can run a image teken from the dockerhub, We can use a Dockerfile to create our own image (starting FROM scratch) or most commonly personalize an existing one to create our own. <br>

**How the network between containers and host work** <br>
There are different types of networking that we can use with docker, in this project we use just 2 of them
The bridge network that act as a switch.
Docker has a default brige network in which container are automatically connected to: use it is bad practice because we want isolation between applications or containers in an application. The best practice is to create our own bridge network (docker network create 'NAME') and connect our container when we run it to it (--network 'NAME') with creating our own network also comes with other avantages: it create a DSN with the name of the container, in this way container in the same network can comunicate with each other throw their name, we can attached and detached containers from the network when we want, and some other.s
Port forwarding with the flag -p we can specify a port open to the outside world (-p 80:80) the default option is TCP <br>

**what is PID1 and a daemon** <br>
PID1 is the process assosieted to the container, we want it to remain the main process bacause is the one in which signal are sent, if we run bash in a container for example, all the signal send to the container will be ignore the commun way. To solve this problem when we run a bash script as an ENTRYPOINT is to use execve at the of it so it will start the new process as PID1 and run the actual service with CMD so we will need to add at the end of our script 'exec "$@"' where $@ is the commandline argument in our case what is in CMD. 
A daemon is simply a process who runs in the background, to mantain a container alive we need to have a programm running on the foreground, there are two ways to do so: running a service that remain in foregraund or to turn off a daemon mode of our service. Some tricks like running bash (CMD ["BASH"]) ot tail are not a good practice. <br>

**what are volume and bind mounts** <br>
Volumes are storage space in which the content is hidden from the hostmachine and are available only inside docker, so you cannot see the content from the outside. They are independent from the container they are bind with so if the container is dystroid the data inside it remain available to docker until specifically deleted (docker volume rm 'NAME'). A volume can be share by different containers. To make a volume avaiable to a container we have to decide in which folder is going to be connected es -v VolumeName:/var/folder. <br>
Bind mounts are just folder or file that are bind to the hostmachine's folder or file, when you change a file on you hostmachine is right away avaible to the container and viceversa.

**What is docker compose?** <br>
Docker compose is a tool that allow you to orchestarte containers. It uses a docker-compose.yml (or .yeml) file in which all the single part needed to run our application are all togheter, instead of creating a network and then connect our container (one at the time) to it everything is done automaticly. When we run a command of docker compose we need to specify which docker-compose.yml we are efering to or have it in the same directory: through docker compose we can see only thing related to our application, that is very handy when you have multiple apllications running at the same time. In this project we run the docker compose command through a Makefile to make everithing even more smoothier.

**Best practices to write a Dockerfile**
The best practices are easly explained in the Docker documentatione, I will list some that I find relevant to this project. <br>
A image has layer and everytimes you use one of these instruction a new layer is created:  RUN, COPY, ADD. This is important to keep in consideration becase a part from the image size we can have also some issue. everytimes we change or add one of this istraction all the instrunction after it are executed again, but not the one before, if we do RUN apt update and the RUN apt install we risc to have old packeges becase 'apt update' won't be executed again, this why we should alwais execute this two command together, and to make maintainance easier  write each packet in alfabetical order on a new line follow by a space and a '\' (to understand better you can just open a dockerfile on this project). <br>
If we need to foword a port we should add EXPOSE with the numer of the port, this doesn't do anything (It doesn't open a port) but has a documentation porpose for whom can run our apllication.
Another thing that i find relevant is the WORKDIR that execute all the instruction appening after it in the directori we write after it, using cd create confusion.

## **Structur of this application**
How you can see in the following image, in this project we created 3 different conteiner two volume (bind mount) a personalize bridge-network and just a single port open to the outside.
<img src="https://github.com/greedymelon/inception/blob/main/images/structure.png" height="500" /><br>

## **How to run**
clone this repository in your computer
```
git clone https://github.com/greedymelon/inception.git

```
then we need to do some customizations: 
- change the PATH of our bind mount with the folder PATH in our machine.
    - In the docker-compose.yml and in the Makefile: modified "/your/folder/path" with the path of the folder
- fill the .env file:
    change the value with our prefered one. Es: DATAB_NAME="Database_name" DATAB_NAME="wordpress"
- in the nginx.conf modify "yourwebsite.com"
- this project is meant to run on localhost so to make it works correctly we have to add this line in the hosts file in our hostmachine
  (substitute "yourwebsite.com" with you website name)
    127.0.0.1  "yourwebsite.com"
  
then ```make``` the build the images of the containers<br>
````
make
````
then ```make up``` to create and start the container<br>
````
make up
````

Now if we open our browser at our website name we wil find our wordpress website
