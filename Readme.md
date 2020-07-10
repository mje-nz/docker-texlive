# TeX Live Docker image
![Build Docker images](https://github.com/mje-nz/docker-texlive/workflows/Build%20Docker%20images/badge.svg)

This repo builds a set of TeX Live images.
There is a CI pipeline which does a clean build once a week.
Each variant is based on Ubuntu (`focal`, `bionic`, or `xenial`) with system Python 3 and just enough pre-requisites to pip-install scipy.
The vanilla variants are available for `2020` and `2019`.

Image variants:

* **`$distro-minimal`**: `ubuntu:$distro` with TeX Live installed through apt without recommended packages
* **`$distro`**: `$distro-minimal` plus recommended packages
* **`$distro-full`**: `ubuntu:$distro` with the `texlive-full` package
* **`$distro-vanilla-$year`**: `ubuntu:$distro` with vanilla TeX Live `$year` installed using the basic scheme plus some extra packages (minus documentation and sources)
* **`$distro-vanilla-$year-full`**: `ubuntu:$distro` with vanilla TeX Live `$year` installed using the full scheme (minus documentation and sources)

Short tags:

* **`latest`** is `focal`
* **`vanilla`** is `focal-vanilla-2020`
* **`$distro-vanilla`** is `$distro-vanilla-2020`
* **`$distro-vanilla-full`** is `$distro-vanilla-2020-full`
