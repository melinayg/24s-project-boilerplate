
Our project, GoGoMass, aims to develop a comprehensive database to capture the essence and variety of the Massachusetts social scene, catering to a variety of user-personas. In addition,  our database aims to help users find events across Massachusetts given certain criteria, like price point, distance, dietary restrictions, etc. It can be difficult to find exciting events to do without having to do extensive research or if you’re not a local, which is why our product can help their search. Users can narrow their search for specific activities that satisfy all their desires, ensuring that their time is well worth and exhilarating. In the age of social media, generation-z and millennials have notably lacked an amount of third-spaces, or places outside of the workplace/school and home. This app aims to increase access to social settings and amusement, in a user-friendly manner.

Group Members: Melina Yang, Nafisa Tasnia, Ala’a Tamam, Saariya Faraz, Rhoda Zerit

**VIDEO LINK**: https://drive.google.com/file/d/1jb_6aBURkeqc6criCuctnCankIZg1yut/view?usp=sharing











# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 




