# Lab 05
## Experiment Name: XXXX
### Learning Objective:
- To learn about **knife profiles** :: is the ability to quickly and easily switch from one Chef Infra to another
- To configure **knife profiles** by adding them to **~/.chef/credentials** file @workstation (_TOML formatted_)

> ### A glimps of knife
> With knife, you can create distinct profiles that allow you to quickly and easily switch from interacting with one Infra Server to another Infra Server
>
> #### knife helps you manage and maintain:
> - Nodes
> - Cookbooks and recipes
> - The enforcement of Policies
> - Resources within various cloud environments
> - The installation of Chef Infra Client onto nodes
> - Searching of indexed data about your infrastructure
>
> *** _To see knife in action: you need a Chef Infra Server for knife to interact with._

> **Some useful knife commands**
>
> **A**. **knife bootstrap**
> - allows you to iniitiate a process that installs Chef Infra Client on the target system and
> - configures the Infra Client to be able to communicate with Infra Server.
> - It registers the target system as **node** on the Infra Server,
> - thus allowing the Infra Server to manage which and when policies are enforced, and thus automating your infrastructure management
```bash
# Some useful knife bootstrap commands
** BOOTSTRAP COMMANDS **
knife bootstrap [PROTOCOL://][USER@]FQDN (options)
knife bootstrap azurerm SERVER (options)
Usage: /usr/bin/knife (options)
knife bootstrap windows ssh FQDN (options) DEPRECATED
knife bootstrap windows winrm FQDN (options) DEPRECATED
```

> **B**: **knife node**
> - knife bootstrap command registers the target system as a node on the Infra Server.
> - Once the target system is registered, the knife node command allow you to update the policies on any one or more of your managed nodes.
```bash
# Some useful knife node commands
** NODE COMMANDS **
knife node bulk delete REGEX (options)
knife node create NODE (options)
knife node delete [NODE [NODE]] (options)
knife node edit NODE (options)
knife node environment set NODE ENVIRONMENT
knife node from file FILE (options)
knife node list (options)
knife node policy set NODE POLICY_GROUP POLICY_NAME (options)
knife node run_list add [NODE] [ENTRY [ENTRY]] (options)
knife node run_list remove [NODE] [ENTRY [ENTRY]] (options)
knife node run_list set NODE ENTRIES (options)
knife node show NODE (options)
```

> **C**: **knife ssh**
> - With all the Target systems are registered as node on the Infra Server, now you need to push
> - the policies (create/updates) into the nodes.
> - For that you need to connect the nodes remotely using knife ssh command.
```bash
# Some useful knife ssh commands
** SSH COMMANDS **
knife ssh QUERY COMMAND (options)

```

### Step 01: Check the chef version and create a khife repository
```bash
# 1.1 Check the chef version and make sure the version is >=16.0
> chef --version
---
Chef Workstation version: 21.8.555
Chef Infra Client version: 17.3.48  # Chef version
Chef InSpec version: 4.38.9
Chef CLI version: 5.4.1
Chef Habitat version: 1.6.351
Test Kitchen version: 3.0.0
Cookstyle version: 7.15.4

# 1.2 create a new directory named knife-repo where we will download a preconfigured Vagrant file
> mkdir knife-repo
> cd knife-repo

# 1.3 Download the Vagrant file
# this Vagrant file has a Ubuntu-16.04 configuration which will install Chef Automate server into the workstation
> wget https://learnchef.s3.eu-west-2.amazonaws.com/knife-profiles/Vagrantfile

# 1.4 Lets have a look at the Vagrant file
> vim Vagrantfile
```
![](images/knife-Vagrant.png)

### Step 02: Check the vagrant status and create the VM using 'vagrant up' command
