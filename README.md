🚀 Flask App CI/CD on Azure using Terraform, Docker & GitHub Actions

This project demonstrates a **production-style DevOps pipeline** for a Flask application, including:

- 🐳 Containerized with **Docker**
- 📦 Pushed to **Azure Container Registry (ACR)** via **GitHub Actions**
- 🌐 Deployed to **Azure Linux Web App**
- 🛠️ Infrastructure provisioned using **Terraform**

---

🧰 Tech Stack

- **Terraform (IaC)**
- **Docker**
- **GitHub Actions** (CI/CD)
- **Azure Container Registry (ACR)**
- **Azure App Service** (Linux)
- **Python + Flask**

---

## 🔁 Workflow Overview

1. `terraform apply` provisions the ACR and App Service.
2. GitHub Actions:
   - Builds the Docker image
   - Pushes it to ACR on every commit to `main`
3. Azure App Service automatically pulls and deploys the latest container.

---

## 📂 Folder Structure

├── docker/
│ ├── app.py
│ ├── Dockerfile
│ └── requirements.txt
├── terraform/
│ ├── main.tf
│ ├── provider.tf
│ ├── variables.tf
│ └── outputs.tf
├── .github/
│ └── workflows/
│ └── docker-deploy.yml
├── .gitignore
├── README.md



(added by KB – testing GitHub Actions trigger)

## 🚀 Result

Live deployed Flask app: **Hello from Flask on Azure!**  
Delivered using a production-style CI/CD DevOps pipeline. 