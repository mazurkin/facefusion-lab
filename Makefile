# model explorer

SHELL := /bin/bash

ROOT  := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

CONDA_ENV_NAME = facefusion

export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1

export FACEFUSION_PROBABILITY_LIMIT=100

# -----------------------------------------------------------------------------
# run
# -----------------------------------------------------------------------------

.DEFAULT_GOAL = run

.PHONY: run
run:
	@conda run --no-capture-output --live-stream --name $(CONDA_ENV_NAME) --cwd facefusion \
		python facefusion.py run

# -----------------------------------------------------------------------------
# conda environment
# -----------------------------------------------------------------------------

.PHONY: env-init
env-init:
	@conda create --yes --name $(CONDA_ENV_NAME) python=3.10.12 conda-forge::cuda-runtime=12.4.1 conda-forge::cudnn=9.2.1.18

.PHONY: env-remove
env-remove:
	@conda env remove --yes --name $(CONDA_ENV_NAME)

.PHONY: env-install
env-install:
	@conda run --no-capture-output --live-stream --name $(CONDA_ENV_NAME) --cwd facefusion \
		python install.py --onnxruntime cuda

.PHONY: env-shell
env-shell:
	@conda run --no-capture-output --live-stream --name $(CONDA_ENV_NAME) --cwd facefusion \
		bash

.PHONY: env-info
env-info:
	@conda run --no-capture-output --live-stream --name $(CONDA_ENV_NAME) --cwd facefusion \
		conda info
