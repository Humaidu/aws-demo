# Angular App Deployment to Nginx using Docker and Jenkins CI/CD Pipeline

This project demonstrates deploying an Angular application to an Nginx web server using Docker, with a CI/CD pipeline facilitated by Jenkins. Jenkins automates building, testing, and deploying the app, and pushes the Docker image to Docker Hub. Both Jenkins and Docker are installed on the same EC2 instance.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
  - [1. Setting Up the EC2 Instance](#1-setting-up-the-ec2-instance)
  - [2. Installing Jenkins and Docker](#2-installing-jenkins-and-docker)
  - [3. Configuring Jenkins](#3-configuring-jenkins)
- [Jenkins CI/CD Pipeline](#jenkins-cicd-pipeline)
- [Docker Configuration](#docker-configuration)
  - [Dockerfile](#dockerfile)
  - [Nginx Configuration](#nginx-configuration)
- [Jenkinsfile](#jenkinsfile)
- [Deployment Steps](#deployment-steps)
- [Accessing the Application](#accessing-the-application)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)
- [Contributing](#contributing)
- [Improvements to work on](#improvements-to-work-on)

## Prerequisites
Before starting, ensure you have the following:
- An AWS EC2 instance (Ubuntu 20.04 or later recommended)
- Basic knowledge of Angular, Docker, and Jenkins
- An Angular project to deploy
- A Docker Hub account

## Project Structure
The basic folder structure for this project should look like this:

angular-app/ ├── Dockerfile ├── Jenkinsfile ├── src/ ├── app/ └── index.html


## Setup Instructions

### 1. Setting Up the EC2 Instance
1. Launch an EC2 instance using an Amazon Machine Image (AMI) with at least 4 GB RAM (e.g., `t2.large`).
2. Configure security groups to allow HTTP (port 80), HTTPS (port 443), and Jenkins (port 8080).
3. Connect to the instance via SSH.

### 2. Installing Jenkins and Docker
1. **Install Docker:**
   ```bash
   sudo apt update
   sudo apt install -y docker.io
   sudo systemctl start docker
   sudo systemctl enable docker
   sudo usermod -aG docker $USER

2. **Install Jenkins:**
   ```bash
   curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt update
    sudo apt install -y jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins

3. **Install Docker Plugin for Jenkins:**
   1. Navigate to http://<EC2-IP>:8080 and unlock Jenkins using the initial admin password (/var/lib/jenkins/secrets/initialAdminPassword).
   2. Install the Docker and GitHub plugins from Jenkins' plugin manager.

### 3. Configuring Jenkins
1. Add Docker Hub Credentials:
   - Go to Manage Jenkins > Credentials > System > Global credentials.
   - Add your Docker Hub username and password.
2. Create a New Jenkins Pipeline Job:
   - Go to New Item, create a pipeline, and configure it to use your GitHub repository.
3. Install Git and Node.js:
   - On the EC2 instance, install Git: sudo apt install -y git.
   - Install Node.js and npm if needed: sudo apt install -y nodejs npm.

## Jenkins CI/CD Pipeline
**The Jenkins pipeline automates the following steps:**

- Clones the Angular App from the GitHub repository.
- Builds the Angular App using Docker.
- Pushes the Docker Image to Docker Hub.
- Deploy the Image to Nginx on the EC2 instance.

## Docker Configuration
The `Dockerfile` describes building the Docker image for the Angular application. It consists of two stages: 
1. Building the Angular app with Node.js.
2. Serving the app using Nginx.

You can view the full [Dockerfile here](Dockerfile).

## Jenkinsfile
The `Jenkinsfile` defines the pipeline for automating the build, test, and deployment processes. It includes stages for building the Angular app using Docker, pushing the Docker image to Docker Hub, and deploying it to an Nginx web server.

You can view the full [Jenkinsfile here](Jenkinsfile).

## Deployment Steps
- Push code changes to GitHub to trigger the Jenkins pipeline.
- Jenkins executes the pipeline, which builds the Docker image, pushes it to Docker Hub, and deploys it to the Nginx server on the EC2 instance.
  
## Accessing the Application
- For the EC2 deployment: Navigate to http://<EC2-Public-IP>.
- For the EKS deployment: Access the application using the Load Balancer address created by the Ingress controller (Next steps).

## Troubleshooting
- **Port 80 Already in Use:** Stop any running containers using port 80, or change the port mapping.
- **Out of Space Errors:** Run docker system prune to clear unused Docker objects.
- **Jenkins Fails to Start:** Check Jenkins logs (/var/log/jenkins/jenkins.log) for error details.

## Best Practices
- **Isolate Jenkins and Nginx:** For better performance, run Jenkins and Nginx on separate EC2 instances.
- **Automate Docker Cleanup:** Use docker system prune -f to clear unused Docker resources.

## Contributing
Contributions are welcome! Please submit a pull request for any improvements or fixes.

## Improvements to work on
**EKS Deployment:** Jenkins pipeline will build the Docker image, push it to Docker Hub, create an EKS cluster if not already existing, and deploy the app. I will use Ansible to create the EKS cluster.

