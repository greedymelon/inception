# **Inception**
School project 12

## **Description**
this project aims to teach about docker and docker compose

## **Learning-points**
- Understand what is a container
- Defferece between a container and a virtual machine
- What is an image?
- How the network between containers and host works
- what is PID1 and a daemon
- what is docker compose and how to orcestrate container
- bests practice to write a Dockerfile

**What is a container** <br>
A container as per its name cointain all we need, to run our application, it solves for exemple one of the problem in this famous meme
<img src="https://github.com/greedymelon/inception/blob/main/images/memes.jpeg" height="250"/><br>

**Defferece between a container and a virtual machine** <br>
The main difference is that the container use the Kernel of the hostmachine that is why is so light and fast, you skip a big parte of the process. Both can be isolated from the hostmachine and configure to use a specific amount of resurces.

**What is a image?** <br>
An image is a blueprint, from it we can create multiple containers. We can run a image teken from the dockerhub, We can use a Dockerfile to create our own image (starting FROM scratch) or most commonly personalize an existing one to create our own.

**How the network between containers and host work** <br>
There are different types of networking that we can use with docker, in this project we use just 2 of them
The bridge network that act as a switch.
Docker has a default brige network in which container are automatically connected to: use it is bad practice because we want isolation between applications or containers in an application. The best practice is to create our own bridge network (docker network create 'NAME') and connect our container when we run it to it (--network 'NAME') with creating our own network also comes with other avantages: it create a DSN with the name of the container, in this way container in the same network can comunicate with each other throw their name, we can attached and detached containers from the network when we want, and some other.s
Port forwarding with the flag -p we can specify a port open to the outside world (-p 80:80) the default option is TCP

## **How to run**
clone this repository in your computer
```
git clone https://github.com/greedymelon/inception.git

```
then we need to do some customization: 
- change the PATH of our bind mount with the folder PATH in our machine.
    - In the docker-compose.yml: modified $DIR_PATH with the path of the folder
    - In the Makefile: modified $BINDM with the path of the folder
- fill the .env file:
    change the value with our prefered one. Es: DATAB_NAME="Database name" DATAB_NAME="wordpress"
- this project is meant to run on localhost so to make it works correctly we have to add this line in the hosts file in our hostmachine
  (substitute mywbsite.com with you website name)
    127.0.0.1  "mywebsite.com"
  
then ```make``` the build the images of the containers<br>
````
make
````
then ```make up``` to create and start the container<br>
````
make up
````

Now if we open our browser at our website name we wil find our wordpress website
