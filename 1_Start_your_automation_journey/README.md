# Start Your Automation Journey

## 1.0 Key Objectives
- Define IT Automation
- List some of Chef Software's customers
- Explain what some Chef Automation products and solutions do
- Explain where Chef Software fits into DevSecOps

## 2.0 About Chef
| Feature | Remarks |
| :--- | :--- | 
| Chef Infra | First Product, 2008 --> is a set of tools to automate the configuration of cloud-based and on-prem server infrastructure |
|Chef| Chef can automate you build, deploy and manage your infrastructure|
|Chef INFRA| Infrastructure automation to provision, harden and maintain configuration state.|
|Chef INSPEC| Security and Compliance automation in any environment, on any platform|
|Chef HABITAT| Automation capabilities for defining, packaging and delivering applications.|
|Chef COMPLIANCE| Compliance with Speed and Efficiency|
|Chef AUTOMATE| Provides operational visibility and organizational collaboration for everything you automate|

## 3.0 Environment Setup
### Step 3.1: Packages in Chef Workstation
Chef Workstation includes:
- **Chef Infra Client**: An agent &#8594; that runs locally on **every_node** under the management of Chef Infra Server.
- **Chef InSpec**: is a **Language** &#8594; for describing security & compliance rules &#8594; can be shared between *Software engineers, operations and Security Engineers.*
- **Chef Command Line Tool**: to apply dynamic, repeatable configuratios to your servers directly over **SSH** via **chef-run**. This provides a quick way to apply **config changes** to the systems you manage &#8594; whether of not the systems are being actively managed by **Chef Infra** &#8594; without require any preinstalled software
- **Test Kitchen**: can test cookbooks across any combination of platforms and test suites &#8594; Before you deploy those cookbooks to your *actual* **infrastructure nodes**
- Plus various **Test Kitchen** & **Knife plugins**

### Step 3.2: Install Chef Workstation Package
```bash
# Download Chef-workstation and install
# This will be installed in /opt/chef-workstation/ directory

> curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec

# Check the chef version installed
> chef --version
Chef Workstation version: 21.8.555
Chef Infra Client version: 17.3.48   # This is the chef version
Chef InSpec version: 4.38.9
Chef CLI version: 5.4.1
Chef Habitat version: 1.6.351
Test Kitchen version: 3.0.0
Cookstyle version: 7.15.4
```

## 4.0 Sample Scenarios
### 4.1 Chef Infra
#### A. Scenario 01: When happens when user pushes cookbooks into Chef Infra Server
> User is uploading a set of chef cookbooks to the chef infra server.

> Chef Cookbooks: is a set of configuration files, called **recipes** &#8594; responsible for instantiate, configure and maintain your infrastructure nodes in an automated fashion (physical/virtual).

> The Chef Infra server in turn loads those cookbooks to the correct nodes.

> ![img.png](images/img.png)

#### B. Example 01: Webserver install,enable,start
> Install an Apache Web Server package (httpd)

> Create a file on that node called **/var/www/html/index.html**

> enable and start the Apache web server
```ruby
# install the apache package named 'httpd'
package 'httpd'

# load the index.html.erb template under the cookbook into /var/www/html/index.html
template '/var/www/html/index.html' do
  source 'index.html.erb' # this is under the cookbooks/cookBookName/template directory
end

# Enable and Start the httpd service
service 'httpd' do
  action [:enable, :start]
end
```


