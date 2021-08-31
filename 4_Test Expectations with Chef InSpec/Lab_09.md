# Lab 09: Automate the nginx compliance check
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
# At @workstation
# 1.1 Create a inspec profile named my_nginx
> inspec init profile my_nginx
---
Create new profile at /my_nginx
 * Create directory libraries
 * Create directory controls
 * Create file controls/example.rb
 * Create file inspec.yml
 * Create file README.md
 
 # 1.2 check the my_nignx profile structure
 > tree my_nginx
 ---
my_nginx
|-- README.md
|-- controls
|   `-- example.rb        # this is the main control file here. For this lab I will create another control file named 'test_nginx.rb'
|-- inspec.yml
`-- libraries

# 1.3 Lets have a look at the inspec.yml file
> cat my_nginx/inspec.yml
---
name: my_nginx
title: InSpec Profile
maintainer: The Authors
copyright: The Authors
copyright_email: you@example.com
license: Apache-2.0
summary: An InSpec Compliance Profile
version: 0.1.0

# 1.4 Check whats inside the controls/example.rb
> cat my_nginx/controls/example.rb
---
# encoding: utf-8
# copyright: 2018, The Authors

title 'sample section'

# you can also use plain tests
describe file('/tmp') do
  it { should be_directory }
end

# you add controls here
control 'tmp-1.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Create /tmp directory'             # A human-readable title
  desc 'An optional description...'
  describe file('/tmp') do                  # The actual test
    it { should be_directory }
  end
end

# 1.5(a) Create a new control file named controls/test_nginx.rb and add a new control to check versify that nginx version >=1.10.3
> vim my_nginx/controls/test_nginx.rb
---
  1 title 'Testing Nginx Compliances'
  2 
  3 control 'nginx-vesion' do
  4         impact 1.0        # Means <critical>
  5         title 'NGINX version'
  6         desc 'The required version of NGINX should be installed.'
  7         describe nginx do
  8                 its('version') {should cmp >='1.10.3'}
  9         end     
 10 end
 
 # 1.5(b) Check the control (2x: 1x in exmaple.rb:: for tmp + 1x in test_nginx.rb:: for nignx vesion) at Target machine from workstation
 > inspec exec my_nginx -t ssh://root:password@target
---
Profile: InSpec Profile (my_nginx)      # defined in inspec.yml
Version: 0.1.0                          # this version is defined in inspec.yml
Target:  ssh://root@target:22

  ✔  tmp-1.0: Create /tmp directory     # from controls/example.rb
     ✔  File /tmp should be directory   
  ✔  nginx-vesion: NGINX version        # from controls/try_nginx.rb
     ✔  Nginx Environment version should cmp >= "1.10.3"

  File /tmp
     ✔  should be directory

Profile Summary: 2 successful controls, 0 control failures, 0 controls skipped
Test Summary: 3 successful, 0 failures, 0 skipped

# 1.6(a) Add another control in my_nignx/controls/try_nginx.rb to check whether the followign three modules are installed or not: 
# ** http_ssl, stream_ssl, mail_ssl
> vim my_nginx/controls/try_nginx.rb
---
... (skipped)
 13 control 'nginx-modules' do
 14         impact 1.0
 15         title 'Nginx modules'
 16         desc 'The required NGINX modules should be installed'
 17         describe nginx do
 18                 its('modules') {should include 'http_ssl'}
 19                 its('modules') {should include 'stream_ssl'}
 20                 its('modules') {should include 'mail_ssl'}
 21         end
 22 end
 
# 1.6(b) Check this control in Target Machine from Workstation
> inspec exec my_nginx -t ssh://root:password@target
---
Profile: InSpec Profile (my_nginx)
Version: 0.1.0
Target:  ssh://root@target:22
  ... (skipped)
  ✔  nginx-modules: Nginx modules
     ✔  Nginx Environment modules should include "http_ssl"           # module found
     ✔  Nginx Environment modules should include "stream_ssl"         # module found
     ✔  Nginx Environment modules should include "mail_ssl"           # module found

  ... (skipped)

Profile Summary: 3 successful controls, 0 control failures, 0 controls skipped
Test Summary: 6 successful, 0 failures, 0 skipped

# 1.7 Verify the nginx config file [/etc/nginx/nginx.conf] permissions
# - is owned by the root user and group.
# - is not be readable, writeable, or executable by others.

# 1.7.1 Check at target machine the ll of /etc/nginx/nginx.conf file
> docker exec -it learn-inspec_target_1 bash
# @target
> ll /etc/nginx/nginx.conf 
-rw-r--r-- 1 root root 1462 Feb 11  2017 /etc/nginx/nginx.conf

# @workstation
# 1.7.2 Add another control in controls/try_nginx.rb
> vim my_nginx/controls/try_nignx.rb
---
... (skipped)
 24 control 'nginx-conf' do
 25         impact 1.0
 26         title 'NGINX configuration'
 27         desc 'The NGINX config file should be owned by root and be writable only by the owner an    d not readable+writable by others'
 28         describe file('/etc/nginx/nginx.conf') do
 29                 it {should be_owned_by 'root'}
 30                 it {should be_grouped_into 'root'}
 31                 it {should_not be_readable.by('others')}
 32                 it {should_not be_writable.by('others')}
 33                 it {should_not be_executable.by('others')}
 34         end
 35 end
 
# 1.7.3 Check the control in target machien from workstation
> inspec exec my_nginx -t ssh://root:password@target

Profile: InSpec Profile (my_nginx)
Version: 0.1.0
Target:  ssh://root@target:22

  ... (skipped)
  ×  nginx-conf: NGINX configuration (1 failed)
     ✔  File /etc/nginx/nginx.conf should be owned by "root"
     ✔  File /etc/nginx/nginx.conf should be grouped into "root"
     ×  File /etc/nginx/nginx.conf should not be readable by others           # Failed, because the file is readable by others
     expected File /etc/nginx/nginx.conf not to be readable by others
     ✔  File /etc/nginx/nginx.conf should not be writable by others
     ✔  File /etc/nginx/nginx.conf should not be executable by others
  ... (skipped)

Profile Summary: 3 successful controls, 1 control failure, 0 controls skipped # 1 Control failed
Test Summary: 10 successful, 1 failure, 0 skipped

```

### Because this control also has an impact of 1.0, your team may need to investigate further.