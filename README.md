# 🚀 Cloud-Native 12-Microservice E-Commerce Application with End-to-End DevOps CI/CD & GitOps

A production-style **cloud-native e-commerce application consisting of 12 independent microservices**, deployed on **Amazon EKS** using **Terraform, Jenkins, Docker, Kubernetes, and Argo CD**.

The project demonstrates a complete DevOps and GitOps workflow starting from infrastructure provisioning to automated CI pipelines, Docker image management, Git-based Kubernetes deployments, and application delivery through AWS LoadBalancer.

Each microservice is independently containerized, built, tested, and pushed to Docker Hub using Jenkins Multibranch Pipelines. **Argo CD continuously monitors the Kubernetes manifests stored in Git and automatically synchronizes the desired state with Amazon EKS.**

---

# 📌 Project Overview

This project automates the complete software delivery lifecycle using a **CI + GitOps CD architecture**.

* Infrastructure is provisioned using Terraform.
* Amazon EKS cluster and EC2 instance are created automatically.
* Jenkins is installed on Kubernetes using Helm.
* GitHub Webhooks trigger Jenkins Multibranch Pipelines.
* Docker images are built and pushed to Docker Hub.
* Kubernetes manifests are maintained in Git.
* Jenkins updates the required container image version in the Kubernetes manifest.
* Argo CD monitors the Git repository for changes.
* Argo CD automatically synchronizes the Kubernetes manifests with Amazon EKS.
* Kubernetes provides service discovery, orchestration, and application scaling.
* AWS LoadBalancer provides external application access.

### CI/CD Architecture

Jenkins is responsible for **Continuous Integration (CI)**:

```text
Code
  │
  ▼
Jenkins
  │
  ├── Build
  ├── Test
  ├── Docker Image Build
  └── Push Image to Docker Hub
```

Argo CD is responsible for **Continuous Delivery (CD)**:

```text
Kubernetes Manifest
        │
        ▼
      GitHub
        │
        ▼
     Argo CD
        │
        ▼
     Amazon EKS
```

This follows a **GitOps deployment model**, where Git acts as the source of truth for the Kubernetes desired state.

---

# 🧩 Microservices Architecture

The application is built using **12 independent microservices**, demonstrating a real-world cloud-native architecture.

Each microservice has its own source code, Docker image, Jenkins pipeline, and Kubernetes deployment.

## Services Included

| Microservice            | Responsibility                     |
| ----------------------- | ---------------------------------- |
| Frontend                | User Interface                     |
| Ad Service              | Displays advertisements            |
| Cart Service            | Shopping cart management           |
| Checkout Service        | Order checkout                     |
| Currency Service        | Currency conversion                |
| Email Service           | Email notifications                |
| Payment Service         | Payment processing                 |
| Product Catalog Service | Product information                |
| Recommendation Service  | Product recommendations            |
| Shipping Service        | Shipping calculations              |
| Redis Cart              | Shopping cart cache                |
| Load Generator          | Simulates user traffic for testing |

## Microservice Workflow

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

```text
                         GitHub Repository
                               │
                         Push / Pull Request
                               │
                               ▼
                    Jenkins Multibranch Pipeline
                               │
                    ┌──────────┴──────────┐
                    │                     │
               Build & Test         Docker Image
                    │                     │
                    └──────────┬──────────┘
                               │
                               ▼
                          Docker Hub
                               │
                               │
                  Update Kubernetes Manifest
                               │
                               ▼
                         GitHub Repository
                               │
                               │ GitOps
                               ▼
                            Argo CD
                               │
                         Auto Sync / Reconcile
                               │
                               ▼
                        Amazon EKS Cluster
                               │
                       Kubernetes Deployment
                               │
                         LoadBalancer Service
                               │
                               ▼
                         End User Access
```

### GitOps Deployment Flow

```text
Developer
    │
    ▼
GitHub Microservice Branch
    │
    ▼
Jenkins CI
    │
    ├── Clone Source Code
    ├── Build Application
    ├── Build Docker Image
    └── Push Image to Docker Hub
             │
             ▼
       Update Image Tag
       in Kubernetes Manifest
             │
             ▼
        Git Push to Main
             │
             ▼
          Argo CD
             │
       Detect Git Change
             │
             ▼
       Automatic Sync
             │
             ▼
         Amazon EKS
             │
             ▼
       Updated Application
```

---

# ☁️ AWS Services Used

* Amazon EC2
* Amazon EKS
* IAM
* Elastic Load Balancer (ELB)

---

# 🛠️ DevOps & GitOps Tools Used

* Terraform
* Docker
* Kubernetes
* Jenkins
* Argo CD
* Helm
* kubectl
* AWS CLI
* Git
* GitHub Webhooks
* Docker Hub

---

# 📂 Repository Structure

```text
.
├── Jenkinsfile
├── deployment-service.yml
├── argocd/
│   └── application.yaml
├── terraform/
├── scripts/
├── frontend/
├── backend/
└── README.md
```

The Kubernetes manifests are stored in Git and act as the **desired state** for the application.

Argo CD monitors the configured Git repository and synchronizes these manifests with the Kubernetes cluster.

---

# ⚙️ Infrastructure Provisioning

Infrastructure is provisioned entirely using Terraform.

Terraform creates:

* Amazon EC2 Instance
* Amazon EKS Cluster
* Required Networking Components
* Worker Nodes

## Initialize Terraform

```bash
terraform init
```

## Review Execution Plan

```bash
terraform plan
```

## Provision Infrastructure

```bash
terraform apply
```

---

# 🔧 Server Configuration

After the EC2 instance is created, install the required tools.

Installed packages:

* Docker
* kubectl
* AWS CLI
* Git

Run the installation script:

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

Provide:

* AWS Access Key
* AWS Secret Key
* Region
* Output Format

---

# ☸️ Connect EC2 to Amazon EKS

Update kubeconfig:

```bash
aws eks update-kubeconfig \
--region <region> \
--name <cluster-name>
```

Verify cluster connection:

```bash
kubectl get nodes
```

---

# ⛵ Install Jenkins using Helm

Add Helm repository:

```bash
helm repo add jenkins https://charts.jenkins.io
```

Update repositories:

```bash
helm repo update
```

Install Jenkins:

```bash
helm install jenkins jenkins/jenkins
```

Verify installation:

```bash
kubectl get pods
```

---

# 🔑 Configure Jenkins

Configure the following credentials inside Jenkins:

* GitHub Credentials
* Docker Hub Credentials

Jenkins does **not** require Kubernetes deployment credentials in the GitOps architecture because Argo CD performs the deployment to EKS.

## Install Plugins

* Docker
* Docker Pipeline
* GitHub
* Webhook
* Multibranch Pipeline

---

# 🌿 Configure Multibranch Pipeline

Create a Multibranch Pipeline project.

Configure:

* GitHub Repository
* Git Credentials
* Branch Source
* Scan by Webhook
* Trigger Token

## Configure GitHub Webhook

Whenever code is pushed to GitHub, Jenkins automatically scans the branches and executes the corresponding CI pipeline.

---

# 🔄 Microservice CI/CD

Each microservice branch is configured as an independent Jenkins Multibranch Pipeline.

Whenever changes are pushed to a specific microservice branch:

1. Jenkins automatically detects the branch.
2. Jenkins clones the source code.
3. Jenkins builds the application.
4. Jenkins builds the Docker image.
5. Jenkins pushes the image to Docker Hub.
6. The Kubernetes image reference is updated in the Git repository.
7. Argo CD detects the Git change.
8. Argo CD synchronizes the updated Kubernetes manifest with Amazon EKS.

This architecture enables independent development and deployment of all **12 microservices** while maintaining Git as the source of truth.

---

# 🐳 CI Pipeline

For every code push:

```text
Clone Repository
       │
       ▼
Build Application
       │
       ▼
Run Tests
       │
       ▼
Build Docker Image
       │
       ▼
Tag Docker Image
       │
       ▼
Push Image to Docker Hub
```

Jenkins is responsible only for the **Continuous Integration** portion of the pipeline.

---

# 📦 Container Image Management

Docker images are built independently for each microservice.

Example:

```text
mayankfulzele/frontend:<tag>
mayankfulzele/cartservice:<tag>
mayankfulzele/paymentservice:<tag>
```

The image tag is updated in the Kubernetes deployment manifest after a successful CI build.

Example:

```yaml
containers:
  - name: frontend
    image: mayankfulzele/frontend:<new-tag>
```

The updated manifest is committed and pushed to Git.

---

# 🚀 Continuous Deployment with Argo CD

Argo CD is used as the **Continuous Delivery and GitOps tool** for this project.

Instead of Jenkins directly executing:

```bash
kubectl apply -f deployment-service.yml
```

the deployment process is:

```text
Jenkins
   │
   ├── Build Image
   ├── Push Image
   └── Update Kubernetes Manifest
            │
            ▼
          GitHub
            │
            ▼
         Argo CD
            │
            ▼
      Amazon EKS Cluster
```

Jenkins no longer directly deploys workloads to Kubernetes.

Argo CD continuously monitors the Git repository and compares the desired Kubernetes state stored in Git with the actual state running in EKS.

---

# 🔄 Install Argo CD

Create the Argo CD namespace:

```bash
kubectl create namespace argocd
```

Install Argo CD:

```bash
kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify the installation:

```bash
kubectl get pods -n argocd
```

All Argo CD components should become ready.

---

# 🌐 Access Argo CD

For a simple setup, expose the Argo CD server using a LoadBalancer:

```bash
kubectl patch svc argocd-server \
-n argocd \
-p '{"spec":{"type":"LoadBalancer"}}'
```

Check the service:

```bash
kubectl get svc -n argocd
```

Obtain the Argo CD LoadBalancer endpoint from the `EXTERNAL-IP` or AWS LoadBalancer DNS.

---

# 🔑 Argo CD Login

The default username is:

```text
admin
```

Retrieve the initial password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
```

Use these credentials to access the Argo CD UI.

---

# 📋 Create Argo CD Application

Create:

```text
argocd/application.yaml
```

Example:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application

metadata:
  name: ecommerce
  namespace: argocd

spec:

  project: default

  source:
    repoURL: https://github.com/mayankfulzele05/E-Commerce-microservices-application.git
    targetRevision: main
    path: .

  destination:
    server: https://kubernetes.default.svc
    namespace: default

  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Apply the Argo CD Application:

```bash
kubectl apply -f argocd/application.yaml
```

> Update the `path` and `namespace` according to the final location of your Kubernetes manifests.

---

# 🔄 Argo CD Auto-Sync

The application uses automated synchronization:

```yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true
```

### Automated Sync

When a Kubernetes manifest changes in Git:

```text
Git Change
    │
    ▼
Argo CD Detects Change
    │
    ▼
Application becomes OutOfSync
    │
    ▼
Automatic Sync
    │
    ▼
Amazon EKS Updated
```

### Self-Healing

If the Kubernetes state is manually changed:

```bash
kubectl scale deployment <deployment-name> --replicas=1
```

while Git specifies:

```yaml
replicas: 3
```

Argo CD detects the drift and restores the desired state from Git.

This provides **self-healing Kubernetes deployments**.

---

# 🔁 GitOps Deployment Workflow

The final deployment workflow is:

```text
1. Developer pushes code
          │
          ▼
2. GitHub
          │
          ▼
3. Jenkins Multibranch Pipeline
          │
          ├── Build
          ├── Test
          ├── Docker Build
          └── Docker Push
                    │
                    ▼
4. Update Kubernetes image tag
                    │
                    ▼
5. Commit manifest to Git
                    │
                    ▼
6. Argo CD detects Git change
                    │
                    ▼
7. Argo CD synchronizes application
                    │
                    ▼
8. Amazon EKS
                    │
                    ▼
9. Kubernetes Deployment
                    │
                    ▼
10. LoadBalancer
                    │
                    ▼
11. Application Available
```

---

# 🌐 Access Application

Obtain the LoadBalancer URL:

```bash
kubectl get svc
```

Copy the External IP / DNS.

Open it in the browser:

```text
http://<LoadBalancer-DNS>
```

The application should now be running successfully.

---

# 🔄 Complete CI/CD + GitOps Workflow

```text
                         Developer
                             │
                             ▼
                    Push Code to GitHub
                             │
                             ▼
                  GitHub Webhook Trigger
                             │
                             ▼
                 Jenkins Multibranch CI
                             │
              ┌──────────────┴──────────────┐
              │                             │
         Build & Test                 Docker Build
                                            │
                                            ▼
                                    Push to Docker Hub
                                            │
                                            ▼
                              Update Kubernetes Manifest
                                            │
                                            ▼
                                   Commit & Push to Git
                                            │
                                            ▼
                                         Argo CD
                                            │
                                    Detect Git Change
                                            │
                                            ▼
                                      Auto Sync
                                            │
                                            ▼
                                      Amazon EKS
                                            │
                                            ▼
                                Kubernetes Deployment
                                            │
                                            ▼
                                    LoadBalancer
                                            │
                                            ▼
                                  Application Available
```

---

# 🛡️ GitOps Benefits

Using Argo CD provides:

* Git as the single source of truth
* Automated Kubernetes deployments
* Continuous reconciliation
* Drift detection
* Self-healing
* Automated synchronization
* Better separation between CI and CD
* Reduced Kubernetes credentials in Jenkins
* Deployment history through Git
* Easy rollback by reverting Git commits
* Kubernetes-native continuous delivery

---

# 📈 Features

* Cloud-native application with **12 independent microservices**
* Infrastructure Provisioning using Terraform
* Amazon EKS Kubernetes Cluster
* Jenkins Multibranch CI
* Docker Image Build & Push to Docker Hub
* GitHub Webhook Automation
* Kubernetes Deployments & Services
* AWS LoadBalancer Integration
* **Argo CD GitOps-based Continuous Delivery**
* **Automated Argo CD Synchronization**
* **Argo CD Self-Healing**
* Git-based Kubernetes Desired State
* Independent Microservice CI Pipelines
* Kubernetes Service Account Authentication
* Highly Scalable Cloud Architecture

---

# 📚 Learning Outcomes

This project demonstrates practical experience with:

* Infrastructure as Code
* AWS Cloud
* Docker
* Kubernetes
* Jenkins
* Helm
* GitHub Webhooks
* CI/CD Pipelines
* **GitOps**
* **Argo CD**
* Continuous Delivery
* Container Orchestration
* Cloud-Native Application Deployment
* Microservices Architecture
* Kubernetes Service Discovery
* Independent Service Deployment
* Amazon EKS Administration
* Production-style CI/CD for Multiple Microservices
* Kubernetes Desired State Management
* Automated Synchronization and Self-Healing

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

```text
jenkins-0    CrashLoopBackOff
```

### Root Cause

The Persistent Volume Claim (PVC) required by Jenkins could not be provisioned because no Persistent Volume was available.

The EKS cluster was missing the **AWS EBS CSI Driver**, preventing Kubernetes from dynamically provisioning EBS volumes.

### Solution

* Installed the AWS EBS CSI Driver on the EKS cluster.
* Verified that the StorageClass was configured correctly.
* Confirmed that the Persistent Volume Claim was successfully bound.

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

## 4. Jenkins Kubernetes Authentication

### Previous Architecture

Initially Jenkins directly deployed Kubernetes resources using:

```bash
kubectl apply -f deployment-service.yml
```

This required Kubernetes credentials inside Jenkins.

### GitOps Architecture

After integrating Argo CD, Jenkins is responsible for CI and does not directly deploy to Kubernetes.

The new flow is:

```text
Jenkins
   │
   ├── Build Image
   ├── Push Image
   └── Update Git Manifest
             │
             ▼
           GitHub
             │
             ▼
          Argo CD
             │
             ▼
          Amazon EKS
```

This reduces the need for direct Kubernetes deployment credentials in Jenkins and establishes Git as the source of truth.

---

## 5. GitHub Webhook Not Triggering Jenkins

### Issue

Pushing code to GitHub did not automatically trigger the Jenkins Multibranch Pipeline.

### Root Cause

The GitHub webhook was either missing or incorrectly configured.

### Solution

* Configured a GitHub Webhook pointing to the Jenkins webhook endpoint.
* Installed the GitHub and Multibranch Pipeline plugins.
* Enabled **Scan by Webhook** in the Jenkins Multibranch Pipeline.

After configuration, every push to a branch automatically triggered the corresponding Jenkins pipeline.

---

## 6. Argo CD Application OutOfSync

### Issue

Argo CD showed the application as:

```text
OutOfSync
```

### Troubleshooting

Check the application:

```bash
kubectl get applications -n argocd
```

Check Argo CD resources:

```bash
kubectl get pods -n argocd
```

Verify the Git repository URL and branch configured in the Argo CD Application.

Check the application details from the Argo CD UI to identify the resource causing the synchronization difference.

### Expected State

Once the Git repository and Kubernetes manifests are correctly configured:

```text
Git Desired State
        │
        ▼
     Argo CD
        │
        ▼
   EKS Actual State

      Synced
       +
     Healthy
```

---

# 👨‍💻 Author

**Mayank Fulzele**

DevOps | AWS | Kubernetes | Docker | Terraform | Jenkins | Argo CD

---

⭐ If you found this project helpful, consider giving it a Star.
