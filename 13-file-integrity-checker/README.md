# File Integrity Checker

A Bash tool that uses SHA-256 hashing to verify the integrity of log files and directories, detecting unauthorized tampering.

## Project URL
https://roadmap.sh/projects/file-integrity-checker

## How to run
```bash
chmod +x integrity-check.sh

# Initialize hashes for a file or directory
./integrity-check.sh init <file-or-directory>

# Check integrity
./integrity-check.sh check <file-or-directory>

# Update hash after legitimate changes
./integrity-check.sh update <file-or-directory>
```

## Examples
```bash
# Single file
./integrity-check.sh init /var/log/syslog
./integrity-check.sh check /var/log/syslog

# Directory
./integrity-check.sh init /var/log
./integrity-check.sh check /var/log
```

## What it covers
- SHA-256 cryptographic hashing via `sha256sum`
- Persistent hash storage in `~/.integrity_hashes`
- Single file and recursive directory scanning
- Clear tamper detection with hash comparison output
- Hash re-initialization via update command
