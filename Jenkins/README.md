## Design for the Jenkins Pipeline

<img src="./design.png"/>

#### Create and run docker image locally for application

1. Download or clone the github repository with application code

`git clone https://github.com/kushaggarwal/NodeJSApp.git`

2. In the root directory, run the below command to build the image from Dockerfile

`docker build -t webserver . `

3. Check for the build image to be present

`docker images `

4. Run the container from the image created

`docker run -p 9000:3000 webserver`

5. Go to http:localhost:9000/ to check for the application to be runing in docker container
