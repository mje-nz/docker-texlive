# TeX Live Docker image
![Build Docker images](https://github.com/mje-nz/docker-texlive/workflows/Build%20Docker%20images/badge.svg)

This repo builds a set of TeX Live images.
There is a CI pipeline which does a clean build once a week.
Each variant is based on Ubuntu (`focal`, `bionic`, or `xenial`) with system Python 3 and just enough pre-requisites to pip-install scipy.
The vanilla variants are available for `2021`, `2020` and `2019`.

Image variants:

* **`$distro-basic`**: `ubuntu:$distro` with TeX Live installed through apt without recommended packages
* **`$distro`**: `$distro-basic` plus recommended packages
* **`$distro-full`**: `ubuntu:$distro` with the `texlive-full` package
* **`$distro-vanilla-$year-basic`**: `ubuntu:$distro` with vanilla TeX Live `$year` installed using the basic scheme (minus documentation and sources)
* **`$distro-vanilla-$year`**: `$distro-vanilla-$year-basic` plus basically all the LaTeX packages except extra fonts and non-English languages (minus documentation and sources)
* **`$distro-vanilla-$year-full`**: `$distro-vanilla-$year` plus the rest of TeX Live (minus documentation and sources)

Short tags:

* **`basic`** is `focal-basic`
* **`latest`** is `focal`
* **`full`** is `focal-full`
* **`vanilla-basic`** is `focal-vanilla-2021-basic`
* **`vanilla`** is `focal-vanilla-2021`
* **`vanilla-full`** is `focal-vanilla-2021-full`
* **`$distro-vanilla-basic`** is `$distro-vanilla-2021-basic`
* **`$distro-vanilla`** is `$distro-vanilla-2021`
* **`$distro-vanilla-full`** is `$distro-vanilla-2021-full`



TODO:

* Add v8r
