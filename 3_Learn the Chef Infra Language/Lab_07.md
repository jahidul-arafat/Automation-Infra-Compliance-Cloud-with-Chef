# Lab 07
### **A**. Create, Update, Restore and Delete resources using Chef-Client (As a part of Chef Automate) <br>
### **B**. Create a webserver using chef-client in local machine

> ### Recall
> - A **Chef resource** describes one part of the system, such as a file, a template, or a package
> - A **Chef recipe** is a file that groups related resources, such as everything needed to configure a web server, database server, or a load balancer.
> - **Recipes organize resources**
> - Resources describe the what, not the how. That how part is handled by **Chef**.
> - Resources have actions:: When you deleted the file, you saw the **:delete** action.
> - When we created the file we didn't specify the **:create** action because **:create** is the **default**.

### Notes:
- In practice, it's common to configure **chef-client** to act as a service that runs periodically or as part of a continuous automation system such as Chef Automate. 
- Running Chef through automation helps to ensure that your servers remain configured as you expect and also enables them to be reconfigured when you need them to be.
- Example: **chef-client --local-mode hello.rb** 
- You can omit the **--local-mode** argument when you run **chef-client** to have your node check in with the Chef server to retrieve the latest cookbooks and system metadata.
- For learning purpose, we used **--local-mode** argument to apply cookbook directly to see how Chef works.
- In reality, you will get a **Chef server** and configure a **node** to work with it.
- Chef always restored the original configuration.



## A. Create, Update, Restore and Delete resources using Chef-Client (As a part of Chef Automate) <br>

### Step 01: Updating using chef-client
```bash
# 1.1 Create a new directory called lab07_motd and cd to it
> mkdir lab07_motd
> cd lab07_motd

# 1.2 Create a file named hello.rb which defines a resource named 'file' to create /tmp/motd with some content
> vim hello.rb
---
file '/tmp/motd' do
  content 'Hello World!!'
end

# 1.3 (First Time) Run the following chef-client command at your local machien to apply what you've written
> chef-client --local-mode hello.rb 
---
Converging 1 resources
Recipe: @recipe_files::/home/jarotball/study/Chef-Principle-Analyst-Exam-Prep/2_Learn the Chef Infra Language/lab07_motd/hello.rb
  * file[/tmp/motd] action create
    - create new file /tmp/motd
    - update content in file /tmp/motd from none to eb70c9
    --- /tmp/motd	2021-08-30 15:50:32.244644401 +0600
    +++ /tmp/.chef-motd20210830-1254-gfqr82	2021-08-30 15:50:32.244644401 +0600
    @@ -1 +1,2 @@
    +Hello Chef!!

Running handlers:
Running handlers complete
Chef Infra Client finished, 1/1 resources updated in 02 seconds   # 1/1 resource updated

# 1.4 Verify that /tmp/motd is created
> more /tmp/motd

# 1.5 (Second Time) Run the chef-client command again
> chef-client --local-mode hello.rb 
---
... (Skipped)
Chef Infra Client finished, 0/1 resources updated in 02 seconds   # because chef-client didnt found any changes and therey by didnt converge and didnt create the /tmp/motd file again

# 1.6 Update the hello.rb with a new content 'Hello Chef!!!' and converge this
> vim hello.rb
---
---
file '/tmp/motd' do
  content 'Hello Chef!!'    # Content Changed from Hello World --> Hello Chef!!!
end

# 1.7 (third time)Converge this change by running chef-client
> chef-client --local-mode hello.rb 
---
Chef Infra Client finished, 1/1 resources updated in 02 seconds   # See, Changes converrged and the /tmp/motd file updated
```


### Step 02: Restoring using chef-client
```bash
# 2.1 What if one of your co-worker accidentally modified the /tmp/motd file content
> echo 'hello robots' > /tmp/motd

# 2.2 Can we store the /tmp/motd file to its accepted stte as defined in hello.rb?
# yes, (fourth time) run the chef-client command again
> chef-client --local-mode hello.rb
---
Chef Client finished, 1/1 resources updated in 00 seconds   # it will restore the /tmp/motd file to its original and expected state as defined in hello.rb file
```

### Step 03: Delete the /tmp/motd file using chef-client
```bash
# 3.1 Create a file named goodby.rb with the following content
> vim goodbye.rb
---
file '/tmp/motd' do
  action :delete            # see resource action defined as :delete
end

# 3.2 Execute this file using chef-client
> chef-client --local-mode goodbye.rb
---
Recipe: @recipe_files::/home/jarotball/study/Chef-Principle-Analyst-Exam-Prep/2_Learn the Chef Infra Language/lab07_motd/goodbye.rb
  * file[/tmp/motd] action delete
    - delete file /tmp/motd         # See the file deleted

Running handlers:
Running handlers complete
Chef Infra Client finished, 1/1 resources updated in 02 seconds # thereby 1/1 resource (file) updated (deleted)

# 3.3 Check the file /tmp/motd
> more /tmp/motd
---
more: stat of /tmp/motd failed: No such file or directory   # See, the file doesnt exists anymore
```

## B. Create a webserver using chef-client in local machine
```bash
# 1.1 Create a file named webserver.rb add the below
> vim webserver.rb
---
# Step 01: update the apt cache periodically
apt_update 'Update the apt cahe daily' do       # Resource 01
  # apt_update is an Chef Inspec resource. You can find it with > inspec shell > help resources
  frequency 86_400  # we specify 86,400 seconds to update the cache once every 24 hours. _ is a rybu notion to make it more readable.
  action :periodic  # means that the update occurs periodically
end

# Step 02: Install package 'apache2'
package 'apache2'                               # Resource 02

# Step 03: enable and start
service 'apache2' do
  supports status: true
  action [:enable, :start]                      # Resource 03, 04
end

# Step 04: Add a sample index page
file '/var/www/html/index.html' do              # Resource 05
  content '<html>
  <body>
    <h1>hello world</h1>
  </body>
</html>'
end

# 1.2 converge the changes in local machine using chef-client
# this will install apache2 server in my local machine if not installed earlier
> sudo chef-client --local-mode webserver.rb
---
Converging 4 resources      # <-- Total 05 resources
Recipe: @recipe_files::/home/jarotball/study/Chef-Principle-Analyst-Exam-Prep/2_Learn the Chef Infra Language/lab07_motd/webserver.rb
  * apt_update[Update the apt cache daily] action periodic (up to date)
  * apt_package[apache2] action install
    - install version 2.4.29-1ubuntu4.16 of package apache2
  * service[apache2] action enable (up to date)
  * service[apache2] action restart
    - restart service service[apache2]
  * file[/var/www/html/index.html] action create
    - update content in file /var/www/html/index.html from fffaa2 to 2914aa
    --- /var/www/html/index.html	2021-08-17 12:21:49.815676228 +0600
    +++ /var/www/html/.chef-index20210830-15281-6tj48j.html	2021-08-30 16:35:06.978990772 +0600
    @@ -1,2 +1,6 @@
    -<h1>The Chef Home Page</h1>
    +<html>
    +  <body>
    +    <h1>hello world</h1>
    +  </body>
    +</html>

Running handlers:
Running handlers complete
Chef Infra Client finished, 3/5 resources updated in 08 seconds

# 1.3 Confirm your localhost 
> curl localhost
---
<html>
  <body>
    <h1>hello world</h1>
  </body>
```