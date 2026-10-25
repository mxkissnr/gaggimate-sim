# CLAUDE.md — gaggimate-sim

Working rules for this repo. Follow these in every session.

## What this is

A container image of the official [GaggiMate](https://github.com/jniebuhr/gaggimate) desktop simulator (`display-sim`). The repo holds no upstream code: only `Dockerfile`, `start.sh` and the workflows. It is used to test GLP against GaggiMate without hardware.

## How the image is built

Two-stage `Dockerfile`: the build stage clones GaggiMate at `GAGGIMATE_REF` (build arg), builds the web UI and runs `pio run -e display-sim`; the runtime stage is `debian:bookworm-slim` with the binary, SDL2, Xvfb and socat. `.github/workflows/build.yml` resolves the latest upstream release (or a manual `ref` input), builds, smoke-tests, scans with Trivy and pushes `ghcr.io/mxkissnr/gaggimate-sim:<tag>` and `:latest` — only on `main`, schedule and manual runs, never on PRs. It also runs daily.

## Upstream build quirks

1. **GCC missing transitive headers** — upstream is developed with clang; `/opt/compat.h` is force-included via `PLATFORMIO_BUILD_FLAGS` in the Dockerfile.
2. **No `src/version.h`** — `display-sim` skips the firmware version script, so the Dockerfile writes `src/version.h` itself.
3. **Web server binds 127.0.0.1** — hard-coded upstream; `start.sh` forwards the container address to it with `socat` so the port can be published.

## Licences

Repo files (Dockerfile, scripts, workflows) are MIT (`LICENSE`). The image contains a build of GaggiMate and is CC BY-NC-SA 4.0, non-commercial (`NOTICE`).

## Dependencies

Renovate bumps the base image digests and the GitHub Action SHA pins (`renovate.json`). `PLATFORMIO_VERSION` is a plain `ARG` that Renovate does **not** bump; update it by hand.

## Rules

- Everything on GitHub (code, comments, commits, issues, PRs) is English. No internal hostnames, IPs, domains or personal names.
- Branch + PR, never push to `main`. Do not merge without green CI.
- PR body comes from `.github/pull_request_template.md` with the AI disclosure filled in (CI enforces it).
- Commit trailer names the specific model, e.g. `Co-Authored-By: Claude Sonnet 5.5 <noreply@anthropic.com>`. Never add session links or session trailers.
