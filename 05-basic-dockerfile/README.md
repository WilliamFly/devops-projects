# Basic Dockerfile

A minimal Dockerfile using alpine:latest that prints a greeting to the console on run.

## Project URL
https://roadmap.sh/projects/basic-dockerfile

## How to build and run
```bash
docker build -t hello-captain .
docker run hello-captain
# Output: Hello, Captain!

# Stretch goal - custom name
docker build --build-arg NAME=William -t hello-captain .
docker run hello-captain
# Output: Hello, William!
```

## What it covers
- Writing a basic Dockerfile
- Using alpine as a lightweight base image
- CMD instruction for container startup behavior
- ARG instruction for build-time variables
