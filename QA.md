# Multiple Choice Question:: Chef Principle Analyst:: Practice

### Q1. What is IT Automation?
- [ ] A process to replace human operators.
- [ ] A method to configure workstations automatically.
- [X] A system that will take care of repetitive tasks without human intervention.

### Q2. What is Chef Infra used for?
- [ ] To ensure your infrastructure is secure. 
- [x] To configure your server infrastructure. 
- [ ] To package applications.

### Q3. What does Chef Habitat do?
- [ ] Configures your infrastructure at scale.
- [ ] Scans your infrastructure for security issues.
- [x] Packages and delivers applications to almost any environment.

### Q4. What does Chef Compliance do?
- [ ] It initially configures your infrastructure.
- [ ] It installs security patches on your workstation.
- [x] It helps you prevent security incidents in your infrastructure.

### Q5. What is the Chef Enterprise Automation Stack (EAS)?
- [ ] The combination of Chef Habitat and Chef Infra.
- [x] The suite of enterprise infrastructure, application and DevSecOps automation.
- [ ] The combination of Chef Automate and Chef infra.

### Q6. What is a Chef cookbook?
- [ ] It's a hub for communicating with infrastruture nodes.
- [ ] It's a YML file that is used to bootstrap infrastructure nodes.
- [x] It's like a set of configuration files, called recipes, that configures your infrastructure.

### Q7. Which of the following best describes Chef resources?
- [ ] the file in which Chef code is stored.
- [x] the ingredients used to determine how Chef configures an instance.
- [ ] the documents, manual pages, and contact info for Chef engineers.

### Q8. True or false: Chef recipes support both YAML and Ruby formats.
- [x] True.
- [ ] False.

### Q9. Chef resources are stored in files called:
- [ ] cookbooks.
- [x] recipes.
- [ ] ingredients.
- [ ] README.

### Q10. What Chef Infra command would you use to lock your policies in place by creating a Policyfile.lock.json file?
- [ ] chef push Policyfile.rb
- [x] chef install Policyfile.rb
- [ ] chef init Policyfile.rb

### Q11. Where do you define the source of dependent cookbooks?
- [x] Policyfile.rb
- [ ] metadata.rb
- [ ] Policyfile.lock.json

### Q12. What is a benefit of using knife profiles?
- [ ] knife profiles use less CPU resources than other methods.
- [ ] You don't need any additional files.
- [x] You can quickly switch from one Chef Infra Server to another.

### Q13. Which items comprise the heart of knife profiles?
- [ ] a config.rb and knife.rb
- [x] a credentials file and the "knife config" command.
- [ ] a credentials file and the "chef config set" command.

### Q14. Which command allows you to see all your knife profiles?
- [x] knife config list-profiles
- [ ] knife list-profiles
- [ ] chef config list-profiles

### Q15. Which command should you use to set a specific knife profile as default?
- [ ] knife set-profile knifeProfileName
- [ ] chef config use-profile knifeProfileName
- [x] knife config use-profile knifeProfileName

### Q16. What important organizational feature does the Plan rely on to determine the system's runlist?
- [ ] Recipes.
- [ ] Resources.
- [x] Policyfiles.

### Q17. Which file declares how often this package should run on a system?
- [ ] metadata.rb
- [x] habitat/default.toml
- [ ] policyfile.rb

### Q18. What is a Resource?
- [ ] Read-only data identified by a type and a name.
- [x] A description of some piece of a system and its desired state.
- [ ] An ordered series of configuration states.

### Q19. What is a Recipe?
- [x] A file that groups related resources.
- [ ] A file that configures the chef-client run.
- [ ] A File that configures your workstation.

### Q20. What happens when you don't specify a resource's action?
- [ ] You get an error message but the chef-client run continues.
- [ ] You get an error message and the chef-client run halts.
- [x] The default action is assumed.

### Q21. What does the code package 'httpd' do?
- [x] It identifies a package resource.
- [ ] It tags the system as a web server.
- [ ] It is incomplete and will cause an error message.

### Q22. What determines when Chef applies resources?
- [ ] The order of their precedence.
- [ ] The order of their attributes.
- [x] The order they're listed in a recipe.

### Q23. When must you list a resource's attributes?
- [ ] Immediately after the resource name.
- [ ] Immediately after the actions.
- [x] You can list them anywhere within the resource block.

### Q24.True or False: InSpec uses resources to verify cloud infrastructure
- [x] True
- [ ] False

### Q25. What resources can you use to verify the presence of a subnet defined in a VPC?
- [ ] aws_ec2_instance
- [ ] aws_subnet
- [ ] awc_vpc
- [x] All of the above.

### Q26. What method can you use to make your profiles more dynamic values for testing your instances?
- [ ] aws_ec2_instance with a name field.
- [ ] Profile attributes.
- [ ] Profile files.
- [x] All of the above.

### Q27. A Habitat package is:
These are what we created by running build within the Habitat Studio.
- [ ] a Docker image
- [x] a .hart file
- [ ] A .tar file
- [ ] A Plan.sh file

### Q28. The `hab studio enter` command:
- [ ] opens a text editor
- [ ] builds the Habitat package and then exits
- [x] Creates a "clean room" environment for building and testing packages
- [ ] explodes the Studio package for viewing

### Q29. In the Studio environment (the "clean room") the curl command was originally unavailable. We installed this package using the `hab pkg install -b` command. Where was the package obtained from?
You'll recall the -b option was to bin-link the installed package, making it available directly from the command-line.
- [ ] the $HAB_ORIGIN you exported during setup
- [ ] the habitat/ origin
- [x] the core/ origin
- [ ] We built this package from scratch by running build

### Q30. What is the purpose of Scaffolding?
*** Scaffolding can only deals with Explicit dependencies, not the implicit dependencies.
- [ ] It automatically builds and deploys your application.
- [x] To generate a Plan file for building common application types.
- [ ] To support exporting built packages to Docker images.
- [ ] It automatically bundles all the implicit dependencies for Ruby applications.

### Q31. How can a package dependency be specified in a Plan file?
You'll remember defining the ImageMagick dependendency using this setting.

- [x] pkg_deps
- [ ] pkg_build_deps
- [ ] pkg_runtime_deps
- [ ] Scaffolding always grabs every dependency you need

### Q32. As a clean room environment, the Habitat Studio:
Select all answers that apply
- [x] Doesn't load any tools or libraries from outside the environment.
- [ ] Loads any shortcuts defined in your Bash or Powershell profile.
- [x] Ensures that the Habitat Supervisor can run your package in any environment.
- [x] Ensures that nothing external is pulled into your package.

