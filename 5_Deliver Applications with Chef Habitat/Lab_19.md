# Lab 19: 

## Learning from Lab 18:
- We created a Habita Plan that defines how your software should be built. 
- Then we ran those plans locally on our system through Habitat Studio
- And finally exported the built package to the Docker image format 
- and launch those docker image at port 8000
- The app had an implicit depencency which scaffolding cant resolve by itself unless defined manually.. Thats why we defined that pkg dependency in Habitat/plan.sh file (core/imagemagick).
- But the application was generating error when trying to load the JPEG image format. That's because the **core/imagemagick** package is not compiled with JPEG support.

## Incomplete.
