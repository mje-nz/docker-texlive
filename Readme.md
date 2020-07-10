# TeX Live Docker image
![Build Docker images](https://github.com/mje-nz/docker-texlive/workflows/Build%20Docker%20images/badge.svg)

This repo builds a series of TeX Live images.
There is a CI pipeline which does a clean build once a week.
Each variant is available for `focal`, `bionic`, and `xenial`, and consists of an Ubuntu base image with system Python 3 and the latest matplotlib, numpy, and seaborn from pip.

Image variants:

* **`$distro-minimal`**: `ubuntu:$distro` with TeX Live installed through apt without recommended packages
* **`$distro`**: `$distro-minimal` plus recommended packages
* **`$distro-full`**: `ubuntu:$distro` with a the `texlive-full` package
* **`$distro-vanilla-$year`**: `ubuntu:$distro` with vanilla TeX live `$year` installed using the `basic` scheme plus some extra packages
* **`$distro-vanilla-$year-full`**: `ubuntu:$distro` with vanilla TeX Live `$year` installed using the `full` scheme

Short tags:

* **`latest`** is `focal`
* **`$distro-vanilla`** is `$distro-vanilla-2020`
* **`$distro-vanilla-full`** is `$distro-vanilla-2020-full`
* **`vanilla`** is `focal-vanilla`
