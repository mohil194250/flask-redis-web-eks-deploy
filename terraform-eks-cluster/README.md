# Steps to deploy EKS cluster on AWS using Terraform

### Step 1: Launch EKS cluster using TF:

1. Change directoy to terraform project workspace
```
$ cd terraform-eks-cluster
```
2. initialize terraform project
```
$ terraform init
```
3. Plan and verify EKS infastructure before deploying to AWS
```
$ terraform plan
```
4. Deploy EKS cluster
```
$ terraform apply --auto-approve
```

### Step 2: Connect to cluster:
1.Add context of cluster (arn) in .kube/config file
```
$ aws eks --region us-west-2 update-kubeconfig --name eks --profile poc_terraform
```
2. Check accessebility to cluster using kubectl command
```
$ kubectl get nodes
```
Output of this command will show 2 worker nodes are up and running.



