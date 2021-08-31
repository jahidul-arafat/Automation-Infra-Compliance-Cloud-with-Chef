# Lab 10: Automate the nginx compliance check | Seperating Logic and Data
Let's say that your web server or application requires:
- **NGINX** version 1.10.3 or later
- the following NGINX modules to be installed:
    - **http_ssl**
    - **stream_ssl**
    - **mail_ssl**
- the NGINX configuration file, _/etc/nginx/nginx.conf_, to:
    - be owned by the **root** user and group
    - **not** be _readable_, _writable_ or _executable_ by **others**

> ### Given: the controls from Lab 09
```ruby
control 'nginx-version' do
  impact 1.0
  title 'NGINX version'
  desc 'The required version of NGINX should be installed.'
  describe nginx do
    its('version') { should cmp >= '1.10.3' }
  end
end

control 'nginx-modules' do
  impact 1.0
  title 'NGINX version'
  desc 'The required NGINX modules should be installed.'
  describe nginx do
    its('modules') { should include 'http_ssl' }
    its('modules') { should include 'stream_ssl' }
    its('modules') { should include 'mail_ssl' }
  end
end

control 'nginx-conf' do
  impact 1.0
  title 'NGINX configuration'
  desc 'The NGINX config file should owned by root, be writable only by owner, and not writeable or and readable by others.'
  describe file('/etc/nginx/nginx.conf') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_readable.by('others') }
    it { should_not be_writable.by('others') }
    it { should_not be_executable.by('others') }
  end
end
```

### Task: From this control, you have to separate the logic and data and have to make this control file more dynamic rather than static.

### Step 01: Create a profile file named files/params.yml
```bash
# 1.1 Loginto the workstation
> docker exec -it workstation bash

@ workstation

# 1.2 Create a profile file named files/params.yml to store the parameters
> mkdir -p my_nginx/files
> vim my_nginx/files/params.yml
---
  1 version: 1.10.3
  2 modules:
  3   - http_ssl
  4   - stream_ssl
  5   - mail_ssl

```

### Step 02: Make the controls/try_nginx.rb file more dynamic by including the files/params.yml
```ruby
# 2.1 Make the controls/try_nginx.rb file more dynamic by including the files/params.yml
  1 title 'Testing Nginx Compliances'
  2 
  3 # Importing the parameters from Profile file (params.yml) and return as a Dictionary
  4 nginx_params = yaml(content: inspec.profile.file('params.yml')).params
  5 
  6 # Get the version and module lists
  7 required_version = nginx_params['version']
  8 required_module_list = nginx_params['modules']
  9 
 10 
 11 control 'nginx-vesion' do
 12         impact 1.0
 13         title 'NGINX version'
 14         desc 'The required version of NGINX should be installed.'
 15         describe nginx do
 16                 its('version') {should cmp >= required_version}         # Changed
 17         end
 18 end
 19 
 20 
 21 control 'nginx-modules' do
 22         impact 1.0
 23         title 'Nginx modules'
 24         desc 'The required NGINX modules should be installed'
 25         describe nginx do
 26                 required_module_list.each do |req_mod|                  # Added
 27                         its('modules') {should include req_mod}         # Changed
 28                 end                                                     # Added
 29         end
 30 end
 31 
 32 control 'nginx-conf' do
 33         impact 1.0
 34         title 'NGINX configuration'
 35         desc 'The NGINX config file should be owned by root and be writable only by the owner an    d not readable+writable by others'
 36         describe file('/etc/nginx/nginx.conf') do
 37                 it {should be_owned_by 'root'}
 38                 it {should be_grouped_into 'root'}
 39                 it {should_not be_readable.by('others')}
 40                 it {should_not be_writable.by('others')}
 41                 it {should_not be_executable.by('others')}
 42         end
 43 end


# 2.2 Test the controls into Target Machine from workstation
> inspec exec my_nginx -t ssh://root:password@target
---
Profile: InSpec Profile (my_nginx)
Version: 0.1.0
Target:  ssh://root@target:22

... (skipped)
✔  nginx-version: NGINX version
✔  Nginx Environment version should cmp >= "1.10.3"
✔  nginx-modules: NGINX version
✔  Nginx Environment modules should include "http_ssl"
✔  Nginx Environment modules should include "stream_ssl"
✔  Nginx Environment modules should include "mail_ssl"
×  nginx-conf: NGINX configuration (1 failed)

... (skipped)


```

### Step 03: Now you can test any number of moduls without altering the control files
```bash
# 3.1 Say, check whether the nginx module 'http_geoip' is installed in target machine ot not
# just add this module name into files/params.yml and you are done
> vim my_nginx/files/params.yml
---
version: 1.10.3
modules:
  - http_ssl
  - stream_ssl
  - mail_ssl
  - http_geoip

# 3.2 Test the control in Target Machine from Workstation
> inspec exec my_nginx -t ssh://root:password@target
---
  ✔  nginx-modules: NGINX version
     ✔  Nginx Environment modules should include "http_ssl"
     ✔  Nginx Environment modules should include "stream_ssl"
     ✔  Nginx Environment modules should include "mail_ssl"
     ✔  Nginx Environment modules should include "http_geoip"   # See, this module is found

> inspec check my_nginx 
---
Location:    my_nginx
Profile:     my_nginx
Controls:    5
Timestamp:   2021-08-31T10:56:44+00:00
Valid:       true
```