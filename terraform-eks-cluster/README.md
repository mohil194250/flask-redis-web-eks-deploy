# Steps to deploy EKS cluster on AWS using Terraform

### Step 1: Launch EKS cluster using TF

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
4. Deploy 
```
$ terraform apply --auto-approve
```
