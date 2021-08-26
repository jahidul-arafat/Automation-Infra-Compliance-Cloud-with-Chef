# Lab 01: Learn Chef Infra
Prepare a cookbook to deploy two Test instances ( 1X Ubutnu 18.04 and 1X Centos-7) using and converging the changes into it in a agile process.

## PART-01: Environment setup and generating cookbook
### Step 01: Install Chef and check the chef version
```bash
# Install Chef
> curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec

# Check the chef version and identify the current chef Infra version
> chef --verison
Chef Workstation version: 21.8.555
Chef Infra Client version: 17.3.48 # <--- NOTE
Chef InSpec version: 4.38.9
Chef CLI version: 5.4.1
Chef Habitat version: 1.6.351
Test Kitchen version: 3.0.0
Cookstyle version: 7.15.4
```

### Step 02: Generate a cookbook named 'learn_chef'  and check its structure
```bash
# Generate the cookbook named 'learn_chef'
> chef generate cookbook learn_chef

#Check the cookbook structure
> tree learn_chef
learn_chef/
├── CHANGELOG.md
├── chefignore
├── kitchen.yml     # <-- We will now inspect it and try to understand its structure
├── LICENSE
├── metadata.rb
├── Policyfile.rb
├── README.md
├── recipes
│   └── default.rb
└── test
    └── integration
        └── default
            └── default_test.rb

```

### Step 03: Understand the kitchen.yml
```bash
# Test Kitcehn was built to use several different flexible settings
# This kitchen.yml is a combinaiton of several key-value pairs
# Lets see the newly originated kitchen.yml file
# What this file do? - this file instructs Test Kitchen to use Vagrant to create two instances
# One Ubuntu and one CentOS and then use Chef Infra to provision the test instances 

> cd learn_chef
> cat kitchen.yml
....
driver:             # here this instance will load with vagrant in virtualBox
  name: vagrant     # However, this could be docker too, in that case the name would be 'dokken' with provider 'chef'

provisioner:        # this tool execute the suites against the test instance(s)
  name: chef_zero   # 

verifier:
  name: inspec

platforms:          # OS or target environment(s) on which your policies are to be tested
  - name: ubuntu-20.04  # Target/Test Instance 01 from **bento** repo maintained by Chef
  - name: centos-8      # Target/test Instance 02 from **bento** repo 

suites:             # The policies and code which will be enforces on the test instance(s)
  - name: default   # test/integration/default/default_test.rb
    verifier:
      inspec_tests:
        - test/integration/default
    attributes:
```

### Step 04: Check the kitchen list to see whether the target instances are provisioned or not
```bash
# Check the kitchen list
# Mote: See the Target OS is yet to provision with last action _<Not Created>_
> kitchen list
....
Instance             Driver   Provisioner  Verifier  Transport  Last Action    Last Error
default-ubuntu-2004  Vagrant  ChefInfra    Inspec    Ssh        <Not Created>  <None>
default-centos-8     Vagrant  ChefInfra    Inspec    Ssh        <Not Created>  <None>
```

### Step 05: Create Test Instances using _kitchen create_ command and check the kitchen list after creattion
```bash
# Create the Target/test instances (2x: Ubuntu + Centos)
> kitchen create

-----> Starting Test Kitchen (v3.0.0)
-----> Creating <default-ubuntu-2004>...
       Bringing machine 'default' up with 'virtualbox' provider...
       ...
-----> Creating <default-centos-8>...
       Bringing machine 'default' up with 'virtualbox' provider...
       ==> default: Importing base box 'bento/centos-8'...

# Check the kitchen list again
> kitchen list 
Instance             Driver   Provisioner  Verifier  Transport  Last Action  Last Error
default-ubuntu-2004  Vagrant  ChefInfra    Inspec    Ssh        Created      <None>
default-centos-8     Vagrant  ChefInfra    Inspec    Ssh        Created      <None>
# ** See the 2X Test instances are <created>

# Now, test whether the newly created Test Instances are accessible
> kitchen login centos
> kitchen login ubuntu
```

## PART 02: Writing infra code and deploying the changes
### Step 01: Create a ~/etc/motd file in both the Target/Test instances
> **Note:**
> - Infra resource will be used: **file**
> - file need to be created : /etc/motd
> - Target Instances: centos, ubuntu
> - Where to write this? - in **recipe/learn-chef.yml**
> - learn-chef.yml is a newly created recipe
> - recipe can be written both in Ruby or YML

```bash
# Create a new recipe named recipe/learn-chef.yml
> vim recipe/learn-chef.yml
---
resources:
  - type: "file"
    name: "/etc/motd"
    content: "Learning Chef is fun with YAML!"
    
# But kitchen will only look for the recipe written in recipe/default.rb
# So, include our newly created recipe/learn-chef.yml into recipe/default.rb
> vim recipe/default.rb
---
include_recipe "learn_chef::learn-chef"  # include_recipe "<cookbook_name::recipe_name>"
```

### Step 02: Deploy the changes in Test Instances using **kitchen converge**
#### Step 2.1: Create a /etc/motd file with content "Learning Chef is fun with YAML!" for both Test Instances and verify at login
```bash
# Deploy the changes in Test Instances
> kitchen converge
---
-----> Starting Test Kitchen (v3.0.0)
-----> Converging <default-ubuntu-2004>...
       Preparing files for transfer
-----> Converging <default-centos-8>...
       Preparing files for transfer

# Check the Test instance status (converged or not??)
> kitchen list 
Instance             Driver   Provisioner  Verifier  Transport  Last Action  Last Error
default-ubuntu-2004  Vagrant  ChefInfra    Inspec    Ssh        Converged    <None>
default-centos-8     Vagrant  ChefInfra    Inspec    Ssh        Converged    <None>
# ** See, both instances are converged with the changes

# Check whether the new motd message shown at Test Instance login
> kitchen login centos
Learning Chef is fun with YAML!                   # New /etc/motd message
Last login: Thu Aug 26 10:46:44 2021 from 10.0.2.2

> kitchen login ubuntu
Learning Chef is fun with YAML!                   # New /etc/motd message
Last login: Thu Aug 26 10:46:33 2021 from 10.0.2.2
```

#### Step 2.2: Configure a Apache2 Web Server for both Test Instances

