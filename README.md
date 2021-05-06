# flask-redis-web-eks-deploy-demo
Deployment of simple flask web application on AWS EKS


### Steps to deploy application on EKS

1. Create a Container registry in AWS ECR through console and upload flask_web_app image:

Change directory to project workspace
```
$ cd project_ws
```
Login to ECR
```
$ aws ecr get-login-password --region us-west-2 --profile poc_terraform | docker login --username AWS --password-stdin 421828925434.dkr.ecr.us-west-2.amazonaws.com
```
Build flask_web_app image from Dockerfile 
```
$ docker build -t flask_web_app .
```
Tag image 
```
$ docker tag flask_web_app:latest 421828925434.dkr.ecr.us-west-2.amazonaws.com/flask_web_app:latest
```
Push image to ECR
```
$ docker push 421828925434.dkr.ecr.us-west-2.amazonaws.com/flask_web_app:latest
```
