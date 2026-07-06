# 🚀 Cloud-Native 12-Microservice E-Commerce Application with End-to-End DevOps CI/CD

A production-style **cloud-native e-commerce application consisting of 12 independent microservices**, deployed on **Amazon EKS** using **Terraform**, **Jenkins**, **Docker**, and **Kubernetes**.

The project demonstrates a complete DevOps workflow starting from infrastructure provisioning to automated CI/CD pipelines, Docker image management, Kubernetes deployments, and application delivery through an AWS LoadBalancer.

Each microservice is independently containerized, built, pushed to Docker Hub, and deployed to Kubernetes using Jenkins Multibranch Pipelines.

---

# 📌 Project Overview

This project automates the complete software delivery lifecycle.

- Infrastructure is provisioned using Terraform.
- Amazon EKS cluster and EC2 instance are created automatically.
- Jenkins is installed on Kubernetes using Helm.
- GitHub Webhooks trigger Jenkins Multibranch Pipelines.
- Docker images are built and pushed to Docker Hub.
- Kubernetes automatically deploys the latest application version to Amazon EKS.

---

---

# 🧩 Microservices Architecture

The application is built using **12 independent microservices**, demonstrating a real-world cloud-native architecture.

Each microservice has its own source code, Docker image, Jenkins pipeline, and Kubernetes deployment.

### Services Included

| Microservice | Responsibility |
|--------------|----------------|
| Frontend | User Interface |
| Ad Service | Displays advertisements |
| Cart Service | Shopping cart management |
| Checkout Service | Order checkout |
| Currency Service | Currency conversion |
| Email Service | Email notifications |
| Payment Service | Payment processing |
| Product Catalog Service | Product information |
| Recommendation Service | Product recommendations |
| Shipping Service | Shipping calculations |
| Redis Cart | Shopping cart cache |
| Load Generator | Simulates user traffic for testing |

### Microservice Workflow

```text
Frontend
    │
    ├── Product Catalog
    ├── Recommendation
    ├── Cart
    ├── Checkout
    ├── Currency
    ├── Payment
    ├── Shipping
    ├── Email
    ├── Ad Service
    └── Redis
```

This architecture demonstrates service-to-service communication, independent deployments, and Kubernetes-based orchestration.

---

# 🏗️ Architecture

```
                GitHub Repository
                       │
                 Push / Pull Request
                       │
                 GitHub Webhook
                       │
                Jenkins Multibranch
                       │
        ┌──────────────┴──────────────┐
        │                             │
   Build Docker Image          Push Image
        │                             │
        └──────────────┬──────────────┘
                       │
                  Docker Hub
                       │
             kubectl apply -f
                       │
               Amazon EKS Cluster
                       │
          Kubernetes Deployment
                       │
             LoadBalancer Service
                       │
                 End User Access
```

---

# ☁️ AWS Services Used

- Amazon EC2
- Amazon EKS
- IAM User
- Elastic Load Balancer (ELB)

---

# 🛠️ DevOps Tools Used

- Terraform
- Docker
- Kubernetes
- Jenkins
- Helm
- kubectl
- AWS CLI
- Git
- GitHub Webhooks

---

# 📂 Repository Structure

```
.
├── Jenkinsfile
├── deployment-service.yml
├── terraform/
├── scripts/
├── frontend/
├── backend/
└── README.md
```

---

# ⚙️ Infrastructure Provisioning

Infrastructure is provisioned entirely using Terraform.

Terraform creates:

- Amazon EC2 Instance
- Amazon EKS Cluster
- Required Networking Components
- Worker Nodes

Initialize Terraform

```bash
terraform init
```

Review execution plan

```bash
terraform plan
```

Provision infrastructure

```bash
terraform apply
```

---

# 🔧 Server Configuration

After the EC2 instance is created, install the required tools.

Installed packages

- Docker
- kubectl
- AWS CLI

Run the installation script

```bash
chmod +x install.sh

./install.sh
```

---

# 🔐 Configure AWS CLI

Configure AWS CLI using an IAM User.

```bash
aws configure
```

Provide

- AWS Access Key
- AWS Secret Key
- Region
- Output Format

---

# ☸️ Connect EC2 to Amazon EKS

Update kubeconfig

```bash
aws eks update-kubeconfig \
--region <region> \
--name <cluster-name>
```

Verify cluster connection

```bash
kubectl get nodes
```

---

# ⛵ Install Jenkins using Helm

Add Helm repository

```bash
helm repo add jenkins https://charts.jenkins.io
```

Update repositories

```bash
helm repo update
```

Install Jenkins

```bash
helm install jenkins jenkins/jenkins
```

Verify installation

```bash
kubectl get pods
```

---

# 🔑 Configure Jenkins

Configure the following credentials inside Jenkins.

- GitHub Credentials
- Docker Hub Credentials
- Kubernetes Token

Install Plugins

- Docker
- Docker Pipeline
- Kubernetes CLI
- GitHub
- Webhook
- Multibranch Pipeline

---

# 🌿 Configure Multibranch Pipeline

Create a Multibranch Pipeline project.

Configure

- GitHub Repository
- Git Credentials
- Branch Source
- Scan by Webhook
- Trigger Token

Configure GitHub Webhook

Whenever code is pushed to GitHub, Jenkins automatically scans all branches and executes the pipeline.

---
<img width="1893" height="984" alt="Screenshot 2026-07-06 171150" src="https://github.com/user-attachments/assets/e779043c-2c4a-4429-9f28-c91ae05421e9" />


### 🔄 Microservice CI/CD

Each microservice branch is configured as an independent Jenkins Multibranch Pipeline.

Whenever changes are pushed to a specific microservice branch:

1. Jenkins automatically detects the branch.
2. Builds the Docker image.
3. Pushes the image to Docker Hub.
4. The **main** branch deploys the updated application to Amazon EKS using Kubernetes manifests.

This architecture enables independent development, testing, and deployment of all **12 microservices**, similar to real-world production environments.

---


# 🐳 CI Pipeline

For every code push

- Clone repository
- Build Docker Image
- Tag Docker Image
- Push Image to Docker Hub

---

# ☸️ Kubernetes Authentication

Create a Kubernetes Service Account.

Generate a token

Store the generated token in Jenkins as

```
Secret Text Credential
```

Generate the Kubernetes pipeline snippet using

```
Pipeline Syntax

↓

withKubeCredentials
```

Provide

- Kubernetes API Endpoint
- Namespace
- Cluster Name
- Secret Text Credential

Generate the Groovy snippet and use it inside the Jenkins Pipeline.

---

# 🚀 Continuous Deployment

Deploy the application

```bash
kubectl apply -f deployment-service.yml
```

Verify

```bash
kubectl get deployments

kubectl get pods

kubectl get svc
```

---

# 🌐 Access Application

Obtain the LoadBalancer URL

```bash
kubectl get svc
```

Copy the External IP / DNS

Open it in the browser

```
http://<LoadBalancer-DNS>
```

The application should now be running successfully.

---

<img width="1899" height="976" alt="Screenshot 2026-07-06 170934" src="https://github.com/user-attachments/assets/99debeb1-f68b-423e-8fc6-446621568150" />

<img width="1924" height="1080" alt="Screenshot (24)" src="https://github.com/user-attachments/assets/8538e64f-5823-4bb2-9fe5-e688ca7bd5b2" />



# 🔄 Complete CI/CD Workflow

```
Developer

      │

Push Code to GitHub

      │

GitHub Webhook

      │

Jenkins Multibranch Pipeline

      │

Clone Repository

      │

Build Docker Image

      │

Push Image to Docker Hub

      │

kubectl apply

      │

Amazon EKS

      │

Kubernetes Deployment

      │

LoadBalancer Service

      │

Application Available
```

---

# 📈 Features

- Cloud-native application with **12 independent microservices**
- Infrastructure Provisioning using Terraform
- Amazon EKS Kubernetes Cluster
- Jenkins Multibranch CI/CD Pipeline
- Docker Image Build & Push to Docker Hub
- GitHub Webhook Automation
- Kubernetes Deployments & Services
- AWS LoadBalancer Integration
- Automated Continuous Deployment
- Independent Microservice Deployments
- Kubernetes Service Account Authentication
- Highly Scalable Cloud Architecture

---

# 📚 Learning Outcomes

This project demonstrates practical experience with

- Infrastructure as Code
- AWS Cloud
- Docker
- Kubernetes
- Jenkins
- Helm
- GitHub Webhooks
- CI/CD Pipelines
- Container Orchestration
- Cloud-Native Application Deployment
- Microservices Architecture
- Kubernetes Service Discovery
- Independent Service Deployment
- Amazon EKS Administration
- Production-style CI/CD for Multiple Microservices

---


---

# 🛠️ Common Issues Faced & Troubleshooting

During the implementation of this project, I encountered several real-world issues. Below are the problems and the solutions used to resolve them.

## 1. Unable to Access Amazon EKS Cluster

### Issue

After creating the EKS cluster using Terraform, the following command failed:

```bash
kubectl get nodes
```

Error:

```text
You must be logged in to the server (Unauthorized)
```

### Root Cause

The IAM User used to configure the AWS CLI did not have sufficient permissions to access the EKS cluster.

### Solution

Attached the **AmazonEKSClusterAdminPolicy** (or the required EKS administrative permissions) to the IAM User and updated the kubeconfig.

```bash
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

After updating the permissions:

```bash
kubectl get nodes
```

worked successfully.

---

## 2. Jenkins Pod Stuck in CrashLoopBackOff After Helm Installation

### Issue

After installing Jenkins using Helm, the Jenkins pod continuously entered the **CrashLoopBackOff** state.

Example:

```bash
kubectl get pods
```

Output:

```text
jenkins-0    CrashLoopBackOff
```

### Root Cause

The Persistent Volume Claim (PVC) required by Jenkins could not be provisioned because no Persistent Volume was available.

The EKS cluster was missing the **AWS EBS CSI Driver**, preventing Kubernetes from dynamically provisioning EBS volumes.

### Solution

- Installed the AWS EBS CSI Driver on the EKS cluster.
- Verified that the StorageClass was configured correctly.
- Confirmed that the Persistent Volume Claim was successfully bound.

Verification:

```bash
kubectl get pvc

kubectl get pv
```

After the PVC was successfully bound, the Jenkins pod started successfully.

---

## 3. Docker Permission Denied in Jenkins Pipeline

### Issue

While building Docker images from Jenkins, the pipeline failed with a Docker permission error.

Example:

```text
permission denied while trying to connect to the Docker daemon socket
```

### Root Cause

The Jenkins user was not a member of the Docker group and therefore did not have permission to access the Docker daemon.

### Solution

Added the Jenkins user to the Docker group.

```bash
sudo usermod -aG docker jenkins
```

Restarted Docker and Jenkins.

```bash
sudo systemctl restart docker

sudo systemctl restart jenkins
```

Verified Docker access.

```bash
sudo -u jenkins docker ps
```

The Jenkins pipeline was then able to build and push Docker images successfully.

---

## 4. Kubernetes Authentication from Jenkins

### Issue

Jenkins was unable to deploy resources to the Kubernetes cluster.

Example:

```text
You must be logged in to the server
```

### Root Cause

Jenkins was not authenticated to the EKS cluster.

### Solution

- Created a Kubernetes Service Account.
- Generated a Service Account Token.
- Stored the token in Jenkins as a **Secret Text Credential**.
- Used the `withKubeCredentials` pipeline step with:
  - Kubernetes API Server Endpoint
  - Namespace
  - Cluster Name
  - Secret Text Credential

This allowed Jenkins to authenticate and successfully execute:

```bash
kubectl apply -f deployment-service.yml
```

---

## 5. GitHub Webhook Not Triggering Jenkins

### Issue

Pushing code to GitHub did not automatically trigger the Jenkins Multibranch Pipeline.

### Root Cause

The GitHub webhook was either missing or incorrectly configured.

### Solution

- Configured a GitHub Webhook pointing to the Jenkins webhook endpoint.
- Installed the GitHub and Multibranch Pipeline plugins.
- Enabled **Scan by Webhook** in the Jenkins Multibranch Pipeline.

After configuration, every push to a branch automatically triggered the corresponding Jenkins pipeline.

---


# 👨‍💻 Author

**Mayank Fulzele**

DevOps | AWS | Kubernetes | Docker | Terraform | Jenkins

---

⭐ If you found this project helpful, consider giving it a Star.
