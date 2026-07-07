# Configuration Management with Ansible

Using Ansible to configure a Linux server with four roles — base setup, NGINX, SSH key management, and app deployment — targeting the AWS EC2 instance provisioned in Project 15 (IaC with Terraform).

## Project URL
https://roadmap.sh/projects/configuration-management

## Stack
- Ansible-core v2.16.3
- Target: AWS EC2 (Ubuntu 24.04), provisioned via Terraform (Project 15)

## Roles

| Role | Purpose |
|------|---------|
| `base` | Updates apt cache, upgrades all packages, installs core utilities (curl, vim, git, htop, ufw, unzip), installs and enables `fail2ban` |
| `nginx` | Installs NGINX, ensures it's enabled/running, allows "Nginx Full" through UFW |
| `ssh` | Adds a dedicated demo public key to `~/.ssh/authorized_keys` via the `authorized_key` module |
| `app` | Deploys a static site from a local tarball (`app.tar.gz`) — showcase of the original beginner-friendly deployment method |
| `github-app` | Deploys the live portfolio site by cloning it directly from GitHub (`gh-deployment-workflow`) — stretch goal implementation |

## Stretch Goal

The original project asks for the `app` role to pull from a GitHub repo instead of a local tarball. Rather than replacing the tarball method outright, both are kept side-by-side as separate roles (`app` and `github-app`), toggled at runtime with a variable — so either deployment method can be demonstrated without editing any files.

```bash
# Deploy the tarball-based demo site
ansible-playbook setup.yml -i inventory.ini -e "deploy_method=tarball"

# Deploy the real portfolio, cloned live from GitHub
ansible-playbook setup.yml -i inventory.ini -e "deploy_method=git"
```

This is handled in `setup.yml` using a `when` conditional per role:

```yaml
- role: app
  tags: app
  when: deploy_method == "tarball"
- role: github-app
  tags: github-app
  when: deploy_method == "git"
```

## Usage

### Prerequisites
- Ansible installed (`sudo apt install ansible-core`)
- A running target server (this project targets the Terraform-provisioned instance from Project 15)
- SSH key pair with access to the target server

### Inventory
Update `inventory.ini` with your target server's IP:

```ini
[devops_server]
<server_ip> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/devops-key.pem
```

### Commands

```bash
# Test connectivity
ansible devops_server -i inventory.ini -m ping

# Run all roles (defaults to tarball deployment if -e not passed)
ansible-playbook setup.yml -i inventory.ini -e "deploy_method=tarball"

# Run only a specific role
ansible-playbook setup.yml -i inventory.ini --tags "nginx"
ansible-playbook setup.yml -i inventory.ini --tags "base"
ansible-playbook setup.yml -i inventory.ini --tags "ssh"
```

## Notes

- Both `app` and `github-app` roles wipe `/var/www/html` before deploying, so switching between deployment methods never leaves stale files behind.
- Since this instance is provisioned fresh via Terraform, `known_hosts` entries for old instances may need clearing before Ansible/SSH can connect to a newly recreated one: `ssh-keygen -R <old_ip>`
- Site is served over plain HTTP — no TLS, since there's no domain attached to this temporary practice instance. A `certbot` role could be added later against a real subdomain for HTTPS.

## Playbook Run Output (all roles, tarball deploy)

```
PLAY RECAP
18.225.87.89  : ok=13   changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
