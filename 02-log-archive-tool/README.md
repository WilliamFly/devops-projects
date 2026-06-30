# Log Archive Tool

A CLI tool to archive logs by compressing them into a timestamped `tar.gz` file, useful for cleaning up old logs while keeping them available for future reference.

## Project URL
https://roadmap.sh/projects/log-archive-tool

## How to run
```bash
chmod +x log-archive.sh
./log-archive.sh <log-directory>
```

Example:
```bash
./log-archive.sh /var/log
```

## What it does
- Accepts a log directory as a command-line argument
- Compresses the directory into a `tar.gz` file with a timestamped filename (`logs_archive_YYYYMMDD_HHMMSS.tar.gz`)
- Stores the archive in an `archives/` directory
- Logs the date, time, source directory, and archive path to `archives/archive_log.txt`
