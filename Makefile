NAME := mjenz/texlive

BUILD_BIONIC := build_bionic build_bionic_minimal build_bionic_full build_bionic_vanilla build_bionic_vanilla_2018
BUILD_XENIAL := build_xenial build_xenial_minimal build_xenial_full build_xenial_vanilla build_xenial_vanilla_2018
.PHONY: build build_latest $(BUILD_BIONIC) $(BUILD_XENIAL)
build: build_latest $(BUILD_BIONIC) $(BUILD_XENIAL)

build_latest: Dockerfile
	docker build -t $(NAME) .

build_bionic: Dockerfile
	docker build -t $(NAME):bionic --build-arg IMAGE=ubuntu:bionic .

build_bionic_minimal: Dockerfile
	docker build -t $(NAME):bionic-minimal --build-arg IMAGE=ubuntu:bionic --build-arg TEXLIVE_VERSION=minimal .

build_bionic_full: Dockerfile
	docker build -t $(NAME):bionic-full --build-arg IMAGE=ubuntu:bionic --build-arg TEXLIVE_VERSION=full .

build_bionic_vanilla: Dockerfile
	docker build -t $(NAME):bionic-vanilla --build-arg IMAGE=ubuntu:bionic --build-arg TEXLIVE_VERSION=vanilla .

build_bionic_vanilla_2018: Dockerfile
	docker build -t $(NAME):bionic-vanilla-2018 --build-arg IMAGE=ubuntu:bionic --build-arg TEXLIVE_VERSION=vanilla-2018 .

build_xenial: Dockerfile
	docker build -t $(NAME):xenial --build-arg IMAGE=ubuntu:xenial .

build_xenial_minimal: Dockerfile
	docker build -t $(NAME):xenial-minimal --build-arg IMAGE=ubuntu:xenial  --build-arg TEXLIVE_VERSION=minimal .

build_xenial_full: Dockerfile
	docker build -t $(NAME):xenial-full --build-arg IMAGE=ubuntu:xenial  --build-arg TEXLIVE_VERSION=full .

build_xenial_vanilla: Dockerfile
	docker build -t $(NAME):xenial-vanilla --build-arg IMAGE=ubuntu:xenial  --build-arg TEXLIVE_VERSION=vanilla .

build_xenial_vanilla_2018: Dockerfile
	docker build -t $(NAME):xenial-vanilla-2018 --build-arg IMAGE=ubuntu:xenial  --build-arg TEXLIVE_VERSION=vanilla-2018 .
