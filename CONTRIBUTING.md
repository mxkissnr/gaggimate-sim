# Contributing

Bug reports, feature ideas and pull requests are welcome!

## What lives here

This repository only contains the Dockerfile, the start script and the CI workflows that build the [GaggiMate](https://github.com/jniebuhr/gaggimate) desktop simulator image. Problems in the simulator or firmware itself belong in the [upstream repository](https://github.com/jniebuhr/gaggimate).

## Workflow

1. **Open an issue first** — describe the bug or change before writing any code
2. **Fork & branch** — `feature/short-description` or `fix/short-description`
3. **Change the Dockerfile, `start.sh` or the workflow** — keep the diff focused
4. **Pull request** — never push to `main` directly

## Pull requests

Every PR must:

- **Link an issue** — `Closes #N` in the description
- **Use a Conventional Commits title in English** — `feat:` `fix:` `docs:` `chore:` `build:` `ci:`
- **Pass CI** — the `build` workflow builds the image, smoke-tests it and scans it; it must be green before review
- **Disclose AI assistance** — fill in the "AI assistance disclosure" section of the PR template (`none` / `assisted` / `substantial` / `generated` plus the tools and models used). CI blocks the PR until it is filled in, and fails if commits carry an AI `Co-Authored-By:` trailer while the PR claims `none`.
- **No real names** in commit messages, PR text, code comments or docs

## Reporting a bug

Include the image tag, the upstream GaggiMate ref (`gaggimate.ref` label), your `docker run` command and the container logs. Use the issue templates.
