# 🚀 Cloud-Native E-Commerce Application with End-to-End DevOps CI/CD

A production-style cloud-native microservices application deployed on **Amazon EKS** using **Terraform**, **Jenkins**, **Docker**, and **Kubernetes**. This project demonstrates a complete DevOps workflow starting from infrastructure provisioning to automated application deployment through a CI/CD pipeline.

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

- Infrastructure as Code using Terraform
- Cloud-native deployment on Amazon EKS
- Jenkins CI/CD Automation
- Docker Image Build & Push
- GitHub Webhook Integration
- Multibranch Jenkins Pipeline
- Kubernetes Deployments
- Kubernetes Services
- Automated Continuous Deployment
- Highly Scalable Architecture

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

---

# 🚀 Future Improvements

- ArgoCD GitOps Deployment
- Prometheus Monitoring
- Grafana Dashboards
- Ingress Controller
- Blue-Green Deployment
- Canary Deployment
- Horizontal Pod Autoscaler
- SonarQube Code Analysis
- Trivy Image Scanning
- AWS ECR Integration

---

# 👨‍💻 Author

**Mayank Fulzele**

DevOps | AWS | Kubernetes | Docker | Terraform | Jenkins

---

⭐ If you found this project helpful, consider giving it a Star.
