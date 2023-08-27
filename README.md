# **Inception**
School project 12

## **Description**
this project aims to teach about docker and docker compose

## **Learning-points**
- Understand what is a container
- Defferece between a container and a virtual machine
- What is an image
- How the network between containers and host work
- what is PID1 and a daemon
- what is docker compose and how to orcestrate container
- bests practice to write a Dockerfile

## **How to run**
clone this repository in your computer
```
git clone https://github.com/greedymelon/inception.git

```
then we need to do some customization: 
- change the PATH of our bind mount with the folder PATH in our machine.in the docker-compose.yml:
  modified $DB_DIR_PATH with the path of the database and $WP_DIR_PATH with the path of wordpress pages
- fill the .env file:
    change the value with our prefered one. Es: DATAB_NAME="Database name" DATAB_NAME="wordpress"
- this project is meant to run on localhost so to make it work correctly we have to add this line in the hosts file in our hostmachine
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
