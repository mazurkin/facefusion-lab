# model explorer

SHELL := /bin/bash

ROOT  := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

CONDA_ENV_NAME = facefusion

export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1

# -----------------------------------------------------------------------------
# run
# -----------------------------------------------------------------------------

.DEFAULT_GOAL = run

.PHONY: run
run:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" --cwd facefusion \
		python3 facefusion.py run

# -----------------------------------------------------------------------------
# conda environment
# -----------------------------------------------------------------------------

.PHONY: env-init
env-init:
	@conda create --yes --name "$(CONDA_ENV_NAME)" \
		python=3.12.12 \
		conda-forge::cuda-runtime=12.4.1 \
		conda-forge::cudnn=9.2.1.18

.PHONY: env-install
env-install:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" --cwd facefusion \
		python3 install.py --onnxruntime cuda

.PHONY: env-remove
env-remove:
	@conda env remove --yes --name "$(CONDA_ENV_NAME)"

.PHONY: env-shell
env-shell:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" --cwd facefusion \
		bash

.PHONY: env-info
env-info:
	@conda run --no-capture-output --live-stream --name "$(CONDA_ENV_NAME)" --cwd facefusion \
		conda info


# -----------------------------------------------------------------------------
# patch management
# -----------------------------------------------------------------------------

.PHONY: patch-make
patch-make:
	@git -C facefusion diff | base64 | gzip > "$(ROOT)/assets/facefusion.patch"

.PHONY: patch-apply
patch-apply:
	@cat "$(ROOT)/assets/facefusion.patch" | gzip -d | base64 -d | git -C facefusion apply -

.PHONY: patch-show
patch-show:
	@cat "$(ROOT)/assets/facefusion.patch" | gzip -d | base64 -d | less
