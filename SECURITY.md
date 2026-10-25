# Security Policy

## Supported Versions

Only the **latest image** (`latest`, matching the newest upstream GaggiMate release tag) is supported. Older tags are not rebuilt; pull the current one before reporting.

## Reporting a Vulnerability

**Do not open a public GitHub issue for security vulnerabilities.**

Please open a **[private security advisory](https://github.com/mxkissnr/gaggimate-sim/security/advisories/new)** and include a description, steps to reproduce and the potential impact. I will acknowledge your report within **7 days**.

## What is checked

The `build` workflow runs on every pull request, on each push to `main`, daily and on demand:

- the image is rebuilt daily from the latest upstream release, which picks up base-image security fixes
- a smoke test starts the container and requires the web UI to answer on port 8080
- the image is scanned with Trivy for fixed CRITICAL OS vulnerabilities and the results are uploaded to code scanning
- pull requests build and test the image without pushing; only `main` and scheduled runs publish
- workflows are analysed with CodeQL and OpenSSF Scorecard, and pull requests get a dependency review

## Scope

In scope: this repository's Dockerfile, start script and workflows, and vulnerabilities in the published image that come from its base image or packages. Out of scope: bugs in the GaggiMate firmware or simulator itself (report those [upstream](https://github.com/jniebuhr/gaggimate)). The simulator is meant for local development and testing; do not expose its port to untrusted networks.
