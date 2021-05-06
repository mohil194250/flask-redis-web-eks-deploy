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

2. Install kompose on local sytem to translate Docker Compose file to menifest files:
```
$ curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-linux-amd64 -o kompose
$ chmod +x kompose
$sudo mv ./kompose /usr/local/bin/kompose
```
3. Convert the docker-compose.yml file to k8s menifest files:
```
$ kompose convert
```
It will create menifest files- web-service.yaml,web-deployment.yaml and redis-deployment.yaml


4. Create service and deployments on cluster:
```
$  kubectl apply -f web-service.yaml,web-deployment.yaml,redis-deployment.yaml
```
This command will create a ClusterIP service, deployments for web app and redis.

6. verify deployment - desired service and pods running:
```
$ kubectl get svc
   NAME   TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
   web    ClusterIP   172.20.63.76   <none>        5000/TCP   43m

$ kubectl get pods
   NAME                     READY   STATUS    RESTARTS   AGE
   redis-76d69bb8b8-87sp4   1/1     Running   0          32m
   web-5969885766-r55x7     1/1     Running   0          42m
```

*** Further we can expose serice outside of cluster using ALB ingress *** 

