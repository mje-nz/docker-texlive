# Tex Live Docker image

This repo builds a series of TeX Live images.
Each variant is available for `focal`, `bionic`, and `xenial`, and consists of an Ubuntu base image with system Python 3 and matplotlib, numpy and seaborn from pip.

Variants:

* **`$distro-minimal`**: `ubuntu:$distro` with TeX Live installed through apt without recommended packages
* **`$distro`**: `$distro-minimal` plus recommended packages
* **`$distro-vanilla`**: `ubuntu:$distro` with vanilla TeX live installed using the `basic` scheme plus some extra packages
* **`$distro-vanilla-full`**, : `ubuntu:$distro` with vanilla TeX Live installed using the `full` scheme
* **`$distro-vanilla-2019`**: same as `$distro-vanilla` but with TeX Live 2019
* **`$distro-vanilla-2019-full`**: same as `$distro-vanilla-full` but with TeX Live 2019

Abbreviated tags:

* **`latest`** is `focal`
* **`$distro-vanilla`** is `$distro-vanilla-2020`
* **`vanilla`** is `focal-vanilla`
