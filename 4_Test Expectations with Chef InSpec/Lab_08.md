# Lab 08: Introduction to Chef Inspec

### Notes
- You can think of meeting your compliance and security goals as a two-phase process. We often refer to this process as detect and correct.
- The first phase, detect, is knowing where your systems are potentially out of compliance or have potential security vulnerabilities. 55% of organizations do compliance assessments inconsistently or not at all.
- The second phase, correct, involves remediating the compliance failures you've identified in the first phase. 58% of organizations need days or more to remediate issues.

### Step 01: Creating the Lab Environment
```bash
# 1.1 Make a directory called learn-inspec
> mkdir learn-inspec
> cd learn-inspec

# 1.2 Download the docker-compose file which includes 1x workstation and 1x target machine
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

# 1.3 pull the docker images and up the docker containers in detached mode (-d)
> docker-compose pull
> docker-compse up -d 
---
Creating learn-inspec_target_1 ... done
Creating workstation           ... done

```

### Step 2: Test the inspec commands in workstation
```bash
# 2.1 loginto the workstation
> docker exec -it workstation bash

root@61ccb62cf224:  # Docker Workstation

# 2.2 Run the following Chef Inspec commands
> inspec detect       # to detect your workstation environment
---
== Platform Details

Name:      ubuntu
Families:  debian, linux, unix
Release:   16.04
Arch:      x86_64

> inspec shell         # enter into the inspec shell in the workstation machine
---
Welcome to the interactive InSpec Shell
To find out how to use it, type: help
... (Skipped)

inspec> help          # Check the available inspec commands exists
---
Available commands:

    `[resource]` - run resource on target machine
    `help resources` - show all available resources that can be used as commands
    `help [resource]` - information about a specific resource
    `help matchers` - show information about common matchers
    `exit` - exit the InSpec shell

inspec> help resources  # List all available inspec resources
 - aide_conf
 - apache
 - apache_conf
 - apt
 - audit_policy
 - auditd
 - auditd_conf
 - aws_cloudtrail_trail
 - aws_cloudtrail_trails
 - aws_cloudwatch_alarm
 - aws_cloudwatch_log_metric_filter
 - aws_ec2_instance
 - aws_iam_access_key
 - aws_iam_access_keys
 - aws_iam_group
 - aws_iam_groups
 - aws_iam_password_policy
 - aws_iam_policies
 - aws_iam_policy
 - aws_iam_role
 - aws_iam_root_user
 - aws_iam_user
 - aws_iam_users
 - aws_kms_keys
 - aws_route_table
 - aws_s3_bucket
 - aws_security_group
 - aws_security_groups
 - aws_sns_topic
 - aws_subnet
 - aws_subnets
 - aws_vpc
 - aws_vpcs
 ... (Skipped)
 - nginx
 - nginx_conf
 - npm
 - ntp_conf
 - oneget
 - oracledb_session
 - os
 - os_env
 - package
 - packages
 - parse_config
 - parse_config_file
... (Skipped)

```

### Step 03: Exploring file resource @workstation
```bash
# 3.1 Run a sample test to chek whether the file /tmp exists in workstation
inspec> describe file('/tmp') do
inspec>   it {should be_directory}  
inspec> end  
---
Profile: inspec-shell
Version: (not specified)

  File /tmp
     ✔  should be directory     # See, its a success, means the /tmp directory exists

Test Summary: 1 successful, 0 failures, 0 skipped

# 3.2 List all available methods in file resource
inspec> file('/tmp').class.superclass         # => Inspec::Resources::FileResource
inspec> file('/tmp').class.superclass.instance_methods(false).sort
---
=> [:allowed?,
 :basename,
 :block_device?,
 :character_device?,
 :contain,
 :content,
 :directory?,
 :executable?,
 :exist?,
 :file,
 :file?,
 :file_version,
 :gid,
 :group,
 :grouped_into?,
 :immutable?,
 :link_path,
 :linked_to?,
 :md5sum,
 :mode,
 :mode?,
 :mount_options,
 :mounted?,
 :mtime,
 :owned_by?,
 :owner,
 :path,
 :pipe?,
 :product_version,
 :readable?,
 :selinux_label,
 :setgid?,
 :setuid?,
 :sgid,
 :sha256sum,
 :size,
 :socket?,
 :source,
 :source_path,
 :sticky,
 :sticky?,
 :suid,
 :symlink?,
 :to_s,
 :type,
 :uid,
 :version?,
 :writable?]

# 3.3 Experiment several file methods
# ** In Ruby, false and nil are false; everything else evaluates to true.
inspec> file('/tmp').directory?
=> true
inspec> file('/tmp').owner
=> "root"
inspec> file('/tmp').group
=> "root"
inspec> file('/tmp').type
=> :directory
inspec> file('/tmp').mounted?
=> false
inspec> file('/tmp').mtime
=> 1519147030
inspec> file('/tmp').size
=> 4096
```

### Step 04: Exploring nginx resource @workstation
Let's say that your web server or application requires:
- **NGINX** version 1.10.3 or later
- the following NGINX modules to be installed:
  - **http_ssl** 
  - **stream_ssl** 
  - **mail_ssl**
- the NGINX configuration file, _/etc/nginx/nginx.conf_, to:
  - be owned by the **root** user and group
  - **not** be _readable_, _writable_ or _executable_ by **others**
```bash
# 4.1 Check what nginx resources are available in inspec @workstation
inspec> help resources
---
 - nginx
 - nginx_conf
 
# 4.2 Check available functionalities of nginx resource
> help nginx
---
Name: nginx
Description: Use the nginx InSpec audit resource to test information about your NGINX instance.

Example:
describe nginx do
  its('conf_path') { should cmp '/etc/nginx/nginx.conf' }
end
describe nginx('/etc/sbin/') do
  its('version') { should be >= '1.0.0' }
end
describe nginx do
  its('modules') { should include 'my_module' }
end

# 4.3 list all the methods available for resource::nginx
inspec> nginx.class.superclass      # => Inspec::Resources::Nginx
inspec> nginx.class.superclass.instance_methods(false).sort
=> [:bin_dir,
 :compiler_info,
 :error_log_path,
 :http_client_body_temp_path,
 :http_fastcgi_temp_path,
 :http_log_path,
 :http_proxy_temp_path,
 :http_scgi_temp_path,
 :http_uwsgi_temp_path,
 :lock_path,
 :modules,
 :modules_path,
 :openssl_version,
 :params,
 :prefix,
 :sbin_path,
 :service,
 :support_info,
 :to_s,
 :version]

# 4.4 Check the nginx version [meantime if you got error, means nginx might not have installed]
# ** Though package resoruce figure out whether nginx is installed or not
inspec> nginx.version
---
NoMethodError: undefined method `[]' for nil:NilClass       # Error and NilCall--> means nginx might not have installed @workstation machine
from /opt/inspec/embedded/lib/ruby/gems/2.4.0/gems/inspec-2.0.17/lib/resources/nginx.rb:39:in `block (2 levels) in <class:Nginx>'

inspec> package('nginx').installed?     # Checking whether the package nginx is really installed or not @workstation
=> false
```

### Step 05: Run the InSpec Shell on the Target Machine from workstation 
- ** dont try this from my ubuntu host machine
- ** Target machine has nginx installed, but doesnt has InSpec CLI installed
- ** Chef InSpec is agentless
```bash
# 5.1 Run the inspec shell in target machine using <-t ssh://root:password@target>
> inspec shell -t ssh://root:password@target

# 5.2 Check if nginx installed in target machine and its version
@target machine
inspec> nginx.version
=> "1.10.3"
inspec> package('nginx').installed?
=> true

# 5.3 List all nginx modules and check whether the modules: http_ssl, stream_ssl, and mail_ssl, are installed or not
inspec> nginx.modules
=> ["http_ssl", # installed
 "http_stub_status",
 "http_realip",
 "http_auth_request",
 "http_addition",
 "http_dav",
 "http_geoip",
 "http_gunzip",
 "http_gzip_static",
 "http_image_filter",
 "http_v2",
 "http_sub",
 "http_xslt",
 "stream_ssl",  # installed
 "mail_ssl"     # installed
 ]

# 5.4 Examine the contents of NGINX configuration file /etc/nginx/nginx.conf

```