<p align="center">
  <a href="https://github.com/mxkissnr/gaggimate-sim/pkgs/container/gaggimate-sim">
    <img src="https://img.shields.io/github/v/tag/mxkissnr/gaggimate-sim?color=%23f59e0b&label=Image&style=flat-square" alt="Image tag"/>
  </a>
  <a href="https://github.com/mxkissnr/gaggimate-sim/actions/workflows/build.yml">
    <img src="https://img.shields.io/github/actions/workflow/status/mxkissnr/gaggimate-sim/build.yml?branch=main&label=Build&style=flat-square" alt="Build"/>
  </a>
  <img src="https://img.shields.io/badge/Image%20licence-CC%20BY--NC--SA%204.0-blue?style=flat-square" alt="Image licence CC BY-NC-SA 4.0"/>
  <img src="https://img.shields.io/badge/Built%20with-Claude%20by%20Anthropic-D97706?style=flat-square" alt="Built with Claude"/>
</p>

<h1 align="center">gaggimate-sim</h1>

<p align="center">
  Container image of the official <a href="https://github.com/jniebuhr/gaggimate">GaggiMate</a> desktop simulator (<code>display-sim</code>).<br/>
  It runs the real display firmware natively with a mocked controller, renders to a virtual X display and serves the embedded web UI —<br/>
  handy for UI work, screenshots and testing without hardware. This repository contains no upstream code: the Dockerfile clones GaggiMate at build time.
</p>

<p align="center">
  Part of the <a href="https://github.com/mxkissnr/gaggiuino-local-profiler">GLP ecosystem</a> — used to test GLP against GaggiMate without hardware.
</p>

---

## Usage

```shell
docker run -p 8080:8080 -v gaggimate-sim-data:/sim_data ghcr.io/mxkissnr/gaggimate-sim:latest
```

Open <http://localhost:8080/> for the web UI. Settings, profiles and shot
history persist in the `/sim_data` volume; remove the volume to start fresh.

The simulator also has a screenshot mode (render briefly, write a BMP, exit):

```shell
docker run --rm -v "$PWD:/out" ghcr.io/mxkissnr/gaggimate-sim:latest \
  xvfb-run -a /app/gaggimate-sim --screenshot /out/shot.bmp 4000
```

The last argument is the render delay in milliseconds.

## Tags

Each tag matches an upstream GaggiMate release tag (for example `v1.9.0`);
`latest` points to the newest release. The tag is also stored in the
`gaggimate.ref` image label. Each upstream release also gets a
GitHub release in this repository.

## Rebuilds

The image is rebuilt daily from the latest upstream release. This publishes
new releases within a day and picks up base-image security fixes. Pull
requests build and smoke-test the image without pushing. Every build is
scanned with Trivy and results are uploaded to code scanning.

The workflow can also be started manually with a specific upstream tag.

## Licence and attribution

GaggiMate (c) its authors, <https://github.com/jniebuhr/gaggimate>, licensed
CC BY-NC-SA 4.0. The image contains a build of that work and is distributed
under the same licence, non-commercial use only. This repository's own files
(Dockerfile, workflows) are MIT. See [NOTICE](NOTICE) and [LICENSE](LICENSE).

This project is not affiliated with GaggiMate.
