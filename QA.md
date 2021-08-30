# Multiple Choice on Course_01_Beginning Your Chef Journey Home Page

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