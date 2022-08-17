# scalac-tech-test

# create terraform/terraform.tfvars with next variables:
```
aws_region  = xxx
environment = xxx
application = xxx
aws_profile = xxx
vpc_cidr             = xxx
public_subnet_cidr  =  xxx
ssh_key_private      = xxx
jenkins_user = xxx
jenkins_password = xxx
github_user = xxx
github_password = xxx
github_repo = xxx
```
# deploy infra using terraform

```bash
$ cd terraform
$ terraform init
$ terraform plan
$ terraform apply
```
