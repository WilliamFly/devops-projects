# DevOps Projects

My hands-on practice repo working through roadmap.sh's DevOps Projects list — building real infrastructure skills, refreshing Docker/AWS/NGINX knowledge, and learning Terraform/Ansible from scratch.

## Projects

- [01 - Server Stats](./01-server-stats) — Bash script to analyze CPU, memory, disk, and top processes
- [02 - Log Archive Tool](./02-log-archive-tool) — CLI tool to compress and archive logs with timestamps
- [03 - Nginx Log Analyser](./03-nginx-log-analyser) — Parses nginx access logs for top IPs, paths, status codes, and user agents
- [04 - GitHub Pages Deployment](https://github.com/WilliamFly/gh-deployment-workflow) — Standalone repo. GitHub Actions workflow that deploys index.html on push
- [05 - Basic Dockerfile](./05-basic-dockerfile) — Minimal Alpine-based Docker image that prints a greeting, with runtime name argument support
- [06 - Dummy Systemd Service](./06-dummy-systemd-service) — Long-running systemd service that logs every 10 seconds
- [07 - Static Site Server](./07-static-site-server) — NGINX static site on AWS EC2, deployed via rsync
- [08 - SSH Remote Server Setup](./08-ssh-remote-server-setup) — Two SSH key pairs, authorized_keys config, and SSH alias setup on AWS EC2
- [09 - EC2 Instance](./09-ec2-instance) — AWS EC2 instance launch, security group config, and static site deployment via NGINX
- [10 - Simple Monitoring](./10-simple-monitoring) — Netdata monitoring dashboard on AWS EC2 with automated setup, load testing, and cleanup scripts
- [11 - Basic DNS Setup](./11-basic-dns-setup) — Custom domain setup for GitHub Pages using Hostinger DNS, live at williammucha.com
- [12 - Pomodoro Timer](./12-pomodoro-timer) — Vanilla JS Pomodoro Timer with configurable intervals, session tracking, and Web Audio bell
- [13 - File Integrity Checker](./13-file-integrity-checker) — SHA-256 based log file integrity checker with init, check, and update commands
- [14 - Linux Server Setup](./14-linux-server-setup) — Fresh Ubuntu 24.04 EC2 server hardened with UFW, Fail2Ban, SSH key auth, and automatic security updates
- [15 - IaC Terraform](./15-iac-terraform) — AWS EC2 instance provisioned with Terraform including security group and Elastic IP
- [16 - Configuration Management with Ansible](./16-configuration-management) — Ansible playbook with base, nginx, ssh, and app/github-app roles configuring a Terraform-provisioned EC2 instance
- [17 - Node.js Service Deployment](./17-nodejs-service-deployment) — Terraform-provisioned EC2 instance configured via Ansible, with GitHub Actions automating deployment on every push. App repo: [nodejs-service-deployment](https://github.com/WilliamFly/nodejs-service-deployment)
- [18 - Dockerized Service Deployment](./18-dockerized-service-deployment) — Dockerized Node.js service with Basic Auth, deployed via GitHub Actions to GHCR and a Terraform/Ansible-provisioned EC2 instance. App repo: [dockerized-service-deployment](https://github.com/WilliamFly/dockerized-service-deployment)

## Project URLs (roadmap.sh)

- 01 - Server Stats: https://roadmap.sh/projects/server-stats
- 02 - Log Archive Tool: https://roadmap.sh/projects/log-archive-tool
- 03 - Nginx Log Analyser: https://roadmap.sh/projects/nginx-log-analyser
- 04 - GitHub Pages Deployment: https://roadmap.sh/projects/github-actions-deployment-workflow
- 05 - Basic Dockerfile: https://roadmap.sh/projects/basic-dockerfile
- 06 - Dummy Systemd Service: https://roadmap.sh/projects/dummy-systemd-service
- 07 - Static Site Server: https://roadmap.sh/projects/static-site-server
- 08 - SSH Remote Server Setup: https://roadmap.sh/projects/ssh-remote-server-setup
- 09 - EC2 Instance: https://roadmap.sh/projects/ec2-instance
- 10 - Simple Monitoring: https://roadmap.sh/projects/simple-monitoring-dashboard
- 11 - Basic DNS Setup: https://roadmap.sh/projects/basic-dns
- 12 - Pomodoro Timer: https://roadmap.sh/projects/pomodoro-timer
- 13 - File Integrity Checker: https://roadmap.sh/projects/file-integrity-checker
- 14 - Linux Server Setup: https://roadmap.sh/projects/linux-server-setup
- 15 - IaC Terraform: https://roadmap.sh/projects/iac-digitalocean
- 16 - Configuration Management: https://roadmap.sh/projects/configuration-management
- 17 - Node.js Service Deployment: https://roadmap.sh/projects/nodejs-service-deployment
- 18 - Dockerized Service Deployment: https://roadmap.sh/projects/dockerized-service-deployment

## Live Portfolio
[williammucha.com](https://williammucha.com)
