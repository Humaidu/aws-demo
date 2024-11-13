# Deploying an Angular App to Docker Hub and EKS using a Jenkins CI/CD Pipeline

This documentation outlines the steps to deploy an Angular application using a comprehensive CI/CD pipeline. The deployment leverages Jenkins, Docker, Docker Hub, Ansible, Terraform, and Kubernetes on AWS EKS. The entire CI/CD stack (Jenkins, Docker, Terraform, and Ansible) runs on a single AWS EC2 instance.

## Prerequisites

1. AWS account with IAM permissions for managing EKS.
2. AWS CLI, kubectl, and Helm.
3. EC2 instance with:
   - Jenkins installed
   - Docker installed and configured
   - Ansible installed
   - Terraform installed
4. Jenkins with the following Plugins installed:
   - Docker pipeline
   - Cloudbess docker pull and publish
   - Aws steps pipeline
   - Aws sdk plugin
   - Ansible and terraform plugin
   - Kubernetes plugin
5. Setup docker hub credentials on jenkins dashboard.

## Project Overview

- **Step 1**: Create Docker image of the Angular app using Nginx.
- **Step 2**: Build and Push Docker image of the Angular to docker hub and run the docker image container. 
- **Step 3**: Install AWS CLI, kubectl and Helm for EKS using Ansible.
- **Step 4**: Create EKS cluster using Terraform.
- **Step 5**: Install Nginx Ingress Controller using Ansible.
- **Step 6**: Run Ansible Playbook to Deploy Angular Image to EKS.

**Jenkins pipeline** - [Jenkinsfile](https://github.com/Humaidu/aws-demo/blob/main/Jenkinsfile)


## Conclusion
This setup automates the deployment of your Angular app to an EKS cluster using Jenkins, Docker, Ansible, and Terraform.

