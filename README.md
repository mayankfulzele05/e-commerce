# 🛒 Cloud-Native E-Commerce Application

A high-performance, containerized E-Commerce application architected for seamless scalability. This repository contains the complete application source code alongside professional DevOps orchestration setups including **Jenkins CI/CD automation pipelines** and **Kubernetes cluster deployments**.

---

## 🚀 Key Features
* **CI/CD Automation**: Integrated `Jenkinsfile` for automated building, testing, and staging pipelines.
* **Orchestration Ready**: Pre-configured Kubernetes manifests for automated scaling and management.
* **Declarative Service Networking**: Built-in routing configurations using stable Kubernetes internal networking.

## 🛠️ Tech Stack & DevOps Tools
* **Orchestration & Deployment**: [Kubernetes](https://kubernetes.io)
* **CI/CD Automation**: [Jenkins](https://jenkins.io)
* **Containerization**: [Docker](https://docker.com)
* **Cloud Infrastructure**: YAML Manifests 

---

## 📂 Repository Architecture
* `Jenkinsfile` - Contains declarative pipelines for multi-stage continuous integration and delivery.
* `deployment-service.yml` - Unified Kubernetes declaration containing service definitions and replica configuration logic.

---

## ⚙️ Local Deployment & Setup

### Prerequisites
Ensure you have the following CLI utilities installed locally:
* [Docker Desktop](https://docker.comproducts/docker-desktop/) (with built-in Kubernetes enabled)
* [Minikube](https://k8s.io) or a running cloud-managed Kubernetes cluster
* [kubectl](https://kubernetes.iodocs/tasks/tools/) command-line tool

### 1. Launch Your Local Cluster
If using Minikube, execute:
```bash
minikube start
```

### 2. Apply Orchestration Configurations
Deploy the application and its respective container pods using your local configurations:
```bash
kubectl apply -f deployment-service.yml
```

### 3. Verify Deployment Status
Ensure your pods, deployments, and services are communicating flawlessly:
```bash
kubectl get all
```

---

## 🗺️ CI/CD Pipeline Workflow
The automated Jenkins pipeline triggers on every pull request and push to the `main` branch, performing the following sequential operations:
1. **Static Analysis & Linting**: Validates configuration integrity.
2. **Docker Compilation**: Builds the microservice application into reproducible image layers.
3. **Registry Push**: Tags and publishes your production-ready artifact to an image registry.
4. **Continuous Deployment**: Applies updated configuration sets directly to your active cluster.
