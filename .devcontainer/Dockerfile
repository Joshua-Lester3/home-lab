FROM mcr.microsoft.com/devcontainers/base:debian-12

ARG TERRAFORM_VERSION="1.14.3"
ARG TALOSCTL_VERSION="v1.11.6"
ARG KUBECTL_VERSION="v1.32.0"
# ARG ARGOCD_VERSION="v2.13.3"
ARG TASK_VERSION="v3.45.5"

# Install system dependencies
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    curl unzip git software-properties-common gnupg \ 
    # recommended: python3-pip python3-venv \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install -y terraform

# Install Ansible
# We use pipx to isolate ansible dependencies
# RUN pip3 install --break-system-packages ansible

# Install Talosctl
RUN curl -Lo /usr/local/bin/talosctl https://github.com/siderolabs/talos/releases/download/${TALOSCTL_VERSION}/talosctl-linux-amd64 \
    && chmod +x /usr/local/bin/talosctl

# Install Kubectl
RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install ArgoCD CLI
# RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64 \
#     && chmod +x /usr/local/bin/argocd

# Install Task
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin ${TASK_VERSION}

# (Optional) Install SOPS/Age for Secret Management
# RUN curl -LO https://github.com/getsops/sops/releases/download/v3.9.0/sops-v3.9.0.linux.amd64 \
#     && mv sops-v3.9.0.linux.amd64 /usr/local/bin/sops && chmod +x /usr/local/bin/sops

USER vscode