# Nginx Log Analyser

A shell script to analyze nginx access logs from the command line using awk, sort, uniq, and head.

## Project URL
https://roadmap.sh/projects/nginx-log-analyser

## How to run
```bash
chmod +x nginx-log-analyser.sh
./nginx-log-analyser.sh <log-file>
```

## What it does
Parses an nginx access log and outputs:
- Top 5 IP addresses with the most requests
- Top 5 most requested paths
- Top 5 response status codes
- Top 5 user agents

## Sample data
`nginx-access.log` is the sample log file provided by the project (sourced from the roadmap.sh gist) and is included here for reproducibility.
