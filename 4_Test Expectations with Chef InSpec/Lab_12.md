# Lab 12: Scan the Cloud Infrastructure to validate that configuration and installed software meet your compliance and security requirements.
- InSpec can also test specific cloud provider assets i.e. AWS IAM roles, security groups and other AWS resources.

Objective:
- Use InSpec to verify the state of your AWS Cloud Infrastructure
- Use HasiCorp's Terraform to create infratructure and then use InSpec to verify that infrastructure.

#### Note: This experiment is not done from the Host Machine. Rather the Chef Infra at Docker Workstation is used.
### Step 01: Environment Setup 
```bash
# 1.1 Download the docker-compose file which includes 1x workstation and 1x target machine
> wget https://raw.githubusercontent.com/learn-chef/inspec/master/docker-compose.yml
> cat docker-compose.yml
---
version: '3'
services:
  workstation:
    container_name: workstation             #(default user: root, password: password, hostname: workstation)
    image: learnchef/inspec_workstation     # Image 01: docker will pull it 
    stdin_open: true
    tty: true
    links:
      - target
    volumes:
      - .:/root
  target:                                   #(default user: root, password: password, hostname: target)
    image: learnchef/inspec_target          # Image 02: dokcer will pull it      
    stdin_open: true
    tty: true

# 1.2 pull the docker images and up the docker containers in detached mode (-d)
> docker-compose pull
> docker-compse up -d 
---
Creating learn-inspec_target_1 ... done
Creating workstation           ... done

```

### Step 02: Environment Setup at Docker::Workstation

```bash
# 2.1 login to the workstation
> docker exec -it workstation bash

@workstation
root@61ccb62cf224:  # Docker Workstation
# 2.2 Check for the aws related inspec resources 
# The aws resources must be available in inspec, else this experiment cant be done
# for this experiment we need the following inspec aws resources: {aws_ec2_instance, aws_security_group
# aws_security_groups, aws_subnet, aws_subnets, aws_vpc, aws_vpcs }

> inspec shell
inspec> help resources
```
![](images/aws_resources.png)

```bash
# 2.3 Install awscli @workstation and configure aws
> apt-get update && apt-get install awscli
> aws --version           # aws-cli/1.18.69 Python/3.5.2 Linux/5.4.0-81-generic botocore/1.16.19
> aws configure

> cat ~/.aws/config 
---
[default]
output = json
region = us-west-1

> cat ~/.aws/credentials
---
[default]
aws_access_key_id = XXXXXXXXXXXXX
aws_secret_access_key = YYYYYYYYYYYYYYYYYYY/YYYY/YYYYYYYYY

# 2.4 Install terraform @workstation
> cd ~
> wget https://releases.hashicorp.com/terraform/1.0.5/terraform_1.0.5_linux_amd64.zip
> unzip terraform_1.0.5_linux_amd64.zip 
> mv terraform /usr/local/bin/
> terraform --version
---
Terraform v1.0.5
on linux_amd64
+ provider registry.terraform.io/hashicorp/aws v3.56.0

```

### Step 03: Build the terraform architecture into AWS
```bash
@workstation
# 3.1 Run terraform init to ensure the plugins you need are installed.
# Terraform installs the AWS provider driver based on the Terraform template that it found in the current directory.
> terraform init 
```
![](images/terra-init.png)

```bash
# 3.2 Lets see what resources it would create before you run Terraform to create your infrastructure
> terraform plan
```
![](images/terra-plan-1.png)
![](images/terra-plan-2.png)
![](images/terra-plan-3.png)
![](images/terra-plan-4.png)
![](images/terra-plan-5.png)
![](images/terra-plan-6.png)
![](images/terra-plan-7.png)
![](images/terra-plan-8.png)

```bash
# 3.3 Create the terraform architecture into AWS
> terraform apply -auto-approve  # -auto-approve flag can be omitted, but then terraform will ask for permission all the time

```