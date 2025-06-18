# 🚀 Azure Linux VM Deployment with Terraform

This project uses **Terraform** to provision a basic **Linux virtual machine** in **Microsoft Azure**, complete with networking, SSH access, and a Network Security Group.

---

## 📁 Project Structure

```bash
.
├── main.tf            # All main Terraform configuration
├── variables.tf       # Input variables like location & resource group
├── outputs.tf         # Output values like VM private IP
├── .gitignore         # Prevents sensitive/local files from being pushed
└── README.md          # You're here!
