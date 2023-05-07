# codespaces

 Pull Docker image
 ```bash
 docker pull mysql/mysql-server:latest

 # Docker commands
 docker --help
 docker ps 
 docker images


 # Start a Docker container from the image
 docker run --name <container_name> -e MYSQL_ROOT_PASSWORD=<my-secret-pw> -d mysql/mysql-server:latest

 docker run --name mysql -e MYSQL_ROOT_PASSWORD=mysql -d mysql/mysql-server:latest

 -e : Environment variable
 -d : detached mode


# Connecting to the MySQL container database
 docker exec -it mysql mysql -uroot -p

 # Stop, Remove a Container
 docker stop <container-name/container-id> #Stop a container
 docker rm <container-name/container-id>

 #First, create a network:
 docker network create --subnet=172.18.0.0/24 tooling_app_network 

 docker network ls # List a network

# Working with MySQL
export MYSQL_PW=mysql #Create password

# Start a container
docker run --network tooling_app_network -h mysqlserverhost --name=mysql-server -e MYSQL_ROOT_PASSWORD=$MYSQL_PW  -d mysql/mysql-server:latest 

-h host
--network network name
--name container name
-e environment variables

docker ps # List container

# Create user.sql file 
CREATE USER ''@'%' IDENTIFIED BY ''; GRANT ALL PRIVILEGES ON * . * TO ''@'%'; 

# Pass in the SQL file to the container
docker exec -i mysql-server mysql -uroot -p$MYSQL_PW < create_user.sql

# Connect to the DB using client
docker run --network tooling_app_network --name mysql-client -it --rm mysql mysql -h mysqlserverhost -u  -p 

--name gives the container a name
-it runs in interactive mode and Allocate a pseudo-TTY
--rm automatically removes the container when it exits
--network connects a container to a network
-h a MySQL flag specifying the MySQL server Container hostname
-u user created from the SQL script
admin username-for-user-created-from-the-SQL-script-create_user.sql
-p password specified for the user created from the SQL script

# Cloning Tooling Application

git clone https://github.com/darey-devops/tooling.git 

export tooling_db_schema=tooling/html/tooling_db_schema.sql

Edit line 20 of db_conn.php file

# Build docker image 
docker build --help
docker build -t tooling:0.0.1 . 

# Start tooling app using the network created earlier
docker run --network tooling_app_network --name tooling-app -p 8085:80 -it tooling:0.0.1 

