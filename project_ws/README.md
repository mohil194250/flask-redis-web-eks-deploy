### Steps to deploy application locally using Docker compose

1. Create a project workspace directory:  

```
$ mkdir project_ws
```

2. Create a file called app.py in project_ws directory for sample flask web application:  

```
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    count = redis.incr('hits')
    return 'Total visits {} times.\n'.format(count)

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
```  

3. Create requirements.txt file in project_ws directory having list of packages that required to install in docker image:  

```
flask
redis
```

4. Create a Dockerfile in project_ws that builds docker image:  

The image contains all the dependencies the Python application requires.   

```
FROM python:3.10.0b1-alpine3.13
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "app.py"]

```

It will build an image starting with the Python.  
Add the current directory . into the path /code in the image.  
Set the working directory to /code.  
Install the Python dependencies.  
Set the default command for the container to python app.py.  

5. Create a file docker-compose.yml in project_ws directory:
Define services in a Docker Compose file 

```
version: '3'
services:
  web:
    build: .
    ports:
     - "5000:5000"
  redis:
    image: "redis:alpine"
```

This Compose file defines two services, web and redis. The web service:  

Uses an image that’s built from the Dockerfile in the current directory.  
Forwards the exposed port 5000 on the container to port 5000 on the host machine. We use the default port for the Flask web server, 5000.  
The redis service uses a public Redis image pulled from the DockerHub registry.  

6. Build and run application with Compose  
```
$ docker-compose up
```
Compose pulls a Redis image, builds an image for your code, and start the services defined.  

Enter http://<host_ip>:5000/ in a browser to see the application running.
