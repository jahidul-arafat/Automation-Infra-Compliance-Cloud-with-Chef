# Lab 11: Scan the Cloud Infrastructure to validate that configuration and installed software meet your compliance and security requirements.
- InSpec can also test specific cloud provider assets i.e. AWS IAM roles, security groups and other AWS resources.

Objective:
- Use InSpec to verify the state of your AWS Cloud Infrastructure
- Use HasiCorp's Terraform to create infratructure and then use InSpec to verify that infrastructure.

```bash
ec2_instance_database = "i-0094c461f36b1461f"
ec2_instance_database_ami = "ami-0fdf8b5989f22a4e0"
ec2_instance_database_instance_type = "t2.micro"
ec2_instance_database_name = "database"
ec2_instance_database_private_ip = "10.0.100.111"


ec2_instance_webserver = "i-04baad45cf2c905f4"
ec2_instance_webserver_ami = "ami-0fdf8b5989f22a4e0"
ec2_instance_webserver_instance_type = "t2.micro"
ec2_instance_webserver_name = "webserver"
ec2_instance_webserver_public_ip = "54.219.71.73"
image_id = "ami-0fdf8b5989f22a4e0"


route_internet_access_id = "rtb-09883b4f2945b8150"
security_group_mysql_id = "sg-066af82a50803e651"
security_group_ssh_id = "sg-0eb9a53fcca10d27d"
security_group_web_id = "sg-0b6a930b9433c7462"

subnet_private_id = "subnet-015bb5cb61be74b4b"
subnet_public_id = "subnet-01dc3d968389fd40e"

vpc_id = "vpc-076ac46a147873e39"
```