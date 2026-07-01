# Dummy Systemd Service

A long-running systemd service that writes a log message every 10 seconds, simulating a background application process.

## Project URL
https://roadmap.sh/projects/dummy-systemd-service

## Files
- `dummy.sh` — script that runs forever, logging every 10 seconds to `/var/log/dummy-service.log`
- `dummy.service` — systemd unit file that manages the script as a service

## Installation
```bash
sudo cp dummy.sh /usr/local/bin/dummy.sh
sudo chmod +x /usr/local/bin/dummy.sh
sudo cp dummy.service /etc/systemd/system/dummy.service
sudo systemctl daemon-reload
```

## Usage
```bash
sudo systemctl start dummy
sudo systemctl stop dummy
sudo systemctl enable dummy
sudo systemctl disable dummy
sudo systemctl status dummy

# Follow logs
sudo journalctl -u dummy -f
tail -f /var/log/dummy-service.log
```

## What it covers
- Writing a systemd unit file
- Managing services with systemctl
- Auto-restart on failure with `Restart=always`
- Monitoring service logs via journalctl
